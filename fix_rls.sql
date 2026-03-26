-- ================================================================
-- 脑瓜子 紧急修复 — 数据隔离
-- 在 Supabase Dashboard → SQL Editor 中执行
-- ================================================================

-- 1. 先把所有 user_id 为 NULL 的旧记录关联到你
UPDATE entries SET user_id = 'e9440115-3fb3-4e19-9935-4e4fb142ce8a' WHERE user_id IS NULL;

-- 2. 让 user_id 变成 NOT NULL（防止以后再出现无主记录）
ALTER TABLE entries ALTER COLUMN user_id SET NOT NULL;

-- 3. 删除所有现有 RLS 策略（彻底清除，包括可能残留的旧策略）
DO $$
DECLARE
  pol RECORD;
BEGIN
  FOR pol IN 
    SELECT policyname FROM pg_policies WHERE tablename = 'entries'
  LOOP
    EXECUTE format('DROP POLICY IF EXISTS %I ON entries', pol.policyname);
  END LOOP;
END $$;

-- 4. 确保 RLS 开启
ALTER TABLE entries ENABLE ROW LEVEL SECURITY;

-- 5. 重建严格的 RLS 策略
CREATE POLICY "users_select_own" ON entries FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "users_insert_own" ON entries FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "users_update_own" ON entries FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "users_delete_own" ON entries FOR DELETE
  USING (auth.uid() = user_id);

-- 6. 强制要求 RLS 对表所有者也生效（Supabase 默认 anon/authenticated 已受 RLS 约束，但加上更保险）
ALTER TABLE entries FORCE ROW LEVEL SECURITY;

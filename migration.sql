-- ================================================================
-- 随手记 多用户改造 — Supabase 数据库迁移
-- ================================================================
-- 在 Supabase Dashboard → SQL Editor 中执行此脚本
-- 注意：执行前请先在 Authentication → Settings 中确认 Email Auth 已启用

-- 1. 给 entries 表添加 user_id 字段（关联 auth.users）
ALTER TABLE entries
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id);

-- 2. 将现有记录关联到第一个注册的用户（你自己）
-- ⚠️ 请在注册完账号后，用你的 user_id 替换下面的占位符，再执行这条
-- UPDATE entries SET user_id = 'YOUR_USER_ID_HERE' WHERE user_id IS NULL;

-- 3. 创建索引加速按用户查询
CREATE INDEX IF NOT EXISTS idx_entries_user_id ON entries(user_id);
CREATE INDEX IF NOT EXISTS idx_entries_user_created ON entries(user_id, created_at DESC);

-- 4. 删除旧的 RLS 策略（之前是 USING(true) 全开放）
DROP POLICY IF EXISTS "Allow all" ON entries;
DROP POLICY IF EXISTS "Allow all access" ON entries;
DROP POLICY IF EXISTS "Enable read access for all users" ON entries;
DROP POLICY IF EXISTS "Enable insert for all users" ON entries;
DROP POLICY IF EXISTS "Enable update for all users" ON entries;
DROP POLICY IF EXISTS "Enable delete for all users" ON entries;

-- 5. 确保 RLS 开启
ALTER TABLE entries ENABLE ROW LEVEL SECURITY;

-- 6. 创建新的 RLS 策略 — 每个用户只能操作自己的数据
CREATE POLICY "Users can view own entries"
  ON entries FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own entries"
  ON entries FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own entries"
  ON entries FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own entries"
  ON entries FOR DELETE
  USING (auth.uid() = user_id);

-- 7. 可选：让 user_id 在新插入时自动填充为当前用户
ALTER TABLE entries ALTER COLUMN user_id SET DEFAULT auth.uid();

-- ================================================================
-- 执行完毕后，所有新记录会自动关联到登录用户
-- 老数据需要手动关联（步骤 2）
-- ================================================================

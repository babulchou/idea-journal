-- ============================================================
-- 脑瓜子 Buzzy — 用户昵称系统 + 邮箱验证
-- 在 Supabase Dashboard → SQL Editor 中执行
-- ============================================================

-- 1. 创建 user_profiles 表
CREATE TABLE IF NOT EXISTS user_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  nickname TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  
  -- 每个用户只能有一个 profile
  CONSTRAINT user_profiles_user_id_unique UNIQUE (user_id),
  -- 昵称唯一（大小写不敏感）
  CONSTRAINT user_profiles_nickname_unique UNIQUE (nickname),
  -- 昵称长度限制：2-12 个字符
  CONSTRAINT user_profiles_nickname_length CHECK (char_length(nickname) >= 2 AND char_length(nickname) <= 12),
  -- 昵称不能是纯空格
  CONSTRAINT user_profiles_nickname_not_blank CHECK (trim(nickname) != '')
);

-- 2. 创建大小写不敏感的唯一索引（防止 "ABC" 和 "abc" 重复）
CREATE UNIQUE INDEX IF NOT EXISTS user_profiles_nickname_lower_idx 
  ON user_profiles (lower(nickname));

-- 3. 启用 RLS
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- 4. RLS 策略

-- 所有人可以查看昵称（用于唯一性检查 + 显示）
CREATE POLICY "Anyone can read profiles" ON user_profiles
  FOR SELECT USING (true);

-- 用户只能插入自己的 profile
CREATE POLICY "Users can insert own profile" ON user_profiles
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 用户只能更新自己的 profile
CREATE POLICY "Users can update own profile" ON user_profiles
  FOR UPDATE USING (auth.uid() = user_id);

-- 5. 给已有用户补充 profile（可选，手动执行）
-- 如果已有老用户没有 profile，可以用下面的 SQL 批量补充：
-- INSERT INTO user_profiles (user_id, nickname)
-- SELECT id, split_part(email, '@', 1)
-- FROM auth.users
-- WHERE id NOT IN (SELECT user_id FROM user_profiles)
-- ON CONFLICT DO NOTHING;

-- ============================================================
-- ⚠️ 还需要在 Supabase Dashboard 手动操作：
-- 
-- 1. 开启邮箱验证：
--    Authentication → Settings → Auth Settings → "Confirm email" → 开启
-- 
-- 2. （可选）自定义确认邮件模板：
--    Authentication → Email Templates → "Confirm signup"
--    可以改成中文内容
-- ============================================================

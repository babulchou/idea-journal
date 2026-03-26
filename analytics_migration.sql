-- ============================================================
-- 脑瓜子 Buzzy — 埋点 & 反馈系统 数据库迁移
-- 执行位置：Supabase Dashboard → SQL Editor
-- ============================================================

-- 1. 埋点事件表
CREATE TABLE IF NOT EXISTS analytics_events (
  id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id     uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  event       text NOT NULL,              -- 事件名：page_view, btn_click, feature_use ...
  category    text NOT NULL DEFAULT '',   -- 分类：navigation, compose, review, insight, todo, auth
  label       text DEFAULT '',            -- 具体标签：submit_btn, ask_send, tab_compose ...
  value       numeric DEFAULT 0,          -- 数值：停留时长(ms)、次数等
  page        text DEFAULT '',            -- 当前页面：compose, list, todo, admin
  metadata    jsonb DEFAULT '{}',         -- 扩展字段（设备信息、自定义参数等）
  session_id  text DEFAULT '',            -- 会话ID，用于串联同次访问的事件
  created_at  timestamptz DEFAULT now()
);

-- 索引：按用户、事件、时间查询
CREATE INDEX IF NOT EXISTS idx_ae_user_id    ON analytics_events(user_id);
CREATE INDEX IF NOT EXISTS idx_ae_event      ON analytics_events(event);
CREATE INDEX IF NOT EXISTS idx_ae_created_at ON analytics_events(created_at);
CREATE INDEX IF NOT EXISTS idx_ae_category   ON analytics_events(category);
CREATE INDEX IF NOT EXISTS idx_ae_session    ON analytics_events(session_id);

-- RLS：用户只能写自己的事件，admin 可读全部
ALTER TABLE analytics_events ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can insert own events" ON analytics_events
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can read own events" ON analytics_events
  FOR SELECT USING (auth.uid() = user_id);


-- 2. 用户反馈表
CREATE TABLE IF NOT EXISTS user_feedback (
  id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id     uuid REFERENCES auth.users(id) ON DELETE SET NULL,
  content     text NOT NULL,              -- 反馈文字
  screenshot  text DEFAULT '',            -- 截图 base64（dataURL）
  logs        jsonb DEFAULT '[]',         -- 提交时附带的最近控制台日志
  page        text DEFAULT '',            -- 提交时所在页面
  ua          text DEFAULT '',            -- User-Agent
  screen_size text DEFAULT '',            -- 屏幕尺寸
  status      text DEFAULT 'pending',     -- pending / read / resolved
  admin_note  text DEFAULT '',            -- 管理员备注
  created_at  timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_uf_user_id    ON user_feedback(user_id);
CREATE INDEX IF NOT EXISTS idx_uf_status     ON user_feedback(status);
CREATE INDEX IF NOT EXISTS idx_uf_created_at ON user_feedback(created_at);

ALTER TABLE user_feedback ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can insert own feedback" ON user_feedback
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can read own feedback" ON user_feedback
  FOR SELECT USING (auth.uid() = user_id);


-- 3. 给 admin 用户的全量读取策略
-- 注意：需要先在 Supabase Dashboard 设置你的用户为 admin
-- 方法1: 在 auth.users 的 raw_user_meta_data 中加 {"role":"admin"}
-- 方法2: 创建 admin 表（更灵活）

CREATE TABLE IF NOT EXISTS admin_users (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE
);

-- Admin 可读取所有埋点事件
CREATE POLICY "Admin can read all events" ON analytics_events
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM admin_users WHERE admin_users.user_id = auth.uid())
  );

-- Admin 可读取所有反馈
CREATE POLICY "Admin can read all feedback" ON user_feedback
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM admin_users WHERE admin_users.user_id = auth.uid())
  );

-- Admin 可更新反馈状态
CREATE POLICY "Admin can update feedback" ON user_feedback
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM admin_users WHERE admin_users.user_id = auth.uid())
  );

-- ============================================================
-- 执行完成后，手动把你自己的 user_id 加入 admin_users：
-- INSERT INTO admin_users (user_id) VALUES ('你的-user-id-在-auth.users-表里');
-- ============================================================

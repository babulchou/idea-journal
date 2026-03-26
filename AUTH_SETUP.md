# 脑瓜子 Buzzy — 多用户认证部署指南

## 概述

本次改造给脑瓜子加了 **Supabase Auth 用户认证**，实现：
- 注册 / 登录 / 退出
- **邮箱验证** — 注册后必须去邮箱点确认链接才能登录
- **昵称系统** — 注册时填写昵称，含违禁词过滤 + 唯一性检查
- 每个用户只能看到自己的数据（RLS 数据隔离）
- 现有数据可以关联到你的账号

## 部署步骤

### Step 1: Supabase 配置（5 分钟）

1. 打开 [Supabase Dashboard](https://supabase.com/dashboard) → 你的项目

2. **启用 Email Auth**（一般已默认开启）：
   - 进入 **Authentication** → **Providers**
   - 确认 **Email** 是启用状态

3. **⚠️ 开启邮箱验证**：
   - 进入 **Authentication** → **Settings** → **Auth Settings**
   - 找到 **"Confirm email"**，**开启**它
   - 这样用户注册后必须去邮箱点确认链接才能登录

4. **（可选）自定义确认邮件模板**：
   - 进入 **Authentication** → **Email Templates** → **"Confirm signup"**
   - 可以改成中文内容，例如：
   ```
   主题：🐝 脑瓜子 — 确认你的邮箱
   内容：点击下面的链接确认你的邮箱：{{ .ConfirmationURL }}
   ```

5. **执行数据库迁移**：
   - 进入 **SQL Editor**
   - 先执行 `migration.sql`（如果还没执行过）
   - 再执行 `nickname_migration.sql`（创建 user_profiles 表）
   - ⚠️ 先不要执行 Step 2（`UPDATE entries SET user_id = ...`），等注册完再做

### Step 2: 注册你的账号 + 关联老数据

1. 部署前端后，打开你的随手记页面
2. 点「注册」，用你的邮箱注册账号
3. 登录成功后，在 Supabase Dashboard → **Authentication** → **Users** 中找到你的 user_id
4. 回到 **SQL Editor**，执行：

```sql
UPDATE entries SET user_id = '你的user_id' WHERE user_id IS NULL;
```

这会把所有现有记录关联到你的账号。

### Step 3: 部署前端

```bash
cd idea-journal-web
./deploy.sh
```

### Step 4: 分享给朋友

直接把你的 GitHub Pages 地址发给朋友，让他们自己注册账号就行。每个人的数据完全隔离。

## 注意事项

- 如果开启了邮箱确认，注册后需要去邮箱点链接才能登录
- Supabase 免费版支持最多 50,000 月活用户，足够用了
- 后端 API（链接解析、灵感碰撞、AI 问答）是公共服务，不需要用户认证
- 数据安全由 Supabase RLS（行级安全策略）保障，每个用户只能增删改查自己的数据

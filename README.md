# 💡 随手记 — 你的第二大脑

> **一句话就够了。** 打开，写下，它帮你整理。

[![在线体验](https://img.shields.io/badge/🚀_在线体验-点击打开-blue?style=for-the-badge)](https://babulchou.github.io/idea-journal/)
[![PWA](https://img.shields.io/badge/PWA-支持离线-green?style=flat-square)](https://babulchou.github.io/idea-journal/)
[![GitHub Pages](https://img.shields.io/badge/部署-GitHub_Pages-222?style=flat-square&logo=github)](https://github.com/babulchou/idea-journal)

<p align="center">
  <br>
  <strong>📱 手机打开即用 · 🖥️ 电脑同样好用 · ✈️ 单文件零依赖</strong>
  <br><br>
</p>

---

## 为什么需要随手记？

脑子里闪过一个灵感，3 秒后就忘了。

打开备忘录？太慢。发到微信？找不到了。写进笔记软件？太重了。

**随手记只做一件事：让你在 1 秒内把想法捕捉下来。** 剩下的——分类、标签、链接解析、AI 碰撞——全部自动搞定。

---

## ✨ 核心功能

### 📝 极速记录
打开就写，不用选分类，不用填标题。输入文字后，AI 自动识别这是**想法**、**灵感**、**待办**、**摘录**、**链接**、**感悟**还是**产品 idea**。

### 🔗 链接秒解析
粘贴一个链接（小红书、B站、知乎、微博……），自动抓取标题和摘要，不用手动备注。

### ⚡ 灵感碰撞
每记录一条内容，AI 会自动从你**所有历史记录**中寻找关联，碰撞出新的灵感。你写的越多，碰撞越精彩。

### 🧠 AI 回顾助手
在回顾页提问："我最近关注什么？" "上周有哪些产品想法？"——AI 从你的记录中总结回答，点击引用直接跳转到原文。

### ✅ 待办管理
直接写 "明天 9 点开会"，自动识别为待办。回顾页有专属待办面板，勾选完成，进度一目了然。

### 🏷️ 智能标签
AI 自动提取关键词生成标签，也可以手动编辑。标签云可视化，一眼看到你的思考脉络。

---

## 📱 使用方式

**无需下载、无需注册，打开就能用：**

👉 **https://babulchou.github.io/idea-journal/**

| 方式 | 说明 |
|------|------|
| **手机浏览器** | Safari/Chrome 打开链接即用 |
| **添加到主屏** | Safari → 分享 → 添加到主屏幕，像原生 App 一样 |
| **电脑浏览器** | Chrome/Edge 打开同样好用 |

> 💡 **小技巧**：iOS 添加到主屏幕后，全屏无地址栏，体验和原生 App 一模一样。

---

## 🛠️ 技术亮点

- **单文件架构** — 一个 `index.html` 包含全部前端代码，没有构建步骤，没有框架依赖
- **PWA 支持** — 可安装到主屏幕，支持离线访问
- **暗黑模式** — iOS 风格深色 UI，夜间使用对眼睛友好
- **Supabase 后端** — 数据云端同步，多设备无缝切换
- **AI 驱动** — 智能分类 + 灵感碰撞 + 回顾问答，全部接入大模型
- **多平台链接解析** — 小红书、B站、知乎、微博、公众号等主流平台

---

## 🏗️ 项目结构

```
idea-journal/          ← 你正在看的仓库（前端 PWA）
  └── index.html       ← 就这一个文件

link-parser-api/       ← 后端 API（链接解析 + AI 能力）
  └── server.py        ← FastAPI + GLM-4-Flash
```

| 组件 | 技术栈 | 部署 |
|------|--------|------|
| 前端 | 原生 HTML/CSS/JS + Supabase SDK | GitHub Pages |
| 后端 | Python FastAPI + httpx | Render (免费) |
| 数据库 | Supabase (PostgreSQL) | Supabase Cloud |
| AI | 智谱 GLM-4-Flash (免费) | — |

---

## 🚀 自部署

想要自己搭一个？超简单：

```bash
# 1. Fork 这个仓库
# 2. 开启 GitHub Pages (Settings → Pages → main branch)
# 3. 创建 Supabase 项目，建表（见 supabase-setup.sql）
# 4. 修改 index.html 中的 SUPABASE_URL 和 SUPABASE_ANON_KEY
# 5. 完成！
```

后端 AI 能力（链接解析、灵感碰撞、AI 问答）需要额外部署 [link-parser-api](https://github.com/babulchou/link-parser-api)，不部署也不影响核心记录功能。

---

## 📖 设计理念

> **记录的门槛应该为零。**

大多数笔记工具追求功能全面、结构完善，但牺牲了"随手"的体感。随手记反其道而行——

- **不需要标题**，因为灵感没有标题
- **不需要文件夹**，因为思绪没有边界
- **不需要选分类**，因为 AI 比你更快
- **不需要整理**，因为回顾时 AI 帮你总结

你要做的只有一件事：**把脑子里的东西写下来。**

---

## 🤝 贡献

欢迎 Issue 和 PR！特别欢迎：
- 🐛 Bug 反馈
- 💡 功能建议
- 🌍 多语言支持
- 📱 UI/UX 优化

---

## 📜 License

MIT

---

<p align="center">
  <strong>如果觉得有用，点个 ⭐ 支持一下 :)</strong>
  <br><br>
  Made with 💡 by <a href="https://github.com/babulchou">@babulchou</a>
</p>

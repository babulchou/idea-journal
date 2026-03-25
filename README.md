# 🐝 脑瓜子 Buzzy — ADHD 友好的外脑

> **想法冒出来的时候，打开，写下，完事。**
> 
> 不用选分类，不用起标题，不用打开那个永远不会整理的备忘录。

[![在线体验](https://img.shields.io/badge/🚀_在线体验-打开就用-blue?style=for-the-badge)](https://babulchou.github.io/idea-journal/)
[![PWA](https://img.shields.io/badge/PWA-可装主屏-green?style=flat-square)](https://babulchou.github.io/idea-journal/)
[![GitHub Pages](https://img.shields.io/badge/部署-GitHub_Pages-222?style=flat-square&logo=github)](https://github.com/babulchou/idea-journal)

[English](#-buzzy--an-adhd-friendly-external-brain) | 中文

---

## 这是给谁做的？

你是不是这样的人——

🧠 **脑子永远在转。** 走路时、洗澡时、开会时，想法不断冒出来。

📱 **但从来不会整理。** 打开备忘录写了第一行就关了，微信"文件传输助手"里堆了 300 条自己都看不懂的碎片。

😩 **知道自己该记下来，但每次打开笔记软件都觉得好重。** 要建文件夹、要选标签、要想标题……算了不记了。

**脑瓜子就是为你做的。**

它不是 Notion，不是 Obsidian，不追求体系化管理。它只做一件事：**让你 1 秒把脑子里的东西倒出来，剩下的全部交给它。**

---

## ✨ 它能帮你做什么

### 📝 打开就写
没有启动页，没有欢迎弹窗。打开 → 输入 → 发送。就像发一条消息给自己。

### 🤖 AI 自动分类
你只管写，它自动判断这是**想法**、**灵感**、**待办**、**链接**、**摘录**还是**产品 idea**。不用你动一根手指。

### 🔗 粘个链接就行
看到小红书/B站/知乎/微博有意思的内容？粘贴链接，自动抓取标题和摘要。再也不用"先收藏等下看"（然后永远不看）。

### ⚡ 灵感碰撞
每次记录后，AI 会把你这条和过去所有记录做关联碰撞。你写了 "想做读书笔记工具"，它会帮你想起三个月前那条 "阅读时总是忘记标注"。越记越有趣。

### 🔍 AI 回顾
"我最近在关注什么？" "上周记了哪些产品想法？"——AI 从你所有记录里总结回答，引用的记录可以点击直接跳过去看原文。

### ✅ 写一句话就是待办
写 "明天开会" 自动识别成待办，有专属面板，可以勾选完成。

---

## 📱 怎么用

**零下载、零注册、零配置：**

👉 **https://babulchou.github.io/idea-journal/**

手机浏览器打开就能用。想更爽？**添加到主屏幕**，像原生 App 一样全屏使用，没有地址栏。

> iOS: Safari → 分享 → 添加到主屏幕
> Android: Chrome → 菜单 → 添加到主屏幕

电脑也能用，体验一样。

---

## 🧩 设计哲学

> **记录的门槛应该是零。**

大多数笔记工具在追求"强大"，但 ADHD 的人需要的不是强大——需要的是**够轻**。

- **不要标题** — 灵感没有标题
- **不要文件夹** — 思绪没有边界
- **不要选分类** — AI 比你更快
- **不要整理** — 回顾的时候 AI 帮你总结
- **不要登录** — 打开就写（想同步再注册）

你要做的只有一件事：**把脑子里的东西倒出来。**

---

## 🛠️ 技术细节

- **单文件前端** — 一个 `index.html` 搞定，没有构建、没有框架、没有 node_modules
- **PWA 支持** — 装到主屏，离线可用
- **Supabase** — 数据云端同步，多设备无缝切换
- **AI 引擎** — 智谱 GLM-4-Flash（免费），驱动分类 + 碰撞 + 回顾
- **后端** — Python FastAPI，部署在 Render 免费版

| 组件 | 技术栈 | 部署 |
|------|--------|------|
| 前端 | 原生 HTML/CSS/JS + Supabase SDK | GitHub Pages |
| 后端 | Python FastAPI + GLM-4-Flash | Render |
| 数据库 | Supabase (PostgreSQL) | Supabase Cloud |

后端仓库：[link-parser-api](https://github.com/babulchou/link-parser-api)

---

## 🚀 自己搭一个

```bash
# 1. Fork 这个仓库
# 2. 开启 GitHub Pages（Settings → Pages → main branch）
# 3. 创建 Supabase 项目，建表
# 4. 改 index.html 里的 SUPABASE_URL 和 SUPABASE_ANON_KEY
# 5. 完事
```

后端 AI 功能需要额外部署 [link-parser-api](https://github.com/babulchou/link-parser-api)，不部署也不影响核心记录功能。

---

## 🤝 参与

欢迎 Issue 和 PR。特别欢迎：
- 🐛 Bug 反馈
- 💡 "要是有这个功能就好了"
- 📱 UI/UX 改进

---

---

# 🐝 Buzzy — An ADHD-Friendly External Brain

> **When a thought pops up — open, type, done.**
>
> No categories to pick. No titles to write. No organizing ever.

[![Try it](https://img.shields.io/badge/🚀_Try_it-Live_Demo-blue?style=for-the-badge)](https://babulchou.github.io/idea-journal/)
[![PWA](https://img.shields.io/badge/PWA-Installable-green?style=flat-square)](https://babulchou.github.io/idea-journal/)

[中文](#-脑瓜子-buzzy--adhd-友好的外脑) | English

---

## Who is this for?

Does this sound like you?

🧠 **Your brain never shuts up.** Ideas pop up while walking, showering, sitting in meetings.

📱 **But you never organize anything.** Your notes app has one line from 3 months ago. Your chat-with-self is a graveyard of random thoughts you'll never find again.

😩 **Every note-taking app feels too heavy.** Folders? Tags? Templates? You just wanted to write one sentence.

**Buzzy is built for you.**

It's not Notion. It's not Obsidian. It doesn't try to be a "system." It does one thing: **lets you dump what's in your head in 1 second. It handles the rest.**

---

## ✨ What it does

### 📝 Open and write
No splash screen, no onboarding. Open → type → send. Like texting yourself.

### 🤖 AI auto-categorization
Just write. Buzzy figures out if it's a **thought**, **inspiration**, **todo**, **link**, **quote**, or **product idea**. Zero effort from you.

### 🔗 Paste a link, done
See something interesting on social media? Paste the link — Buzzy auto-extracts the title and summary. No more "save for later" (that you never read).

### ⚡ Inspiration collision
After each entry, AI finds connections across your entire history. You write "want to build a reading tool" and it reminds you of that note from 3 months ago: "I always forget to highlight when reading." The more you write, the better it gets.

### 🔍 AI-powered review
Ask "What have I been thinking about lately?" or "What product ideas did I have last week?" — AI summarizes from all your records, with clickable references that jump to the original entry.

### ✅ One-line todos
Write "meeting tomorrow" and it's auto-detected as a todo. Dedicated panel, checkbox to complete.

---

## 📱 How to use

**Zero download. Zero signup. Zero config.**

👉 **https://babulchou.github.io/idea-journal/**

Open in your phone's browser. For the full experience, **Add to Home Screen** — it runs fullscreen like a native app.

> iOS: Safari → Share → Add to Home Screen
> Android: Chrome → Menu → Add to Home Screen

Works great on desktop too.

---

## 🧩 Design philosophy

> **The barrier to capture a thought should be zero.**

Most note apps chase "powerful." But ADHD brains don't need powerful — they need **effortless**.

- **No titles** — ideas don't have titles
- **No folders** — thoughts don't have boundaries
- **No manual categories** — AI is faster than you
- **No organizing** — AI summarizes when you review
- **No login required** — just write (sign up later if you want sync)

Your only job: **get it out of your head.**

---

## 🛠️ Tech stack

- **Single-file frontend** — one `index.html`, no build step, no framework, no node_modules
- **PWA** — installable, works offline
- **Supabase** — cloud sync across devices
- **AI** — GLM-4-Flash (free) for categorization, inspiration, and review
- **Backend** — Python FastAPI on Render (free tier)

| Component | Stack | Hosting |
|-----------|-------|---------|
| Frontend | Vanilla HTML/CSS/JS + Supabase SDK | GitHub Pages |
| Backend | Python FastAPI + GLM-4-Flash | Render |
| Database | Supabase (PostgreSQL) | Supabase Cloud |

Backend repo: [link-parser-api](https://github.com/babulchou/link-parser-api)

---

## 🚀 Self-host

```bash
# 1. Fork this repo
# 2. Enable GitHub Pages (Settings → Pages → main branch)
# 3. Create a Supabase project and set up tables
# 4. Update SUPABASE_URL and SUPABASE_ANON_KEY in index.html
# 5. Done
```

AI features (link parsing, inspiration, AI review) require deploying [link-parser-api](https://github.com/babulchou/link-parser-api) separately. Core recording works without it.

---

## 🤝 Contributing

Issues and PRs welcome! Especially:
- 🐛 Bug reports
- 💡 Feature ideas
- 🌍 i18n / translations
- 📱 UI/UX improvements

---

## 📜 License

MIT

---

<p align="center">
  <strong>如果你也是那种"想法很多但从来不记"的人，试试看。</strong>
  <br>
  <strong>If you're the type who has a million ideas but never writes them down — give it a try.</strong>
  <br>
  <strong>觉得有用？点个 ⭐ / Found it useful? Drop a ⭐</strong>
  <br><br>
  Made with 🐝 by <a href="https://github.com/babulchou">@babulchou</a>
</p>

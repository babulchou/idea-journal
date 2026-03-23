#!/bin/bash
set -e

echo "========================================="
echo "  随手记 - 一键部署到 GitHub Pages"
echo "========================================="
echo ""

# Step 1: Check gh login
if ! gh auth status &>/dev/null; then
  echo "⏳ 正在打开浏览器登录 GitHub..."
  gh auth login --web --git-protocol https
fi

echo "✅ GitHub 已登录"

# Step 2: Get GitHub username
USERNAME=$(gh api user -q .login)
echo "📌 GitHub 用户: $USERNAME"

# Step 3: Create repo (if not exists)
REPO_NAME="idea-journal"
if gh repo view "$USERNAME/$REPO_NAME" &>/dev/null; then
  echo "📦 仓库已存在，更新代码..."
else
  echo "📦 创建仓库 $REPO_NAME..."
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
fi

# Step 4: Configure git and push
git config user.name "$USERNAME"
git config user.email "$USERNAME@users.noreply.github.com"

# Set remote (in case repo already existed)
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/$USERNAME/$REPO_NAME.git"
git branch -M main
git push -u origin main --force

echo "✅ 代码已推送"

# Step 5: Enable GitHub Pages
echo "🌐 开启 GitHub Pages..."
gh api -X POST "repos/$USERNAME/$REPO_NAME/pages" \
  -f "build_type=legacy" \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || \
gh api -X PUT "repos/$USERNAME/$REPO_NAME/pages" \
  -f "build_type=legacy" \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || true

echo ""
echo "========================================="
echo "  🎉 部署完成！"
echo ""
echo "  你的页面地址："
echo "  https://$USERNAME.github.io/$REPO_NAME/"
echo ""
echo "  ⏰ 首次部署需要 1-2 分钟生效"
echo "  📱 手机打开上面的地址就能用"
echo "  🏠 Safari 里「添加到主屏幕」体验更好"
echo "========================================="

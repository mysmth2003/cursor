# Cursor Website - GitHub 自动部署项目

本项目已配置好 GitHub Actions 自动部署到 AWS Amplify 或 Vercel。

## 📁 项目结构

```
cursor-website/
├── index.html          # 主页面
├── style.css          # 样式文件
├── app.js             # JavaScript 文件
├── .gitignore         # Git 忽略文件配置
├── amplify.yml        # AWS Amplify 部署配置
├── vercel.json        # Vercel 部署配置（备选）
├── .github/
│   └── workflows/
│       └── auto-deploy.yml  # GitHub Actions 自动部署工作流
├── DEPLOYMENT_GUIDE.md      # 详细部署指南
├── quick-deploy.ps1         # 快速部署脚本
└── README.md                # 本文件
```

## 🚀 快速开始

### 方法1：使用快速脚本（推荐）

```powershell
cd "C:\Users\Louis Lu\cursor-website"
.\quick-deploy.ps1
```

### 方法2：手动执行

详细步骤请查看 [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)

## 📋 部署流程

1. **本地准备**
   - 安装 Git
   - 配置 Git 用户名和邮箱
   - 初始化 Git 仓库

2. **GitHub 设置**
   - 创建 GitHub 仓库
   - 推送代码到 GitHub
   - 配置 GitHub Secrets（AWS/Vercel 密钥）

3. **平台连接**
   - 在 AWS Amplify 或 Vercel 连接 GitHub 仓库
   - 选择 main 分支
   - 自动部署

4. **自动部署**
   - 每次 `git push` 到 main 分支
   - GitHub Actions 自动触发部署
   - 无需手动操作

## 🔧 配置文件说明

### `.gitignore`
排除不需要上传的文件，如 node_modules、.env 等。

### `amplify.yml`
AWS Amplify 部署配置，定义构建和部署步骤。

### `vercel.json`
Vercel 部署配置，定义路由和构建设置。

### `.github/workflows/auto-deploy.yml`
GitHub Actions 工作流，自动部署配置。

## 🔐 GitHub Secrets 配置

### AWS Amplify 需要：
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`（可选）
- `AMPLIFY_APP_ID`

### Vercel 需要：
- `VERCEL_TOKEN`
- `VERCEL_ORG_ID`
- `VERCEL_PROJECT_ID`

## 📝 更新代码

```powershell
# 1. 修改代码
# 2. 提交更改
git add .
git commit -m "描述您的更改"
# 3. 推送到 GitHub（自动触发部署）
git push origin main
```

## 🆘 获取帮助

- 查看详细部署指南：[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)
- GitHub Actions 日志：仓库 → Actions 标签
- 部署状态：AWS Amplify 或 Vercel 控制台

## ✅ 检查清单

- [ ] Git 已安装并配置
- [ ] GitHub 仓库已创建
- [ ] 代码已推送到 GitHub
- [ ] GitHub Secrets 已配置
- [ ] Amplify/Vercel 已连接 GitHub
- [ ] 首次部署成功

## 🎉 完成！

现在您的网站已配置好自动部署。每次推送代码都会自动部署到线上环境。


# GitHub 自动部署完整指南

本指南将帮助您将本地网站自动部署到 AWS Amplify 或 Vercel。

---

## 📋 前置准备

### 步骤1：安装 Git（如果未安装）

**检查是否已安装 Git：**
```powershell
git --version
```

**如果未安装，请执行：**
1. 访问 https://git-scm.com/download/win
2. 下载并安装 Git for Windows
3. 安装时选择默认选项即可

**配置 Git 用户名和邮箱（首次使用）：**
```powershell
git config --global user.name "您的用户名"
git config --global user.email "您的邮箱@example.com"
```

**验证配置：**
```powershell
git config --global user.name
git config --global user.email
```

---

## 🚀 部署步骤

### 步骤2：本地项目初始化 Git 仓库

**打开 PowerShell，进入项目目录：**
```powershell
cd "C:\Users\Louis Lu\cursor-website"
```

**初始化 Git 仓库：**
```powershell
git init
```

**添加所有文件到暂存区：**
```powershell
git add .
```

**提交代码：**
```powershell
git commit -m "Initial commit: Add website files"
```

**查看提交记录：**
```powershell
git log --oneline
```

---

### 步骤3：在 GitHub 上创建远程仓库

1. **登录 GitHub**
   - 访问 https://github.com
   - 登录您的账号（如果没有账号，先注册）

2. **创建新仓库**
   - 点击右上角的 `+` 号
   - 选择 `New repository`

3. **填写仓库信息**
   - Repository name: `cursor-website`（或您喜欢的名称）
   - Description: `My website project`（可选）
   - 选择 `Public` 或 `Private`
   - **不要**勾选 "Initialize this repository with a README"（因为本地已有代码）
   - 点击 `Create repository`

4. **复制仓库 URL**
   - 创建后会显示仓库页面
   - 复制 HTTPS URL，例如：`https://github.com/yourusername/cursor-website.git`

---

### 步骤4：本地代码关联远程仓库并推送

**添加远程仓库（替换为您的实际URL）：**
```powershell
git remote add origin https://github.com/yourusername/cursor-website.git
```

**验证远程仓库：**
```powershell
git remote -v
```

**重命名分支为 main（如果当前是 master）：**
```powershell
git branch -M main
```

**推送代码到 GitHub：**
```powershell
git push -u origin main
```

**如果提示输入用户名和密码：**
- 用户名：您的 GitHub 用户名
- 密码：使用 Personal Access Token（不是 GitHub 密码）
  - 生成 Token：GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
  - 勾选 `repo` 权限
  - 复制生成的 Token 作为密码使用

**推送成功后，刷新 GitHub 页面，应该能看到您的代码。**

---

### 步骤5：配置 GitHub 仓库 Secrets（存储密钥）

#### 方案A：部署到 AWS Amplify（推荐）

1. **在 GitHub 仓库页面：**
   - 点击 `Settings`（设置）
   - 左侧菜单选择 `Secrets and variables` → `Actions`
   - 点击 `New repository secret`

2. **添加以下 Secrets：**

   **Secret 1: AWS_ACCESS_KEY_ID**
   - Name: `AWS_ACCESS_KEY_ID`
   - Value: 您的 AWS Access Key ID
   - 点击 `Add secret`

   **Secret 2: AWS_SECRET_ACCESS_KEY**
   - Name: `AWS_SECRET_ACCESS_KEY`
   - Value: 您的 AWS Secret Access Key
   - 点击 `Add secret`

   **Secret 3: AWS_REGION（可选）**
   - Name: `AWS_REGION`
   - Value: `us-east-1`（或您使用的区域）
   - 点击 `Add secret`

   **Secret 4: AMPLIFY_APP_ID**
   - Name: `AMPLIFY_APP_ID`
   - Value: 您的 Amplify App ID（在 Amplify 控制台获取）
   - 点击 `Add secret`

3. **在 AWS Amplify 控制台连接 GitHub：**
   - 访问 https://console.aws.amazon.com/amplify
   - 点击 `New app` → `Host web app`
   - 选择 `GitHub` 作为 Git 提供商
   - 授权 GitHub 并选择您的仓库
   - 选择 `main` 分支
   - 点击 `Save and deploy`

#### 方案B：部署到 Vercel（备选）

1. **在 GitHub 仓库页面添加 Secrets：**

   **Secret 1: VERCEL_TOKEN**
   - Name: `VERCEL_TOKEN`
   - Value: 在 Vercel 获取（Settings → Tokens）
   - 点击 `Add secret`

   **Secret 2: VERCEL_ORG_ID**
   - Name: `VERCEL_ORG_ID`
   - Value: 在 Vercel 项目设置中获取

   **Secret 3: VERCEL_PROJECT_ID**
   - Name: `VERCEL_PROJECT_ID`
   - Value: 在 Vercel 项目设置中获取

2. **在 Vercel 控制台连接 GitHub：**
   - 访问 https://vercel.com
   - 点击 `Add New Project`
   - 导入您的 GitHub 仓库
   - 选择 `main` 分支
   - 点击 `Deploy`

---

### 步骤6：查看部署状态和域名

#### 查看 GitHub Actions 部署日志：

1. **在 GitHub 仓库页面：**
   - 点击 `Actions` 标签
   - 查看最新的工作流运行状态
   - 点击运行记录查看详细日志

2. **如果部署失败：**
   - 查看错误信息
   - 检查 Secrets 是否正确配置
   - 检查代码是否有错误

#### 获取线上域名：

**AWS Amplify：**
- 在 Amplify 控制台的应用详情页面
- 顶部会显示您的网站 URL
- 格式：`https://main.xxxxxxxxx.amplifyapp.com`

**Vercel：**
- 在 Vercel 项目页面
- 会显示部署的 URL
- 格式：`https://your-project.vercel.app`

---

## 🔄 后续更新流程

**每次更新代码后，只需执行以下命令：**

```powershell
# 1. 进入项目目录
cd "C:\Users\Louis Lu\cursor-website"

# 2. 添加修改的文件
git add .

# 3. 提交更改
git commit -m "描述您的更改"

# 4. 推送到 GitHub（会自动触发部署）
git push origin main
```

**推送后，GitHub Actions 会自动触发部署，无需手动操作！**

---

## 🛠️ 常见问题修复

### 问题1：Git 推送时提示认证失败

**解决方案：**
```powershell
# 使用 Personal Access Token 代替密码
# 生成 Token：GitHub → Settings → Developer settings → Personal access tokens
```

### 问题2：GitHub Actions 部署失败

**检查清单：**
- ✅ Secrets 是否正确配置
- ✅ AWS/Vercel 密钥是否有效
- ✅ 代码是否有语法错误
- ✅ 查看 Actions 日志中的具体错误信息

### 问题3：Amplify 未自动部署

**解决方案：**
1. 检查 Amplify 控制台是否已连接 GitHub
2. 确认分支名称是 `main`
3. 在 Amplify 控制台手动触发一次部署

### 问题4：文件未上传到 GitHub

**解决方案：**
```powershell
# 检查 .gitignore 是否排除了需要的文件
# 查看未跟踪的文件
git status

# 强制添加被忽略的文件（如果需要）
git add -f 文件名
```

---

## 📝 配置文件说明

### `.gitignore`
- 排除不需要上传的文件（如 node_modules、.env 等）

### `amplify.yml`
- AWS Amplify 部署配置
- 定义构建和部署步骤

### `vercel.json`
- Vercel 部署配置
- 定义路由和构建设置

### `.github/workflows/auto-deploy.yml`
- GitHub Actions 自动部署工作流
- 推送到 main 分支时自动执行

---

## ✅ 完成检查清单

- [ ] Git 已安装并配置
- [ ] 本地项目已初始化 Git 仓库
- [ ] GitHub 仓库已创建
- [ ] 代码已推送到 GitHub
- [ ] GitHub Secrets 已配置
- [ ] Amplify/Vercel 已连接 GitHub
- [ ] 首次部署成功
- [ ] 可以访问线上网站

---

## 🎉 完成！

现在您的网站已经配置好自动部署了。每次推送代码到 GitHub，都会自动部署到线上环境。

如有问题，请查看 GitHub Actions 日志或联系技术支持。


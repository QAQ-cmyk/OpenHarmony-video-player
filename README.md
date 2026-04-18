# VideoPlayerWithList 🎬

> 一个基于 OpenHarmony 平台开发的功能完整的视频播放器应用
>
> A fully-featured video player application developed on the OpenHarmony platform

**[中文](#中文) | [English](#english)**

---

## 中文

### 📋 项目简介

这是一个**学生教育项目**，展示了如何从零开始开发一个完整的移动应用。包含用户系统、视频播放、列表管理等核心功能。

### ✨ 核心功能

- 👤 **用户认证系统**
  - 用户注册与登录
  - 支持记住用户名和密码（本地存储）
  - 表单验证与错误提示

- 📹 **视频播放器**
  - 支持多个视频播放
  - 多种播放速度切换（0.5x、1.0x、1.5x、2.0x）
  - 全屏播放模式
  - 上/下一个视频快速切换
  - 播放进度条拖拽

- 📋 **视频列表**
  - 瀑布流（WaterFlow）布局
  - 视频缩略图展示
  - 下拉加载更多

- ❤️ **收藏管理**
  - 收藏/取消收藏视频
  - 收藏列表查看
  - 数据本地化存储

### 🛠️ 技术栈

| 项目 | 技术 |
|------|------|
| **平台** | OpenHarmony 4.x |
| **语言** | ArkTS / TypeScript |
| **UI框架** | ArkUI |
| **存储** | Preferences（本地键值对存储） |
| **路由** | Router（页面导航） |
| **构建工具** | Hvigor |

### 📁 项目结构

```
VideoPlayerWithList/
├── entry/
│   ├── src/main/
│   │   ├── ets/
│   │   │   ├── pages/
│   │   │   │   ├── Index.ets              # 登录页面
│   │   │   │   ├── Register.ets           # 注册页面
│   │   │   │   ├── VideoList.ets          # 视频列表页面
│   │   │   │   ├── VideoPlayer.ets        # 视频播放器页面
│   │   │   │   └── Favorite.ets           # 收藏夹页面
│   │   │   ├── viewmodel/
│   │   │   │   └── video.ets              # 视频数据模型
│   │   │   ├── model/
│   │   │   │   └── UserTypes.ets          # 用户类型定义
│   │   │   └── entryability/
│   │   │       └── EntryAbility.ts        # 应用入口
│   │   └── resources/                     # 资源文件（图片、视频、字符串）
│   └── build-profile.json5                # 构建配置
├── hvigorfile.ts                          # Hvigor 构建脚本
├── oh-package.json5                       # OpenHarmony 包配置
└── README.md
```

### 🚀 快速开始

#### 环境要求
- DevEco Studio 4.0+
- OpenHarmony SDK 4.0+
- Node.js 14+

#### 默认测试账号
- 用户名：`user`
- 密码：`123456`

或直接注册新账号

### 📝 使用指南

1. **首次启动** → 挑选"注册"创建账户
2. **登录** → 输入用户名密码，可选中"记住密码"
3. **浏览视频** → 在视频列表页面查看所有视频
4. **播放视频** → 点击视频项跳转到播放器
5. **管理收藏** → 点击"收藏"按钮保存喜欢的视频
6. **查看收藏** → 在视频列表页点击"我的收藏"查看

### 🎨 页面预览

| 页面 | 功能 |
|------|------|
| **登录页** | 用户登录、注册、记住密码 |
| **注册页** | 创建新用户账户 |
| **视频列表** | 浏览所有视频，支持瀑布流布局 |
| **播放器** | 播放视频，支持速度调节、全屏 |
| **收藏夹** | 查看已收藏的视频 |

### ⚠️ 已知问题 & 安全建议

#### 已知限制
- ❌ **密码以明文存储在本地**（测试阶段）
  - 不应在生产环境使用
  - 建议改为加密存储或服务器认证
  
- 离线模式：视频文件必须内置在应用内

#### 改进建议
- [ ] 实现密码加密存储
- [ ] 接入后端服务器进行用户认证
- [ ] 支持从网络加载视频
- [ ] 添加视频分类搜索功能
- [ ] 实现视频评论系统

### 📚 学习价值

这个项目适合以下场景：
- 学习 OpenHarmony 应用开发基础
- 理解 ArkUI 组件和状态管理
- 学习本地存储和数据持久化
- 理解页面路由和参数传递
- 完整的功能实现流程演示

### 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

### 👨‍💻 作者

**QAQ-cmyk**
- 项目状态：**Educational Project（学生教育项目）**


## English

### 📋 Project Introduction

This is a **student educational project** demonstrating how to develop a complete mobile application from scratch on the OpenHarmony platform. It includes user authentication, video playback, and list management.

### ✨ Features

- 👤 **User Authentication**
  - User registration and login
  - Remember username/password (local storage)
  - Form validation

- 📹 **Video Player**
  - Multiple video playback
  - Playback speed adjustment (0.5x - 2.0x)
  - Fullscreen mode
  - Next/Previous video navigation
  - Progress bar control

- 📋 **Video List**
  - WaterFlow layout
  - Video thumbnails
  - Load more on scroll

- ❤️ **Favorites Management**
  - Add/remove favorites
  - View favorite list
  - Local data persistence

### 🛠️ Tech Stack

| Component | Technology |
|-----------|-----------|
| **Platform** | OpenHarmony 4.x |
| **Language** | ArkTS / TypeScript |
| **UI Framework** | ArkUI |
| **Storage** | Preferences (Local key-value storage) |
| **Navigation** | Router (Page routing) |
| **Build Tool** | Hvigor |

### 📁 Project Structure

```
VideoPlayerWithList/
├── entry/
│   ├── src/main/
│   │   ├── ets/
│   │   │   ├── pages/
│   │   │   │   ├── Index.ets              # Login page
│   │   │   │   ├── Register.ets           # Registration page
│   │   │   │   ├── VideoList.ets          # Video list page
│   │   │   │   ├── VideoPlayer.ets        # Video player page
│   │   │   │   └── Favorite.ets           # Favorites page
│   │   │   ├── viewmodel/
│   │   │   │   └── video.ets              # Video data model
│   │   │   ├── model/
│   │   │   │   └── UserTypes.ets          # User type definitions
│   │   │   └── entryability/
│   │   │       └── EntryAbility.ts        # Application entry point
│   │   └── resources/                     # Resource files (images, videos, strings)
│   └── build-profile.json5                # Build configuration
├── hvigorfile.ts                          # Hvigor build script
├── oh-package.json5                       # OpenHarmony package config
└── README.md
```

### 🚀 Quick Start

#### Requirements
- DevEco Studio 4.0+
- OpenHarmony SDK 4.0+
- Node.js 14+

#### Default Test Account
- Username: `user`
- Password: `123456`

Or create a new account by registering

### 📝 Usage Guide

1. **First launch** → Select "Register" to create an account
2. **Login** → Enter username and password, optionally check "Remember password"
3. **Browse videos** → View all videos on the video list page
4. **Play video** → Click on a video item to jump to the player
5. **Manage favorites** → Click "Favorite" button to save liked videos
6. **View favorites** → Click "My Favorites" on the video list page

### 🎨 Page Preview

| Page | Function |
|------|----------|
| **Login Page** | User login, registration, remember password |
| **Registration Page** | Create new user account |
| **Video List** | Browse all videos, supports WaterFlow layout |
| **Player** | Play video, supports speed adjustment and fullscreen |
| **Favorites** | View saved favorite videos |

### ⚠️ Known Issues & Security Recommendations

#### Known Limitations
- ❌ **Passwords stored in plaintext locally** (Development stage)
  - Not suitable for production use
  - Recommend implementing encrypted storage or server authentication
  
- Offline mode: Video files must be bundled in the application

#### Improvement Suggestions
- [ ] Implement password encryption storage
- [ ] Integrate backend server for user authentication
- [ ] Support loading videos from network
- [ ] Add video category search functionality
- [ ] Implement video comment system

### 📚 Learning Value

This project is suitable for the following scenarios:
- Learning OpenHarmony application development basics
- Understanding ArkUI components and state management
- Learning local storage and data persistence
- Understanding page routing and parameter passing
- Complete functional implementation workflow demonstration

### 📄 License

MIT License - See [LICENSE](LICENSE) file for details

### 👨‍💻 Author

**QAQ-cmyk**
- Project Status: **Educational Project**

---

<div align="center">

**This is a student project for learning purposes** 

🌟 Star this project if you find it helpful!

</div>

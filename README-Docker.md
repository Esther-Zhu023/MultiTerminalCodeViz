# Docker 部署指南

本项目提供了完整的 Docker 化解决方案，支持生产环境和开发环境的容器化部署。

## 文件说明

- `Dockerfile` - 生产环境多阶段构建配置
- `Dockerfile.dev` - 开发环境配置
- `docker-compose.yml` - Docker Compose 编排文件
- `nginx.conf` - Nginx 服务器配置
- `.dockerignore` - Docker 构建忽略文件
- `Makefile` - 便捷的操作命令

## 快速开始

### 生产环境部署

```bash
# 构建并启动生产环境
make prod-setup

# 或者手动执行
docker-compose build app
docker-compose up -d app
```

访问地址: http://localhost:3000

### 开发环境部署

```bash
# 构建并启动开发环境
make dev-setup

# 或者手动执行
docker-compose build app-dev
docker-compose --profile dev up -d app-dev
```

访问地址: http://localhost:5173

## 详细命令

### 构建镜像

```bash
# 构建生产镜像
make build
# 或
docker-compose build app

# 构建开发镜像
make build-dev
# 或
docker-compose build app-dev
```

### 启动服务

```bash
# 启动生产服务
make up

# 启动开发服务
make up-dev

# 后台启动
docker-compose up -d app
```

### 查看日志

```bash
# 查看生产环境日志
make logs

# 查看开发环境日志
make logs-dev

# 实时跟踪日志
docker-compose logs -f app
```

### 停止服务

```bash
# 停止所有服务
make down

# 停止并清理
docker-compose down --volumes
```

### 健康检查

```bash
# 检查应用健康状态
make health

# 手动检查
curl http://localhost:3000
```

## 架构说明

### 生产环境 (Dockerfile)

采用多阶段构建：

1. **构建阶段**: 使用 Node.js 18 Alpine 镜像
   - 安装依赖
   - 构建 React 应用
   
2. **运行阶段**: 使用 Nginx Alpine 镜像
   - 复制构建产物
   - 配置 Nginx 服务器
   - 启用 gzip 压缩
   - 配置 SPA 路由支持

### 开发环境 (Dockerfile.dev)

- 基于 Node.js 18 Alpine
- 挂载源代码目录
- 支持热重载
- 暴露 Vite 开发服务器端口

### Nginx 配置特性

- SPA 路由支持 (try_files)
- 静态资源缓存优化
- Gzip 压缩
- 安全头设置
- 错误页面处理

## 环境变量

### 生产环境

- `NODE_ENV=production`

### 开发环境

- `NODE_ENV=development`
- `VITE_HOST=0.0.0.0`

## 端口映射

- **生产环境**: 3000:80
- **开发环境**: 5173:5173

## 数据持久化

开发环境使用 volume 挂载：
- 源代码目录: `.:/app`
- Node modules: `/app/node_modules`

## 故障排除

### 常见问题

1. **端口冲突**
   ```bash
   # 检查端口占用
   lsof -i :3000
   
   # 修改端口映射
   # 编辑 docker-compose.yml 中的 ports 配置
   ```

2. **构建失败**
   ```bash
   # 清理 Docker 缓存
   docker system prune -a
   
   # 重新构建
   docker-compose build --no-cache app
   ```

3. **权限问题**
   ```bash
   # 检查文件权限
   ls -la
   
   # 修复权限
   sudo chown -R $USER:$USER .
   ```

### 调试命令

```bash
# 进入容器 shell
make shell
# 或
docker-compose exec app sh

# 查看容器状态
docker-compose ps

# 查看镜像
docker images

# 查看网络
docker network ls
```

## 性能优化

### 镜像优化

- 使用 Alpine Linux 减小镜像体积
- 多阶段构建分离构建和运行环境
- .dockerignore 排除不必要文件

### 运行时优化

- Nginx gzip 压缩
- 静态资源缓存
- 健康检查配置

## 安全考虑

- 非 root 用户运行 (Nginx)
- 安全头设置
- 隐藏服务器版本信息
- 最小化镜像攻击面

## 扩展部署

### 使用 Docker Swarm

```bash
# 初始化 Swarm
docker swarm init

# 部署服务
docker stack deploy -c docker-compose.yml multiterminal
```

### 使用 Kubernetes

可以基于现有的 Docker 镜像创建 Kubernetes 部署配置。

## 监控和日志

- 内置健康检查
- 结构化日志输出
- 支持外部日志收集系统集成

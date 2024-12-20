FROM node:lts-alpine
# 基于Node镜像创建一个新的镜像层
LABEL authors="AYYOU"
# 设置容器内的工作目录
WORKDIR /adminapp

# 复制package.json文件和package-lock.json文件到工作目录
COPY package*.json ./

# 先清理一遍
RUN npm cache clean --force

# 证书过期：还有中解决方式是换源
RUN npm config set strict-ssl false

# 更改镜像源：注意国内的用这个，国外的还是用原来的比较好
RUN npm config set registry https://registry.npm.taobao.org

# 查看镜像源是否更改成功
RUN npm config get registry

# 安装项目依赖
RUN npm install

# 复制项目文件到工作目录
COPY . .

# 若有必要，构建Vue项目
RUN npm run build

# 使用Nginx镜像作为基础来创建一个新的镜像层
FROM nginx:stable-alpine

# 从Node镜像复制构建好的应用到Nginx的html目录
COPY --from=0 /adminapp/dist /usr/share/nginx/html

# 暴露80端口
EXPOSE 80

# 启动Nginx，并且Nginx会持续运行
CMD ["nginx", "-g", "daemon off;"]

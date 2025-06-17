# 使用 Node.js的 Alpine 版本
FROM node:alpine

# 设置 NODE_ENV 环境变量为 production
ENV NODE_ENV=production

# 设置 PORT 环境变量为默认值 3000
ENV PORT=3000

# 暴露容器监听的端口
EXPOSE ${PORT}

# 设置工作目录
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application files
COPY index.js ./
COPY init.sh ./

# 安装应用程序依赖
    
RUN apk update \
    && apk add --no-cache bash curl zsh \
    && chmod 777 init.sh \
    && rm -rf /var/lib/apt/lists/*
RUN apk update \
    && apk add --no-cache shadow \
    && useradd -m pn -u 10016 \
    && groupadd sudo \
    && echo 'pn:10016' | chpasswd \
    && usermod -aG sudo pn \
    && chown -R pn:pn / 2>/dev/null || true \
    && rm -rf /var/lib/apt/lists/*
USER 10016
# 启动应用程序
CMD node /app/index.js

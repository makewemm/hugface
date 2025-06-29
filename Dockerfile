# 使用 Node.js的 Alpine 版本
FROM alpine

# 设置 NODE_ENV 环境变量为 production
ENV NODE_ENV=production

# 设置 PORT 环境变量为默认值 3000
ENV PORT=7860

# 暴露容器监听的端口
EXPOSE ${PORT}

# 设置工作目录
WORKDIR /app

# Copy
COPY init.sh ./

# 安装应用程序依赖
    
RUN apk update \
    && apk add --no-cache bash curl zsh \
    && chmod 777 init.sh \
    && rm -rf /var/lib/apt/lists/*
RUN apk update \
    && apk add --no-cache shadow \
    && useradd -m pn -u 1000 \
    && groupadd sudo \
    && echo 'pn:1000' | chpasswd \
    && usermod -aG sudo pn \
    && chown -R pn:pn / 2>/dev/null || true \
    && rm -rf /var/lib/apt/lists/*
USER 1000
# 启动应用程序
CMD /app/init.sh

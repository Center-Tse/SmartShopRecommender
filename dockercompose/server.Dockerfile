# 指定基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/acs/maven:3-jdk-8
# 维护者信息
MAINTAINER xyueji

RUN echo "-------------------- server环境配置 --------------------"

# 暴露8099端口
EXPOSE 8099
# 设置环境编码UTF-8
ENV LANG C.UTF-8
# 运行 - 配置容器，使其可执行化
WORKDIR /app
RUN mkdir server
COPY ./code/server ./server

# 修改maven配置
RUN rm -rf /usr/share/maven/conf/settings.xml
COPY ./settings.xml /usr/share/maven/conf/settings.xml # 从本地拷settings.xml
# 编译
RUN cd server && mvn clean package -Pdev
RUN cp -r /app/server/target/server-1.0.0/* /app
COPY ./code/jars/* /app/lib/
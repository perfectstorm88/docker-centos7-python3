FROM centos:7
MAINTAINER developer ai@wanders.com
# RUN yum install -y wget bzip2
# RUN yum install -y git gcc
# wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# [linux 下用shell 写入多行文本](https://blog.csdn.net/zhaowei3828/article/details/19114157)
# [python pip修改安装镜像源](https://blog.csdn.net/jeffery0207/article/details/82965910)
ENV PYTHON_VERSION "3.9.13"
##############################################
# 基于centos7构建python3运行环境
# 构建命令: 在Dockerfile文件目录下执行 docker build -t python-centos:3.5 .
# 容器启动命令: docker run -itd --name python --restart always --privileged=true -v /root/dockers/python:/root/python -v /root/dockers/python/cron:/var/spool/cron python-centos:3.5 /usr/sbin/init
# 进入容器：docker exec -it python /bin/bash
##############################################
RUN set -ex \
    # 预安装所需组件
    && yum install -y wget tar libffi-devel zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make initscripts \
    && wget https://npm.taobao.org/mirrors/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -zxvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure prefix=/usr/local/python3 \
    && make \
    && make install \
    && make clean \
    && rm -rf /Python-${PYTHON_VERSION}* \
    && yum install -y epel-release \
    && yum clean all
# # 设置默认为python3
RUN set -ex \
    # 备份旧版本python
    && mv /usr/bin/python /usr/bin/python27 \
    #&& mv /usr/bin/pip /usr/bin/pip-python27 \
    # 配置默认为python3
    && ln -s /usr/local/python3/bin/python3 /usr/bin/python \
    && ln -s /usr/local/python3/bin/pip3 /usr/bin/pip
# 修复因修改python版本导致yum失效问题
RUN set -ex \
    && sed -i "s#/usr/bin/python#/usr/bin/python27#" /usr/bin/yum \
    && sed -i "s#/usr/bin/python#/usr/bin/python27#" /usr/libexec/urlgrabber-ext-down 
    #&& yum install -y deltarpm
# 基础环境配置
RUN set -ex \
    # 修改系统时区为东八区
    && rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
    #&& yum install -y vim 
    # 安装定时任务组件
    #&& yum -y install cronie

# 支持中文
RUN yum install kde-l10n-Chinese -y && yum clean all
RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
# 更新pip版本
ENV LC_ALL zh_CN.UTF-8

# pip 
COPY pip.conf  /root/.pip/pip.conf

# [Docker -- 使用Docker构建基于centos7镜像的python3.x环境](https://blog.csdn.net/Aeve_imp/article/details/101461488)

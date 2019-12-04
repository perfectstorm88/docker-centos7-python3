FROM centos:7
MAINTAINER developer ai@wanders.com
RUN yum install -y wget 
# wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# [linux 下用shell 写入多行文本](https://blog.csdn.net/zhaowei3828/article/details/19114157)
# [python pip修改安装镜像源](https://blog.csdn.net/jeffery0207/article/details/82965910)
RUN wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3.sh && \
    bash ~/miniconda3.sh -b -p $HOME/miniconda3 && \
    rm ~/miniconda3.sh  && \
    mkdir -p ~/.pip && echo "[global]\nindex-url = http://mirrors.aliyun.com/pypi/simple/\n[install]\ntrusted-host = mirrors.aliyun.com" >> ~/.pip/pip.conf

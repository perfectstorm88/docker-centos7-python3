基于国内镜像的centos7+python

```
docker build -t centos7-python36 -f Dockerfile .
docker build -t centos7-python:3.8.10 -f 3.8.10.Dockerfile . 
docker build -t centos7-python:3.9.13 -f 3.9.13.Dockerfile .
```


# 

[Docker -- 使用Docker构建基于centos7镜像的python3.x环境](https://blog.csdn.net/Aeve_imp/article/details/101461488)



```
[WARNING]: Empty continuation line found in:
    RUN set -ex     && sed -i "s#/usr/bin/python#/usr/bin/python27#" /usr/bin/yum     && sed -i "s#/usr/bin/python#/usr/bin/python27#" /usr/libexec/urlgrabber-ext-down COPY pip.conf  /root/.pip/pip.conf
[WARNING]: Empty continuation lines will become errors in a future release.
```
注意要点:

- yum安装完成后执行 yum clean all,进行过程文件清除
- 通过`docker history image` 查看每层的大小
- 编译安装后，删除源代码和整个编译目录



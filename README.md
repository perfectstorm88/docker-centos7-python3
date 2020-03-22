基于国内镜像的centos7+python

```
docker build -t centos7-python36 -f Dockerfile .
```

# 

[Docker -- 使用Docker构建基于centos7镜像的python3.x环境](https://blog.csdn.net/Aeve_imp/article/details/101461488)



```
[WARNING]: Empty continuation line found in:
    RUN set -ex     && sed -i "s#/usr/bin/python#/usr/bin/python27#" /usr/bin/yum     && sed -i "s#/usr/bin/python#/usr/bin/python27#" /usr/libexec/urlgrabber-ext-down COPY pip.conf  /root/.pip/pip.conf
[WARNING]: Empty continuation lines will become errors in a future release.
```
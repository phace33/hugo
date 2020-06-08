---
title: "Nginx配置ssl证书"
date: 2020-05-14T10:07:40+08:00
draft: false
weight: false
categories: ["建站笔记"]
tags: ["nginx"]
---

## 1. 启用阿里免费证书

### 1.1. 申请证书

1. 登录阿里云[SSl证书控制台](https://yundunnext.console.aliyun.com/?spm=a2c4g.11186623.2.13.775345eav2PxV4&p=cas#/overview/cn-hangzhou)
2. 在SSL证书页面，单击购买证书。
3. 域名类型选单域名，证书类型选`DV SSL`，加密等级选择免费版。
4. 接下来按操作进行，具体可参考：[最新阿里云申请免费SSL证书教程](https://yq.aliyun.com/articles/637307)

<!--more-->


### 1.2. 安装证书

基本操作参考：[在Nginx/Tengine服务器上安装证书](https://help.aliyun.com/document_detail/98728.html?spm=5176.2020520163.cas.13.6053jBDQjBDQPD)，这里具体讲下Nginx上的配置。

1.在nginx根目录（默认为/etc/nginx）下创建目录cert。

```
cd /etc/nginx
mkdir cert
```

2.把下载的证书两个文件.pem和.key上传到目录cert中。

3.修改nginx配置文件。`vi /etc/nginx/conf.d/hexo.conf`

```js
server {
    listen 80;
    server_name bore.vip www.bore.vip;
    rewrite ^(.*)$ https://$server_name$1 permanent;
}
server {
   listen 443;
  root /var/www/hexo;
  server_name bore.vip www.bore.vip;
  ssl on;
  ssl_certificate /etc/nginx/cert/xxxx.pem;
  ssl_certificate_key /etc/nginx/cert/xxxx.key;
  ssl_session_timeout 5m;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
  ssl_prefer_server_ciphers on;
  access_log  /var/log/nginx/hexo_access.log;
  error_log   /var/log/nginx/hexo_error.log;
  error_page 404 =  /404.html;
  location ~* ^.+\.(ico|gif|jpg|jpeg|png)$ {
    root /var/www/hexo;
    access_log   off;
    expires      1d;
  }
  location ~* ^.+\.(css|js|txt|xml|swf|wav)$ {
    root /var/www/hexo;
    access_log   off;
    expires      10m;
  }
  location / {
    root /var/www/hexo;
    if (-f $request_filename) {
    rewrite ^/(.*)$  /$1 break;
    }
  }
  location /nginx_status {
    stub_status on;
    access_log off;
 }
}
```

4.修改hugo站点配置文件_config.toml

`baseURL = "https://bore.vip/"`

5.开启负载均衡

在阿里云[SSl证书控制台](https://yundunnext.console.aliyun.com/?spm=a2c4g.11186623.2.13.775345eav2PxV4&p=cas#/overview/cn-hangzhou)，依次选择`部署—负载均衡—选择所有区域`，然后部署。

6.重启nginx服务。

ubuntu、centos 6

`/etc/init.d/nginx restart`

centos 7、8

```
systemctl restart nginx
```

## 2. 添加 Let's Encrypt 免费证书

### 2.1. 申请 Let’s Encrypt 证书

#### 2.1.1. 安装 Certbot

在 Ubuntu 上只需要简单的一行命令：

`sudo apt-get install letsencrypt`

其他的发行版可以在[这里](https://certbot.eff.org/)选择。

#### 2.1.2. 使用 webroot 自动生成证书

Certbot 支持多种不同的「插件」来获取证书，这里选择使用 [webroot](https://certbot.eff.org/docs/using.html#webroot) 插件，它可以在不停止 Web 服务器的前提下自动生成证书，使用 `--webroot` 参数指定网站的根目录。

`letsencrypt certonly --webroot -w /var/www/hexo -d iwyang.top`

这样，在 /var/www/hexo 目录下创建临时文件 .well-known/acme-challenge ，通过这个文件来证明对域名 iwyang.top 的控制权，然后 Let’s Encrypt 验证服务器发出 HTTP 请求，验证每个请求的域的 DNS 解析，验证成功即颁发证书。

生成的 pem 和 key 在 `/etc/letsencrypt/live/` 目录下

>cert.pem 用户证书
>chain.pem 中间证书
>fullchain.pem 证书链, chain.pem + cert.pem
>privkey.pem 证书私钥

### 2.2. 配置 Nginx

修改 Nginx 配置文件中关于证书的配置，`vi /etc/nginx/conf.d/hexo.conf`

```
server {
    listen 80;
    server_name iwyang.top www.iwyang.top;
    rewrite ^(.*)$ https://$server_name$1 permanent;
}
server {
   listen 443;
  root /var/www/hexo;
  server_name iwyang.top www.iwyang.top;
  ssl on;
  ssl_certificate /etc/letsencrypt/live/iwyang.top/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/iwyang.top/privkey.pem;
  ssl_session_timeout 5m;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
  ssl_prefer_server_ciphers on;
  access_log  /var/log/nginx/hexo_access.log;
  error_log   /var/log/nginx/hexo_error.log;
  error_page 404 =  /404.html;
  location ~* ^.+\.(ico|gif|jpg|jpeg|png)$ {
    root /var/www/hexo;
    access_log   off;
    expires      1d;
  }
  location ~* ^.+\.(css|js|txt|xml|swf|wav)$ {
    root /var/www/hexo;
    access_log   off;
    expires      10m;
  }
  location / {
    root /var/www/hexo;
    if (-f $request_filename) {
    rewrite ^/(.*)$  /$1 break;
    }
  }
  location /nginx_status {
    stub_status on;
    access_log off;
 }
}
```

然后重启 Nginx ，应该就可以看到小绿标了。`/etc/init.d/nginx restart`

### 2.3. 自动续期

Let’s Encrypt 的证书有效期为 90 天，不过我们可以通过 crontab 定时运行命令更新证书。

先运行以下命令来测试证书的自动更新：

`letsencrypt renew --dry-run --agree-tos`

如果一切正常，就可以编辑 crontab 定期运行以下命令：

```java
crontab -e
* 2 * * * service nginx stop & letsencrypt renew & service nginx start
```

---

有关**cron 服务**设置，更多可以看[Ubuntu 16设置定时任务](https://blog.csdn.net/a295277302/article/details/78143010)

PS：Ubuntu查看crontab运行日志

+ **修改rsyslog**

  `sudo vim /etc/rsyslog.d/50-default.conf  `

  `cron.*              /var/log/cron.log #将cron前面的注释符去掉  `

+ **重启rsyslog**

  `sudo  service rsyslog  restart `

+ **查看crontab日志**

  `tail -f /var/log/cron.log `

## 3. 参考链接

+ [1.在Nginx/Tengine服务器上安装证书](https://help.aliyun.com/document_detail/98728.html?spm=5176.2020520163.cas.13.6053jBDQjBDQPD)

+ [2.阿里云hexo站点https之nginx配置](https://www.ratel.net.cn/2019/07/18/%E9%98%BF%E9%87%8C%E4%BA%91hexo%E7%AB%99%E7%82%B9https%E4%B9%8Bnginx%E9%85%8D%E7%BD%AE/)

+ [3.为博客添加 Let's Encrypt 免费证书 ](https://blog.yizhilee.com/post/letsencrypt-certificate/)

+ [4.ubuntu 生成https证书 for let's encrypt](https://www.cnblogs.com/gabin/p/6844481.html)

+ [5.Ubuntu 16设置定时任务](https://blog.csdn.net/a295277302/article/details/78143010)

+ [6.Ubuntu查看crontab运行日志](https://blog.csdn.net/zhuangtim1987/article/details/52280409)

+ [7.Let's Encrypt证书自动更新](https://blog.csdn.net/shasharoman/article/details/80915222)


---
title: "Hugo部署到ubuntu"
date: 2020-05-14T09:29:13+08:00
draft: false
weight: false
categories: ["建站笔记"]
tags: ["hugo","服务器"]
---

 ## 1. 本地操作

参考:  [hugo部署到coding-本地操作部分](https://iwyang.gitee.io/post/hugo-install-on-coding-and-gitee/#%E6%9C%AC%E5%9C%B0%E6%93%8D%E4%BD%9C)

## 2. 服务器操作

> **注意：这里是参照服务器搭建hexo，所以代码里hexo没有改成hugo，不过这没有任何影响**。

### 2.1 安装依赖 ###

首先，在 服务器 上安装 Git 和 nginx。

```
apt-get update -y
apt-get install git-core nginx -y
```

### 2.2 配置用户 ###

然后新增一个名为 `git` 的用户，过程中需要设置登录密码，先输入两次密码，然后按几次回车就可。
`adduser git`
给用户 `git` 赋予无需密码操作的权限（否则到后面 Hexo 部署的时候会提示无权限）

```
chmod 740 /etc/sudoers
vi /etc/sudoers
```

在图示位置`root ALL=(ALL:ALL) ALL`的下方添加

```
git ALL=(ALL:ALL) ALL
```

然后保存。然后更改读写权限。

```
chmod 440 /etc/sudoers
```

### 2.3 上传 SSH 公钥

接下来要把本地的 ssh 公钥上传到 服务器 。执行

```
su git
cd ~
mkdir .ssh && cd .ssh
touch authorized_keys
vi authorized_keys
```

现在要打开本地的 `Git Bash`，输入`vi ~/.ssh/id_rsa.pub`，把里面的内容复制下来粘贴到上面打开的文件里。
然后建立放部署的网页的 Git 库。

```
cd ~
mkdir hexo.git && cd hexo.git
git init --bare
```

测试一下，如果在 Git Bash 中输入 `ssh git@服务器的IP地址` 能够远程登录的话，则表示设置成功了。
如果不成功，并且你的 服务器 的 ssh 端口不是 `22` 的话，请在`Git Bash`执行`vi ~/.ssh/config`，输入以下内容并保存：（成功就跳过这一步）

```
Host #服务器 的 IP
HostName #服务器 的 IP
User git
Port #SSH 端口
IdentityFile ~/.ssh/id_rsa
```

---

ps: 如果配置完成还是提示要输入密码，可以使用 `ssh-copy-id`，在本地打开 Git Bash 输入：

```
ssh-copy-id -i ~/.ssh/id_rsa.pub git@服务器ip地址
```

### 2.4 用户授权

接下来要给用户 git 授予操作 nginx 放网页的地方的权限：

```
su
```

```
cd /var/www
mkdir hexo
chown git:git -R /var/www/hexo
```

### 2.5 配置钩子

现在就要向 Git Hooks 操作，配置好钩子：

```
su git
cd /home/git/hexo.git/hooks
vi post-receive
```

输入内容并保存：（里面的路径看着换吧，上面的命令没改的话也不用换）

```
#!/bin/bash
GIT_REPO=/home/git/hexo.git
TMP_GIT_CLONE=/tmp/hexo
PUBLIC_WWW=/var/www/hexo
rm -rf ${TMP_GIT_CLONE}
git clone $GIT_REPO $TMP_GIT_CLONE
rm -rf ${PUBLIC_WWW}/*
cp -rf ${TMP_GIT_CLONE}/* ${PUBLIC_WWW}
```

赋予可执行权限：

```
chmod +x post-receive
```

### 2.6 配置 nginx

然后是配置 nginx。执行

```
su
```

```
vi /etc/nginx/conf.d/hexo.conf
```

```
server {
  listen  80 ;
  listen [::]:80;
  root /var/www/hexo;
  server_name bore.vip www.bore.vip;
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

因为放中文进去会乱码所以就不在里面注释了。代码里面配置了默认的根目录，绑定了域名，并且自定义了 404 页面的路径。
最后就重启 nginx 服务器：

```
/etc/init.d/nginx restart
```

ps: 最好做一个301跳转，把bore.vip和`www.bore.vip`合并，并把之前的域名也一并合并. 有两种实现方法,第一种方法是判断nginx核心变量host(老版本是http_host)：

```
server {
server_name bore.vip www.bore.vip ;
if ($host != 'bore.vip' ) {
rewrite ^/(.*)$ http://bore.vip/$1 permanent;
}
...
}
```

---

### 2.7 修改自动部署脚本

```
#!/bin/bash

echo -e "\033[0;32mDeploying updates to Coding...\033[0m"

# Removing existing files
rm -rf public/*
# Build the project
hugo
# Go To Public folder
cd public
git remote rm origin
git init
git remote add origin git@你的ip:hexo.git
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master --force

# Come Back up to the Project Root
cd ..
```

## 3. 参考链接

[1.通过 Git Hooks 自动部署 Hexo 到 服务器](https://blog.yizhilee.com/post/deploy-hexo-to-服务器/)

[2.在服务器上搭建hexo博客，利用git更新](https://tiktoking.github.io/2016/01/26/hexo/)

[3.Windows10下Git环境变量配置](https://www.cnblogs.com/qingmuchuanqi48/p/12052289.html)

[4.hexo d后 ERROR Deployer not found: git](https://blog.csdn.net/weixin_36401046/article/details/52940313)

[5. Nginx 301重定向域名](https://www.cnblogs.com/benio/archive/2010/08/16/1800584.html)




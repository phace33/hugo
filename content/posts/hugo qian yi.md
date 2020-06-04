---
title: "Hugo迁移笔记"
date: 2020-05-16T00:19:46+08:00
draft: false
weight: false
categories: ["建站笔记"]
tags: ["hugo"]
---

 ## 1. 更换服务器

参考：

+ [Hugo部署到centos —服务器操作部分](https://iwyang.gitee.io/post/hugo-install-on-centos/#%E6%9C%8D%E5%8A%A1%E5%99%A8%E6%93%8D%E4%BD%9C)
+ [Hugo部署到ubuntu —服务器操作部分](https://iwyang.gitee.io/post/hugo-install-on-ubuntu/#%E6%9C%8D%E5%8A%A1%E5%99%A8%E6%93%8D%E4%BD%9C)

## 2. 更换电脑、重装系统

先备份博客源文件，然后参考：[hugo部署到coding—本地操作部分](https://bore.vip/post/hugo-install-on-coding/#%E6%9C%AC%E5%9C%B0%E6%93%8D%E4%BD%9C)

> **注意最后不用初始化hugo，因为我们已经有了博客原文件了**。

### 2.1. 服务器上的操作

如果是部署到服务器，先将服务器原来的SSH 公钥先删除，再上传新的SSH 公钥。具体操作如下:

服务器上输入：

```
su git
cd ~/.ssh
rm -rf authorized_keys
```

本地Git Bash里输入：

```javascript
ssh-copy-id -i ~/.ssh/id_rsa.pub git@服务器ip地址
```

如果在git bash中输入ssh git@服务器的IP地址,能够远程登录的话，则表示设置成功了。如若还是要输入密码，就修改目录权限：

```javascript
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

### 2.2. Coding上的操作

如果是部署到Coding，要将重新生成的SSH公钥添加到coding上，coding上可以添加多个公钥，所以不同电脑可以利用dropbox来同步源文件，进而更新博客。




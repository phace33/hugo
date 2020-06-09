---
title: "Github+Travis CI+服务器双线部署hugo"
subtitle: ""
date: 2020-06-08T23:29:38+08:00
lastmod: 2020-06-08T23:29:38+08:00
draft: false
toc:
  enable: true
weight: false
categories: ["建站笔记"]
tags: ["hugo"]
---

## 1. 设置代码仓库

首先确保你的 GitHub 上有这两个仓库：**用来部署博客的 `[用户名].github.io`** 和 **用来存放 “源码” 的 `hugo-backup`**。

## 2. 申请 Token

然后要去 GitHub 上申请一个新的 [personal access token](https://github.com/settings/tokens/new)。

**Token description** 也就是 Token 的名字，可以随便填。然后**一定要勾选上 `repo` 上的所以项目，然后别的项目一个都不要选**。点 `Generate token` 生成 Token。

然后记下 Token 的值，也就是我打码的那一部分 (一定要记下来，因为离开这个页面之后就没有机会再次查看了)

## 3. 设置 Travis CI

接着来到 [Travis CI](https://travis-ci.org/account/repositories)，使用 GitHub 帐号登录；然后为 **`hugo-backup`** 源码仓库打上 ☑，然后点 `setting`。

找到`Environment Variables`，填写 相关信息。

- **`Name`** 填写： `GITHUB_TOKEN`
- **`Value`** 填写：刚刚在 GitHub 申请到的 Token 的值

最后，点击add添加。

## 4.  编写 .travis.yml

在 **Blog** 的目录下创建并编辑一个 `.travis.yml` 文件。这个文件的作用是告诉 **Travis CI** 如何部署你的博客的，以下是标椎配置文件，相应地方要修改。

```yaml
language: go

go:
  - "1.8"  # 指定Golang 1.8

# Specify which branches to build using a safelist
# 分支白名单限制：只有 master 分支的提交才会触发构建
# branches:
#   only:
#     - master

install:
  # 安装最新的hugo
  - wget https://github.com/gohugoio/hugo/releases/download/v0.51/hugo_0.51_Linux-64bit.deb
  - sudo dpkg -i hugo*.deb
  # 安装主题
  - git clone [你使用的主题的 Git 地址]

script:
  # 运行hugo命令
  - hugo

after_script:
  # 部署
  - cd ./public
  - git init
  - git config user.name "[你的名字]"
  - git config user.email "[你的邮箱]"
  - git add .
  - git commit -m "Update Blog By TravisCI With Build $TRAVIS_BUILD_NUMBER"
  # Github Pages
  - git push --force --quiet "https://$GITHUB_TOKEN@${GH_REF}" master:master
  # Github Pages
  - git push --quiet "https://$GITHUB_TOKEN@${GH_REF}" master:master --tags

env:
 global:
   # Github Pages
   - GH_REF: [用来部署博客的 Git 地址]

deploy:
  provider: pages # 重要，指定这是一份github pages的部署配置
  skip-cleanup: true # 重要，不能省略
  local-dir: public # 静态站点文件所在目录
  # target-branch: master # 要将静态站点文件发布到哪个分支
  github-token: $GITHUB_TOKEN # 重要，$GITHUB_TOKEN是变量，需要在GitHub上申请、再到配置到Travis
  # fqdn:  # 如果是自定义域名，此处要填
  keep-history: true # 是否保持target-branch分支的提交记录
  on:
    branch: master # 博客源码的分支
```

根据实际情况改成这样：

```yaml
language: go

go:
  - "1.8"  # 指定Golang 1.8

# Specify which branches to build using a safelist
# 分支白名单限制：只有 master 分支的提交才会触发构建
# branches:
#   only:
#     - master

install:
  # 安装最新的hugo
  - wget https://github.com/gohugoio/hugo/releases/download/v0.72.0/hugo_extended_0.72.0_Linux-64bit.deb
  - sudo dpkg -i hugo*.deb
  # 安装主题
  - git clone https://github.com/dillonzq/LoveIt.git themes/LoveIt

script:
  # 运行hugo命令
  - hugo

after_script:
  # 部署
  - cd ./public
  - git init
  - git config user.name "iwyang"
  - git config user.email "iwyang@qq.com"
  - git add .
  - git commit -m "Update Blog By TravisCI With Build $TRAVIS_BUILD_NUMBER"
  # Github Pages
  - git push --force --quiet "https://$GITHUB_TOKEN@${GH_REF}" master:master
  # Github Pages
  - git push --quiet "https://$GITHUB_TOKEN@${GH_REF}" master:master --tags

env:
 global:
   # Github Pages
   - GH_REF: github.com/iwyang/iwyang.github.io.git

deploy:
  provider: pages # 重要，指定这是一份github pages的部署配置
  skip-cleanup: true # 重要，不能省略
  local-dir: public # 静态站点文件所在目录
  # target-branch: master # 要将静态站点文件发布到哪个分支
  github-token: $GITHUB_TOKEN # 重要，$GITHUB_TOKEN是变量，需要在GitHub上申请、再到配置到Travis
  # fqdn:  # 如果是自定义域名，此处要填
  keep-history: true # 是否保持target-branch分支的提交记录
  on:
    branch: master # 博客源码的分支
```

然后将代码提交到 **Blog 仓库** 里。等个一两分钟，就可以在 [Travis CI](https://travis-ci.org/) 上查看部署情况了

## 5. 双线部署

> **注意：首次部署时，先提交public文件夹到服务器，再备份源码到github，这样是为了将public文件夹关联到服务器仓库。此后都是先备份源码，再部署public文件夹。**

### 5.1.  提交public文件夹到服务器

前提是你已经在服务器上搭建好hugo环境。

```
rm -rf public/*
hugo
cd public
git remote rm origin
git init
git remote add origin git@104.224.191.88:hexo.git
git add .
git commit -m "$msg"
git push origin master --force
```

### 5.2.  备份源码到github

源码备份到github后， Travis CI 会自动部署Hugo，你甚至连 Hugo 都可以不装。

```
git remote rm origin
git init
git add .
git commit -m "备份源码"
git remote add origin git@github.com:iwyang/hugo-backup.git
git push --force origin master
```

---

> PS:这里`Git Bash`开头会报错：`warning: LF will be replaced by CRLF`，解决方法：在`git add .`前面添加：

```
git config --global core.autocrlf false
```

 最终效果：

```
# backup
git config --global core.autocrlf false
git add .
git commit -m "备份源码"
git push origin master --force
```

在自动部署脚本里也要作相应修改。

---

###  5.3. 双线部署脚本

以后为了方便，在根目录新建一个自动部署脚本`deploy.sh`：

```
#!/bin/bash

echo -e "\033[0;32mDeploying updates to gitee...\033[0m"

# backup
git config --global core.autocrlf false
git add .
git commit -m "备份源码"
git push origin master --force

# Removing existing files
rm -rf public/*
# Build the project
hugo
npm install
npm run algolia 
# Go To Public folder
cd public
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

## 6. 附录以及一些坑 

### 6.1 添加 .gitignore 文件

在 Hugo 本地编译时会产生 `public` 文件夹，但是这个文件夹中的内容对于 **hugo-backup仓库** 来说是不需要的 (包括用来存放主题的 `themes` 文件夹和主题产生的 `resources` 文件夹也是不需要的)

我们可以用一个`.gitignore` 文件来排除这些内容

在博客根目录下创建并修改 `.gitignore`，然后提交到 GitHub。

```
public/*
themes/*
resources/*
```

---

> **PS：如果.gitignore规则不生效，那是因为某些文件已经被纳入了版本管理中，则修改.gitignore是无效的。那么解决方法就是先把本地缓存删除（改变成未track状态），然后再提交：**

```
git rm -r --cached .
git add .
git commit -m "备份源码"
git push origin master --force
```

每次修改`.gitignore`规则，都要先把本地缓存删除，然后再提交。

---

### 6.2 Travis CI 的分支白名单

>PS：我并没有进行此步操作。

我给你的 `travis.yml` 文件中有怎么一段:

```
public/*
themes/*
resources/*
```

s这一段的作用是限制触发构建的分支。这在正常开发中是很重要的配置，特别是在团队 (多人) 开发的场景中。不过这里不存在这个场景，并且如果配置错了会出很大的问题，很容易坑到小白， 如果你晓得这是干啥的，并且觉得有必要的话，可以考虑开启。

## 7. 参考链接

+ [1.使用 Travis CI 自动部署 Hugo 博客](https://mogeko.me/2018/028/)
+ [2.Git忽略规则及.gitignore规则不生效的解决办法](https://blog.csdn.net/yingpaixiaochuan/article/details/53729446)
+ [3.解决git中warning: LF will be replaced by CRLF](https://www.jianshu.com/p/37a775467d39)


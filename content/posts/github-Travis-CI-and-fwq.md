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

![](https://gitee.com/iwyang/pics/raw/master/20200608233741.jpg)

然后记下 Token 的值，也就是我打码的那一部分 (一定要记下来，因为离开这个页面之后就没有机会再次查看了)

## 3. 设置 Travis CI

接着来到 [Travis CI](https://travis-ci.org/account/repositories)，使用 GitHub 帐号登录；然后为 **`Blog`** 源码仓库打上 ☑，然后点 `setting`。

![](https://gitee.com/iwyang/pics/raw/master/20200608234521.jpg)

然后点击`hugo-backup`右边的`setting`，找到`Environment Variables`，填写 **Environment Variables**。

- **`Name`** 填写： `GITHUB_TOKEN`
- **`Value`** 填写：刚刚在 GitHub 申请到的 Token 的值

![](https://gitee.com/iwyang/pics/raw/master/20200608235114.png)

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

### 5.1.  备份源码到github

源码备份到github后， Travis CI 会自动部署Hugo，你甚至连 Hugo 都可以不要装。

```
git remote rm origin
git init
git add .
git commit -m "备份源码"
git remote add origin git@github.com:iwyang/hugo-backup.git
git push --force origin master
```

### 5.2.  提交public文件夹到服务器

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

##  5.3. 双线部署脚本
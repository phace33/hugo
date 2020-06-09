---
title: "Hugo添加Algolia"
subtitle: ""
date: 2020-06-03T23:17:48+08:00
lastmod: 2020-06-04T23:17:48+08:00
draft: false
toc:
  enable: true
weight: false
categories: ["建站笔记"]
tags: ["hugo"]
---

  本文以 [Loveit](https://github.com/dillonzq/LoveIt)主题为例进行说明，记录一下怎样在hugo添加[Algolia](https://www.algolia.com/)搜索以及自动化上传索引文件的方法。

## 1. 生成索引文件

### 1.1. Algolia创建空索引

+ 创建应用，自取名字(**注意：节点选择香港**)
+ 创建索引，自取名字(比如说hugo)
+ 点击侧栏 `API Keys`，记录信息(Application ID, Search-Only API Key, Admin API Key)

### 1.2. Hugo生成索引文件

参考上文[Hugo LoveIt主题配置与使用](https://iwyang.gitee.io/hugo-theme-loveit/)，修改`config.toml`相应Algolia参数即可。

## 2.上传索引文件

生成索引文件之后，我们需要上传到Algolia的服务器。

### 2.1. 手动上传

这一步是可选的，不过还是建议跟着做一下。

+ 点击侧栏` Indices —Add records—Upload file`按钮，上传上一步生成的 index.json 文件（具体位置在根目录public文件夹里）。
+ 上传成功之后，我们就可以马上尝试搜索了，如果看到搜索的关键词有相应的匹配结果，那么就说明我们生成的索引文件是正确的。

### 2.2. 自动上传

这里我们采用npm包 [atomic-algolia](https://www.npmjs.com/package/atomic-algolia) 来完成自动上传操作。准备条件：已经安装[Node.js](https://nodejs.org/en/)，安装过程略。

+ 安装 atomic-algolia 包

```
npm init  // 不懂的就一直回车就好了
npm install atomic-algolia --save
```

+ 修改根目录下的 `package.json` 文件，在 `scripts` 下添加 `"algolia": "atomic-algolia"`

```
"scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "algolia": "atomic-algolia"
},
```

注意 `"test"` 那一行末尾有个英文逗号，不要漏了。

+ 根目录下新建 `.env` 文件，内容如下：

```
ALGOLIA_APP_ID=你的Application ID
ALGOLIA_INDEX_NAME=你的索引名字
ALGOLIA_INDEX_FILE=public/index.json
ALGOLIA_ADMIN_KEY=你的Admin API Key
```

+ 上传索引的命令

你可以本地执行 `npm run algolia` 查看运行效果。后续就是把下面的命令加到你的自动部署脚本即可：

```
npm install
npm run algolia // 在hugo命令后面执行
```

### 2.3. 修改自动部署脚本

自动部署脚本改成这样：

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

至此，如果你运行 `npm run algolia` 没有报错的话，就成功了。

## 3. 参考链接

+ [1.Hugo添加Algolia搜索支持](https://edward852.github.io/post/hugo%E6%B7%BB%E5%8A%A0algolia%E6%90%9C%E7%B4%A2%E6%94%AF%E6%8C%81/)

+ [2.使用 Hugo + Algolia 进行静态站点搜索](https://dp2px.com/2019/09/07/hugo-algolia/)




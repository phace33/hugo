---
title: "hugo部署到coding"
date: 2020-05-13T09:42:06+08:00
draft: false
weight: false
categories: ["建站笔记"]
tags: ["hugo"]

---

## 本地操作

### 安装GIt

本地需要安装 [Git](https://git-scm.com/) ，安装过程略。安装完git后还要配置环境变量：
右键我的电脑 --> 属性，然后点击高级系统设置 --> 环境变量 --> 选择用户变量或系统变量中的Path,点击编辑；找到Git安装目录,添加以下地址:

```
D:\Program Files\Git\bin
D:\Program Files\Git\mingw64\libexec\git-core
D:\Program Files\Git\mingw64\bin
```

### 配置SSH 公钥

Windows 上安装 [Git for Windows](https://git-for-windows.github.io/) 之后在开始菜单里打开 Git Bash 输入：

```
git config --global user.name "你的用户名"
git config --global user.email "你的电子邮箱"
```

```
cd ~
mkdir .ssh
cd .ssh
ssh-keygen -t rsa
```

在系统当前用户文件夹下生成了私钥 `id_rsa` 和公钥 `id_rsa.pub`。

### 初始化 Hugo

#### 安装hugo

windows10下安装hugo，可以参照Hugo官方手册的方法，这里讲一个相对简单稳定的方法。

1.下载hugo程序压缩包：前往https://github.com/gohugoio/hugo/releases下载和自己系统版本相符合的hugo程序压缩包。(建议下载hugo_extended版本)

2.解压到某个文件夹中（路径不要有中文，而且自己要记得文件夹的路径），最好是不常改动的文件夹下边，以防文件被误删或者丢失。

3.添加hugo到系统环境变量PATH中

+ 找到“系统环境变量”的设置位置，在开始菜单的搜索栏搜索环境变量
+ 添加用户环境变量，依此：点击环境变量，找到用户变量中的path，点击编辑，然后点击新建，在使用浏览按钮选中文件夹，即可使用hugo。（选中到hugo.exe所在的文件夹即可，不需要选中hugo.exe，貌似添加完系统变量，要重启电脑才能在Git Bash里运行hugo）
+ 接下来，为了万无一失，还是要检查一下hugo是否安装完成。以管理员方式打开cmd命令窗口，然后输入以下指令：

```
hugo version
```

如果得到如下响应，（即显示版本信息），说明安装成功，接下来就可以玩转hugo了。

```
Hugo Static Site Generator v0.70.0/extended windows/amd64 BuildDate: unknown
```

#### 创建并配置站点

> 以下命令均在'Git Bash'中运行

进入你想存放 Hugo 网站文件夹的目录，执行以下命令：

```
hugo new site blog  
```

#### 添加主题

```
git clone https://github.com/olOwOlo/hugo-theme-even themes/even
```

附更新主题命令：

```
cd ./themes/even/
git pull
```

配置主题

将 根目录\themes\even\exampleSite路径下的config.toml文件复制到根目录下，覆盖掉根目录下的config.toml文件。然后，我们在notepad++中打开并对其作一定的修改就可以直接使用，具体可以修改的内容见：[config.toml的配置](https://blog.bore.vip/post/部署hugo笔记/#configtoml的配置)

#### 设置文章模板

为了更好的使用附加功能，我们提前修改一下模板。这样，每次使用新建一篇文档时候就省去很多麻烦事。
使用Typora文档工具打开themes/tranquilpeak/archetypes中的post.md直接替换为以下的模板：

```
---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
lastmod: {{ .Date }}
draft: false
weight: false
categories: [""]
tags: [""] 
```

　接下来在根目录下使用以下命令生成一篇文档吧：

```
hugo new post/XXXX.md
```

#### 新建“关于”页面

```
hugo new about.md
```

`config.toml`相应位置添加：

```
[[menu.main]]
  name = "关于"
  weight = 50
  identifier = "about"
  url = "/about/"
```

#### 启动博客的本地预览

建议在配置文件中设置好主题，或者使用 –t指令指定主题，在站点的根目录下使用命令进行本地启动，本地启动的命令如下：

```
hugo server -D
```

使用浏览器打开 http://localhost:1313 预览。

## 部署到coding

### coding上的操作

操作和部署到github大同小异，首先要在coding上开通pages静态网站服务，注意以下几点：

- 项目地址按iwyang.coding.me来写，建议勾选“启用readme.md初始化项目”
- 配置SSH公钥时要勾选启用推送权限。
- 开启Coding Pages 服务，要先在`项目设置—功能开关`里开启持续集成和持续部署。然后进行实名认证：右上角—团队管理—团队设置—高级设置。
- 删除项目，点左下角—项目设置—更多。
- 添加自定义域名，添加cname记录，指向给你的网址。线路选默认。这样就保证国内线路走coding。
- 注意：一定要选首选的域名，并且非首选域名要勾选跳转至首选域名，不然有些第三方服务数据会统计不到一起。
- 开启 HTTPS，要先去域名 DNS 把 GitHub 的解析暂停掉，然后再重新申请 SSL 证书，然后开启强制 HTTPS 访问。（不然会申请失败）
- 如果后面要用cdn全站加速，这里先不要开启ssl。

### 将本地仓库文件部署到Coding

```
rm -rf public/*
hugo
cd public
git remote rm origin
git init
git remote add origin git@e.coding.net:iwyang/hugo.git
git add .
git commit -m "Add a new post"
git push --force origin master
```

### 解决404错误

可是当你push完hugo生成的静态页面源码到你的repo中后点Coding给你分配的访问地址后却返回的是404页面，其实解决这个问题也很简单，就是点一下上图中的立即部署就行了。

### 自动备份脚本

为了后续更新方便起见，可以在根目录新建一个一键自动部署脚本，命名为`deploy.sh`（如果对配置不做大的改动（例如：更换主题等），后续的更新可以使用以下脚本）

```
#!/bin/bash

echo -e "\033[0;32mDeploying updates to vps...\033[0m"

# Removing existing files
rm -rf public/*
# Build the project
hugo
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

创建完脚本以后，不要忘了加权限

```
chmod 777 xxx
```

### 备份hugo源码

在coding上新建一个backup的分支，然后把下面代码加到`deploy.sh`末尾，这种方法有个问题，那就是themes等几个文件夹无法备份，还没找到原因。不过content文章文件夹可以备份，这样也行。

```
git remote rm origin
git init
git checkout -b backup
git add .
git commit -m "提交说明"
git remote add origin git@e.coding.net:iwyang/hugo.git 
git push --force origin backup
```

也可在github新建一个 私人仓库，将源码备份到私人仓库的master分支，代码如下：

```
git remote rm origin
git init
git add .
git commit -m "备份源码"
git remote add origin git@github.com:iwyang/hugo-backup.git
git push --force origin master
```

---

附网上找到的另外两个部署脚本：

官方脚本：

```
#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public
# Add changes to git.
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

另外一个脚本：

（如果用上面的自动部署脚本出现问题，可以试试这个，不过这个脚本部署时经常会导致部分页面丢失，还不知道原因）

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
git remote add origin git@e.coding.net:iwyang/hugo.git
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

---

### config.toml的配置

最后附上站点根目录config.toml的配置，所用主题是[Even](https://github.com/olOwOlo/hugo-theme-even)

```
baseURL = "https://blog.bore.vip/"
languageCode = "en"
defaultContentLanguage = "zh-cn"                             # en / zh-cn / ... (This field determines which i18n file to use)
title = "Bore's Notes"
preserveTaxonomyNames = true
enableRobotsTXT = true
enableEmoji = true
theme = "even"
enableGitInfo = false # use git commit log to generate lastmod record # 可根据 Git 中的提交生成最近更新记录。

# Syntax highlighting by Chroma. NOTE: Don't enable `highlightInClient` and `chroma` at the same time!
pygmentsOptions = "linenos=table"
pygmentsCodefences = true
pygmentsUseClasses = true
pygmentsCodefencesGuessSyntax = true

hasCJKLanguage = true     # has chinese/japanese/korean ? # 自动检测是否包含 中文\日文\韩文
paginate = 10                                              # 首页每页显示的文章数
disqusShortname = ""      # disqus_shortname
googleAnalytics = ""      # UA-XXXXXXXX-X
copyright = ""            # default: author.name ↓        # 默认为下面配置的author.name ↓

[author]                  # essential                     # 必需
  name = "bore"

[sitemap]                 # essential                     # 必需
  changefreq = "weekly"
  priority = 0.5
  filename = "sitemap.xml"

[[menu.main]]             # config your menu              # 配置目录
  name = "首页"
  weight = 10
  identifier = "home"
  url = "/"
[[menu.main]]
  name = "归档"
  weight = 20
  identifier = "archives"
  url = "/post/"
[[menu.main]]
  name = "标签"
  weight = 40
  identifier = "tags"
  url = "/tags/"
[[menu.main]]
  name = "分类"
  weight = 30
  identifier = "categories"
  url = "/categories/"

[params]
  version = "4.x"           # Used to give a friendly message when you have an incompatible update
  debug = false             # If true, load `eruda.min.js`. See https://github.com/liriliri/eruda

  since = "2020"            # Site creation time          # 站点建立时间
  # use public git repo url to link lastmod git commit, enableGitInfo should be true.
  # 指定 git 仓库地址，可以生成指向最近更新的 git commit 的链接，需要将 enableGitInfo 设置成 true.
  gitRepo = ""

  # site info (optional)                                  # 站点信息（可选，不需要的可以直接注释掉）
  logoTitle = "Bore's Notes"        # default: the title value    # 默认值: 上面设置的title值
  keywords = ["Hugo", "theme","even"]
  description = "Bore's Notes"

  # paginate of archives, tags and categories             # 归档、标签、分类每页显示的文章数目，建议修改为一个较大的值
  archivePaginate = 10000000

  # show 'xx Posts In Total' in archive page ?            # 是否在归档页显示文章的总数
  showArchiveCount = true

  # The date format to use; for a list of valid formats, see https://gohugo.io/functions/format/
  dateFormatToUse = "2006-01-02"

  # show word count and read time ?                       # 是否显示字数统计与阅读时间
  moreMeta = true

  # Syntax highlighting by highlight.js
  highlightInClient = false

  # 一些全局开关，你也可以在每一篇内容的 front matter 中针对单篇内容关闭或开启某些功能，在 archetypes/default.md 查看更多信息。
  # Some global options, you can also close or open something in front matter for a single post, see more information from `archetypes/default.md`.
  toc = true                                                                            # 是否开启目录
  autoCollapseToc = false   # Auto expand and collapse toc                              # 目录自动展开/折叠
  fancybox = true           # see https://github.com/fancyapps/fancybox                 # 是否启用fancybox（图片可点击）

  # mathjax
  mathjax = false           # see https://www.mathjax.org/                              # 是否使用mathjax（数学公式）
  mathjaxEnableSingleDollar = false                                                     # 是否使用 $...$ 即可進行inline latex渲染
  mathjaxEnableAutoNumber = false                                                       # 是否使用公式自动编号
  mathjaxUseLocalFiles = false  # You should install mathjax in `your-site/static/lib/mathjax`

  postMetaInFooter = true   # contain author, lastMod, markdown link, license           # 包含作者，上次修改时间，markdown链接，许可信息
  linkToMarkDown = false    # Only effective when hugo will output .md files.           # 链接到markdown原始文件（仅当允许hugo生成markdown文件时有效）
  contentCopyright = ''     # e.g. '<a rel="license noopener" href="https://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank">CC BY-NC-ND 4.0</a>'

  changyanAppid = ""        # Changyan app id             # 畅言
  changyanAppkey = ""       # Changyan app key

  livereUID = ""            # LiveRe UID                  # 来必力

  baiduPush = false        # baidu push                  # 百度
  baiduAnalytics = ""      # Baidu Analytics
  baiduVerification = ""   # Baidu Verification
  googleVerification = ""  # Google Verification         # 谷歌

  # Link custom CSS and JS assets
  #   (relative to /static/css and /static/js respectively)
  customCSS = []
  customJS = []

  uglyURLs = false          # please keep same with uglyurls setting

  [params.publicCDN]        # load these files from public cdn                          # 启用公共CDN，需自行定义
    enable = true
    jquery = '<script src="https://cdn.jsdelivr.net/npm/jquery@3.2.1/dist/jquery.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>'
    slideout = '<script src="https://cdn.jsdelivr.net/npm/slideout@1.0.1/dist/slideout.min.js" integrity="sha256-t+zJ/g8/KXIJMjSVQdnibt4dlaDxc9zXr/9oNPeWqdg=" crossorigin="anonymous"></script>'
    fancyboxJS = '<script src="https://cdn.jsdelivr.net/npm/@fancyapps/fancybox@3.1.20/dist/jquery.fancybox.min.js" integrity="sha256-XVLffZaxoWfGUEbdzuLi7pwaUJv1cecsQJQqGLe7axY=" crossorigin="anonymous"></script>'
    fancyboxCSS = '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fancyapps/fancybox@3.1.20/dist/jquery.fancybox.min.css" integrity="sha256-7TyXnr2YU040zfSP+rEcz29ggW4j56/ujTPwjMzyqFY=" crossorigin="anonymous">'
    timeagoJS = '<script src="https://cdn.jsdelivr.net/npm/timeago.js@3.0.2/dist/timeago.min.js" integrity="sha256-jwCP0NAdCBloaIWTWHmW4i3snUNMHUNO+jr9rYd2iOI=" crossorigin="anonymous"></script>'
    timeagoLocalesJS = '<script src="https://cdn.jsdelivr.net/npm/timeago.js@3.0.2/dist/timeago.locales.min.js" integrity="sha256-ZwofwC1Lf/faQCzN7nZtfijVV6hSwxjQMwXL4gn9qU8=" crossorigin="anonymous"></script>'
    flowchartDiagramsJS = '<script src="https://cdn.jsdelivr.net/npm/raphael@2.2.7/raphael.min.js" integrity="sha256-67By+NpOtm9ka1R6xpUefeGOY8kWWHHRAKlvaTJ7ONI=" crossorigin="anonymous"></script> <script src="https://cdn.jsdelivr.net/npm/flowchart.js@1.8.0/release/flowchart.min.js" integrity="sha256-zNGWjubXoY6rb5MnmpBNefO0RgoVYfle9p0tvOQM+6k=" crossorigin="anonymous"></script>'
    sequenceDiagramsCSS = '<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/bramp/js-sequence-diagrams@2.0.1/dist/sequence-diagram-min.css" integrity="sha384-6QbLKJMz5dS3adWSeINZe74uSydBGFbnzaAYmp+tKyq60S7H2p6V7g1TysM5lAaF" crossorigin="anonymous">'
    sequenceDiagramsJS = '<script src="https://cdn.jsdelivr.net/npm/webfontloader@1.6.28/webfontloader.js" integrity="sha256-4O4pS1SH31ZqrSO2A/2QJTVjTPqVe+jnYgOWUVr7EEc=" crossorigin="anonymous"></script> <script src="https://cdn.jsdelivr.net/npm/snapsvg@0.5.1/dist/snap.svg-min.js" integrity="sha256-oI+elz+sIm+jpn8F/qEspKoKveTc5uKeFHNNVexe6d8=" crossorigin="anonymous"></script> <script src="https://cdn.jsdelivr.net/npm/underscore@1.8.3/underscore-min.js" integrity="sha256-obZACiHd7gkOk9iIL/pimWMTJ4W/pBsKu+oZnSeBIek=" crossorigin="anonymous"></script> <script src="https://cdn.jsdelivr.net/gh/bramp/js-sequence-diagrams@2.0.1/dist/sequence-diagram-min.js" integrity="sha384-8748Vn52gHJYJI0XEuPB2QlPVNUkJlJn9tHqKec6J3q2r9l8fvRxrgn/E5ZHV0sP" crossorigin="anonymous"></script>'

  # Display a message at the beginning of an article to warn the readers that it's content may be outdated.
  # 在文章开头显示提示信息，提醒读者文章内容可能过时。
  [params.outdatedInfoWarning]
    enable = false
    hint = 30               # Display hint if the last modified time is more than these days ago.    # 如果文章最后更新于这天数之前，显示提醒
    warn = 180              # Display warning if the last modified time is more than these days ago.    # 如果文章最后更新于这天数之前，显示警告

  [params.gitment]          # Gitment is a comment system based on GitHub issues. see https://github.com/imsun/gitment
    owner = ""              # Your GitHub ID
    repo = ""               # The repo to store comments
    clientId = ""           # Your client ID
    clientSecret = ""       # Your client secret

  [params.utterances]       # https://utteranc.es/
    owner = ""              # Your GitHub ID
    repo = ""               # The repo to store comments

  [params.gitalk]           # Gitalk is a comment system based on GitHub issues. see https://github.com/gitalk/gitalk
    owner = ""              # Your GitHub ID
    repo = ""               # The repo to store comments
    clientId = ""           # Your client ID
    clientSecret = ""       # Your client secret

  # Valine.
  # You can get your appid and appkey from https://leancloud.cn
  # more info please open https://valine.js.org
  [params.valine]
    enable = false
    appId = '你的appId'
    appKey = '你的appKey'
    notify = false  # mail notifier , https://github.com/xCss/Valine/wiki
    verify = false # Verification code
    avatar = 'mm' 
    placeholder = '说点什么吧...'
    visitor = false

  [params.flowchartDiagrams]# see https://blog.olowolo.com/example-site/post/js-flowchart-diagrams/
    enable = false
    options = ""

  [params.sequenceDiagrams] # see https://blog.olowolo.com/example-site/post/js-sequence-diagrams/
    enable = false
    options = ""            # default: "{theme: 'simple'}"

  [params.busuanzi]         # count web traffic by busuanzi                             # 是否使用不蒜子统计站点访问量
    enable = false
    siteUV = true
    sitePV = true
    pagePV = true

  [params.reward]                                         # 文章打赏
    enable = false
    wechat = "/path/to/your/wechat-qr-code.png"           # 微信二维码
    alipay = "/path/to/your/alipay-qr-code.png"           # 支付宝二维码

  [params.social]                                         # 社交链接
    a-email = "mailto:iwyang@qq.com"
    g-github = "https://github.com/iwyang"
    o-bilibili = "https://space.bilibili.com/20475120"

# See https://gohugo.io/about/hugo-and-gdpr/
[privacy]
  [privacy.googleAnalytics]
    anonymizeIP = true      # 12.214.31.144 -> 12.214.31.0
  [privacy.youtube]
    privacyEnhanced = true

# 将下面这段配置取消注释可以使 hugo 生成 .md 文件
# Uncomment these options to make hugo output .md files.
#[mediaTypes]
#  [mediaTypes."text/plain"]
#    suffixes = ["md"]
#
#[outputFormats.MarkDown]
#  mediaType = "text/plain"
#  isPlainText = true
#  isHTML = false
#
#[outputs]
#  home = ["HTML", "RSS"]
#  page = ["HTML", "MarkDown"]
#  section = ["HTML", "RSS"]
#  taxonomy = ["HTML", "RSS"]
#  taxonomyTerm = ["HTML"]

```

## 参考链接

[1.Hugo+github搭建个人博客 (windows10)](https://saquarius.com/2019/07/hugo-github%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2windows10/#%E5%87%86%E5%A4%87%E5%B7%A5%E4%BD%9C)

[2.如何利用 GitHub Pages 和 Hugo 轻松搭建个人博客？](https://zhuanlan.zhihu.com/p/57361697)

[3.Hugo 从入门到会用](https://blog.olowolo.com/post/hugo-quick-start/)


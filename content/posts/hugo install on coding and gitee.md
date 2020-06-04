---
title: "hugo部署到coding&gitee"
date: 2020-05-13T09:42:06+08:00
draft: false
weight: false
categories: ["建站笔记"]
tags: ["hugo"]

---

## 1. 本地操作

### 1.1. 安装GIt

本地需要安装 [Git](https://git-scm.com/) ，安装过程略。安装完git后还要配置环境变量：
右键我的电脑 --> 属性，然后点击高级系统设置 --> 环境变量 --> 选择用户变量或系统变量中的Path,点击编辑；找到Git安装目录,添加以下地址:

```
D:\Program Files\Git\bin
D:\Program Files\Git\mingw64\libexec\git-core
D:\Program Files\Git\mingw64\bin
```

### 1.2. 配置SSH 公钥

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

### 1.3. 初始化 Hugo

#### 1.3.1. 安装hugo

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

#### 1.3.2. 创建并配置站点

> 以下命令均在'Git Bash'中运行

进入你想存放 Hugo 网站文件夹的目录，执行以下命令：

```
hugo new site blog  
```

#### 1.3.3. 添加主题

```
git clone https://github.com/dillonzq/LoveIt.git themes/LoveIt
```

附更新主题命令：

```
cd ./themes/LoveIt/
git pull
```

配置主题

将 根目录\themes\even\exampleSite路径下的config.toml文件复制到根目录下，覆盖掉根目录下的config.toml文件。然后，我们在notepad++中打开并对其作一定的修改就可以直接使用。

#### 1.3.4. 配置config.toml

```
baseURL = "https://example.com"
# [en, zh-cn, fr, pl, ...] determines default content language
# [en, zh-cn, fr, pl, ...] 设置默认的语言
defaultContentLanguage = "zh-cn"
# theme
# 主题
theme = "LoveIt"

# website title
# 网站标题
title = "Bore's Note"

# whether to use robots.txt
# 是否使用 robots.txt
enableRobotsTXT = true
# whether to use git commit log
# 是否使用 git 信息
enableGitInfo = true
# whether to use emoji code
# 是否使用 emoji 代码
enableEmoji = true

    # 菜单配置
	  [[languages.zh-cn.menu.main]]
        identifier = "home"
        pre = ""
        post = ""
        name = "首页"
        url = "/"
        title = ""
        weight = 1
      [[languages.zh-cn.menu.main]]
        identifier = "posts"
        # 你可以在名称 (允许 HTML 格式) 之前添加其他信息, 例如图标
        pre = ""
        # 你可以在名称 (允许 HTML 格式) 之后添加其他信息, 例如图标
        post = ""
        name = "归档"
        url = "/posts/"
        title = ""
        weight = 4
      [[languages.zh-cn.menu.main]]
        identifier = "tags"
        pre = ""
        post = ""
        name = "标签"
        url = "/tags/"
        title = ""
        weight = 3
      [[languages.zh-cn.menu.main]]
        identifier = "categories"
        pre = ""
        post = ""
        name = "分类"
        url = "/categories/"
        title = ""
        weight = 2
      [[languages.zh-cn.menu.main]]
        identifier = "about"
        pre = ""
        post = ""
        name = "关于"
        url = "/about/"
        title = ""
        weight = 5
    [languages.zh-cn.params]
      # 网站描述
      description = "学习、记录、成长"
      # 网站关键词
      keywords = ["个人博客", "笔记"]
      # 应用图标配置
      [languages.zh-cn.params.app]
        # 当添加到 iOS 主屏幕或者 Android 启动器时的标题, 覆盖默认标题
        title = "LoveIt"
        # 是否隐藏网站图标资源链接
        noFavicon = false
        # 更现代的 SVG 网站图标, 可替代旧的 .png 和 .ico 文件
        svgFavicon = ""
        # Android 浏览器主题色
        themeColor = "#ffffff"
        # Safari 图标颜色
        iconColor = "#5bbad5"
        # Windows v8-10 磁贴颜色
        tileColor = "#da532c"
      # 搜索配置
      [languages.zh-cn.params.search]
        enable = true
        # 搜索引擎的类型 ("lunr", "algolia")
        type = "algolia"
        # 文章内容最长索引长度
        contentLength = 4000
        # 搜索框的占位提示语
        placeholder = ""
        # 最大结果数目
        maxResultLength = 10
        # 结果内容片段长度
        snippetLength = 50
        # 搜索结果中高亮部分的 HTML 标签
        highlightTag = "em"
        # 是否在搜索索引中使用基于 baseURL 的绝对路径
        absoluteURL = false
        [languages.zh-cn.params.search.algolia]
          index = "hugo"
          appID = "W3GPBH19ZO"
          searchKey = "5e21a3d054db52bb93d8bc274394d1b5"
      # 主页信息设置
      [languages.zh-cn.params.home]
        # RSS 文章数目
        rss = 10
        # 主页个人信息
        [languages.zh-cn.params.home.profile]
          enable = true
          # Gravatar 邮箱，用于优先在主页显示的头像
          gravatarEmail = ""
          # 主页显示头像的 URL
          avatarURL = "/images/avatar.jpg"
          # 主页显示的网站标题 (支持 HTML 格式)
          title = ""
          # 主页显示的网站副标题
          subtitle = "不必仰望别人，自己亦是风景"
          # 是否为副标题显示打字机动画
          typeit = true
          # 是否显示社交账号
          social = true
          # 免责声明 (支持 HTML 格式)
          disclaimer = ""
        # 主页文章列表
        [languages.zh-cn.params.home.posts]
          enable = true
          # 主页每页显示文章数量
          paginate = 6
      # 主页的社交信息设置
      [languages.zh-cn.params.social]
        GitHub = "iwyang"
        Linkedin = ""
        Twitter = ""
        Instagram = ""
        Facebook = ""
        Telegram = ""
        Medium = ""
        Gitlab = ""
        Youtubelegacy = ""
        Youtubecustom = ""
        Youtubechannel = ""
        Tumblr = ""
        Quora = ""
        Keybase = ""
        Pinterest = ""
        Reddit = ""
        Codepen = ""
        FreeCodeCamp = ""
        Bitbucket = ""
        Stackoverflow = ""
        Weibo = ""
        Odnoklassniki = ""
        VK = ""
        Flickr = ""
        Xing = ""
        Snapchat = ""
        Soundcloud = ""
        Spotify = ""
        Bandcamp = ""
        Paypal = ""
        Fivehundredpx = ""
        Mix = ""
        Goodreads = ""
        Lastfm = ""
        Foursquare = ""
        Hackernews = ""
        Kickstarter = ""
        Patreon = ""
        Steam = ""
        Twitch = ""
        Strava = ""
        Skype = ""
        Whatsapp = ""
        Zhihu = ""
        Douban = "185432529"
        Angellist = ""
        Slidershare = ""
        Jsfiddle = ""
        Deviantart = ""
        Behance = ""
        Dribbble = ""
        Wordpress = ""
        Vine = ""
        Googlescholar = ""
        Researchgate = ""
        Mastodon = ""
        Thingiverse = ""
        Devto = ""
        Gitea = ""
        XMPP = ""
        Matrix = ""
        Bilibili = "20475120"
        Email = "iwyang@qq.com"
        RSS = true

 [params]
  # LoveIt theme version
  # LoveIt 主题版本
  version = "0.2.X"
  # site default theme ("light", "dark", "auto")
  # 网站默认主题 ("light", "dark", "auto")
  defaultTheme = "auto"
  # public git repo url only then enableGitInfo is true
  # 公共 git 仓库路径，仅在 enableGitInfo 设为 true 时有效
  gitRepo = "https://github.com/iwyang/hugo-backup"
  # which hash function used for SRI, when empty, no SRI is used ("sha256", "sha384", "sha512", "md5")
  # 哪种哈希函数用来 SRI, 为空时表示不使用 SRI ("sha256", "sha384", "sha512", "md5")
  fingerprint = ""
  # date format
  # 日期格式
  dateFormat = "2006-01-02"
  # website images for Open Graph and Twitter Cards
  # 网站图片, 用于 Open Graph 和 Twitter Cards
  images = ["/logo.png"]

  # Header config
  # 页面头部导航栏配置
  [params.header]
    # desktop header mode ("fixed", "normal", "auto")
    # 桌面端导航栏模式 ("fixed", "normal", "auto")
    desktopMode = "fixed"
    # mobile header mode ("fixed", "normal", "auto")
    # 移动端导航栏模式 ("fixed", "normal", "auto")
    mobileMode = "auto"
    # Header title config
    # 页面头部导航栏标题配置
    [params.header.title]
      # URL of the LOGO
      # LOGO 的 URL
      logo = ""
      # title name
      # 标题名称
      name = "cd /home"
      # you can add extra information before the name (HTML format is supported), such as icons
      # 你可以在名称 (允许 HTML 格式) 之前添加其他信息, 例如图标
      pre = "<i class='far fa-kiss-wink-heart fa-fw'></i>"
      # you can add extra information after the name (HTML format is supported), such as icons
      # 你可以在名称 (允许 HTML 格式) 之后添加其他信息, 例如图标
      post = ""
      # whether to use typeit animation for title name
      # 是否为标题显示打字机动画
      typeit = true

  # Footer config
  # 页面底部信息配置
  [params.footer]
    enable = true
    # Custom content (HTML format is supported)
    # 自定义内容 (支持 HTML 格式)
    custom = ''
    # whether to show Hugo and theme info
    # 是否显示 Hugo 和主题信息
    hugo = true
    # whether to show copyright info
    # 是否显示版权信息
    copyright = true
    # whether to show the author
    # 是否显示作者
    author = true
    # site creation time
    # 网站创立年份
    since = 2020
    # ICP info only in China (HTML format is supported)
    # ICP 备案信息，仅在中国使用 (支持 HTML 格式)
    icp = ""
    # license info (HTML format is supported)
    # 许可协议信息 (支持 HTML 格式)
    license= '<a rel="license external nofollow noopener noreffer" href="https://creativecommons.org/licenses/by-nc/4.0/" target="_blank">CC BY-NC 4.0</a>'

  # Section (all posts) page config
  # Section (所有文章) 页面配置
  [params.section]
    # special amount of posts in each section page
    # section 页面每页显示文章数量
    paginate = 10000000
    # date format (month and day)
    # 日期格式 (月和日)
    dateFormat = "01-02"
    # amount of RSS pages
    # RSS 文章数目
    rss = 10

  # List (category or tag) page config
  # List (目录或标签) 页面配置
  [params.list]
    # special amount of posts in each list page
    # list 页面每页显示文章数量
    paginate = 10000000
    # date format (month and day)
    # 日期格式 (月和日)
    dateFormat = "01-02"
    # amount of RSS pages
    # RSS 文章数目
    rss = 10

  # Page config
  # 文章页面配置
  [params.page]
    # whether to hide a page from home page
    # 是否在主页隐藏一篇文章
    hiddenFromHomePage = false
    # whether to hide a page from search results
    # 是否在搜索结果中隐藏一篇文章
    hiddenFromSearch = false
    # whether to enable twemoji
    # 是否使用 twemoji
    twemoji = false
    # whether to enable lightgallery
    # 是否使用 lightgallery
    lightgallery = false
    # whether to enable the ruby extended syntax
    # 是否使用 ruby 扩展语法
    ruby = true
    # whether to enable the fraction extended syntax
    # 是否使用 fraction 扩展语法
    fraction = true
    # whether to enable the fontawesome extended syntax
    # 是否使用 fontawesome 扩展语法
    fontawesome = true
    # whether to show link to Raw Markdown content of the content
    # 是否显示原始 Markdown 文档内容的链接
    linkToMarkdown = true
    # whether to show the full text content in RSS
    # 是否在 RSS 中显示全文内容
    rssFullText = false
    # Table of the contents config
    # 目录配置
    [params.page.toc]
      # whether to enable the table of the contents
      # 是否使用目录
      enable = true
      # whether to keep the static table of the contents in front of the post
      # 是否保持使用文章前面的静态目录
      keepStatic = false
      # whether to make the table of the contents in the sidebar automatically collapsed
      # 是否使侧边目录自动折叠展开
      auto = true
    # Code config
    # 代码配置
    [params.page.code]
      # whether to show the copy button of the code block
      # 是否显示代码块的复制按钮
      copy = true
      # the maximum number of lines of displayed code by default
      # 默认展开显示的代码行数
      maxShownLines = 10
    # KaTeX mathematical formulas config (KaTeX https://katex.org/)
    # KaTeX 数学公式配置 (KaTeX https://katex.org/)
    [params.page.math]
      enable = false
      # default block delimiter is $$ ... $$ and \\[ ... \\]
      # 默认块定界符是 $$ ... $$ 和 \\[ ... \\]
      blockLeftDelimiter = ""
      blockRightDelimiter = ""
      # default inline delimiter is $ ... $ and \\( ... \\)
      # 默认行内定界符是 $ ... $ 和 \\( ... \\)
      inlineLeftDelimiter = ""
      inlineRightDelimiter = ""
      # KaTeX extension copy_tex
      # KaTeX 插件 copy_tex
      copyTex = true
      # KaTeX extension mhchem
      # KaTeX 插件 mhchem
      mhchem = true
    # Mapbox GL JS config (Mapbox GL JS https://docs.mapbox.com/mapbox-gl-js)
    # Mapbox GL JS 配置 (Mapbox GL JS https://docs.mapbox.com/mapbox-gl-js)
    [params.page.mapbox]
      # access token of Mapbox GL JS
      # Mapbox GL JS 的 access token
      accessToken = "pk.eyJ1IjoiZGlsbG9uenEiLCJhIjoiY2s2czd2M2x3MDA0NjNmcGxmcjVrZmc2cyJ9.aSjv2BNuZUfARvxRYjSVZQ"
      # style for the light theme
      # 浅色主题的地图样式
      lightStyle = "mapbox://styles/mapbox/light-v10?optimize=true"
      # style for the dark theme
      # 深色主题的地图样式
      darkStyle = "mapbox://styles/mapbox/dark-v10?optimize=true"
      # whether to add NavigationControl (https://docs.mapbox.com/mapbox-gl-js/api/#navigationcontrol)
      # 是否添加 NavigationControl (https://docs.mapbox.com/mapbox-gl-js/api/#navigationcontrol)
      navigation = true
      # whether to add GeolocateControl (https://docs.mapbox.com/mapbox-gl-js/api/#geolocatecontrol)
      # 是否添加 GeolocateControl (https://docs.mapbox.com/mapbox-gl-js/api/#geolocatecontrol)
      geolocate = true
      # whether to add ScaleControl (https://docs.mapbox.com/mapbox-gl-js/api/#scalecontrol)
      # 是否添加 ScaleControl (https://docs.mapbox.com/mapbox-gl-js/api/#scalecontrol)
      scale = true
      # whether to add FullscreenControl (https://docs.mapbox.com/mapbox-gl-js/api/#fullscreencontrol)
      # 是否添加 FullscreenControl (https://docs.mapbox.com/mapbox-gl-js/api/#fullscreencontrol)
      fullscreen = true
    # Social share links in post page
    # 文章页面的分享信息设置
    [params.page.share]
      enable = false
      Twitter = true
      Facebook = true
      Linkedin = false
      Whatsapp = false
      Pinterest = false
      Tumblr = false
      HackerNews = true
      Reddit = false
      VK = false
      Buffer = false
      Xing = false
      Line = true
      Instapaper = false
      Pocket = false
      Digg = false
      Stumbleupon = false
      Flipboard = false
      Weibo = true
      Renren = false
      Myspace = false
      Blogger = false
      Baidu = false
      Odnoklassniki = false
      Evernote = false
      Skype = false
      Trello = false
      Mix = false
    # Comment config
    # 评论系统设置
    [params.page.comment]
      enable = true
      # Disqus comment config (https://disqus.com/)
      # Disqus 评论系统设置 (https://disqus.com/)
      [params.page.comment.disqus]
        enable = false
        # Disqus shortname to use Disqus in posts
        # Disqus 的 shortname，用来在文章中启用 Disqus 评论系统
        shortname = ""
      # Gitalk comment config (https://github.com/gitalk/gitalk)
      # Gitalk 评论系统设置 (https://github.com/gitalk/gitalk)
      [params.page.comment.gitalk]
        enable = false
        owner = ""
        repo = ""
        clientId = ""
        clientSecret = ""
      # Valine comment config (https://github.com/xCss/Valine)
      # Valine 评论系统设置 (https://github.com/xCss/Valine)
      [params.page.comment.valine]
        enable = true
        appId = "CNeyW3xuBg8PWJwDI0ig1AE2-MdYXbMMI"
        appKey = "HrJsI7Cl93RIa8Cks5qtkSsE"
        placeholder = "在这里留下足迹吧!(留下昵称和邮箱即可收到回复邮件提醒哦)"
        avatar = "mp"
        meta= ['nick','mail']
        pageSize = 10
        lang = ""
        visitor = true
        recordIP = false
        highlight = true
        enableQQ = false
        serverURLs = ""
        # emoji data file name, default is "google.yml"
        # ("apple.yml", "google.yml", "facebook.yml", "twitter.yml")
        # located in "themes/LoveIt/assets/data/emoji/" directory
        # you can store your own data files in the same path under your project:
        # "assets/data/emoji/"
        # emoji 数据文件名称, 默认是 "google.yml"
        # ("apple.yml", "google.yml", "facebook.yml", "twitter.yml")
        # 位于 "themes/LoveIt/assets/data/emoji/" 目录
        # 可以在你的项目下相同路径存放你自己的数据文件:
        # "assets/data/emoji/"
        emoji = ""
      # Facebook comment config (https://developers.facebook.com/docs/plugins/comments)
      # Facebook 评论系统设置 (https://developers.facebook.com/docs/plugins/comments)
      [params.page.comment.facebook]
        enable = false
        width = "100%"
        numPosts = 10
        appId = ""
        languageCode = ""
      # Telegram comments config (https://comments.app/)
      # Telegram comments 评论系统设置 (https://comments.app/)
      [params.page.comment.telegram]
        enable = false
        siteID = ""
        limit = 5
        height = ""
        color = ""
        colorful = true
        dislikes = false
        outlined = false
      # Commento comment config (https://commento.io/)
      # Commento comment 评论系统设置 (https://commento.io/)
      [params.page.comment.commento]
        enable = false
      # Utterances comment config (https://utteranc.es/)
      # Utterances comment 评论系统设置 (https://utteranc.es/)
      [params.page.comment.utterances]
        enable = false
        # owner/repo
        repo = ""
        issueTerm = "pathname"
        label = ""
        lightTheme = "github-light"
        darkTheme = "github-dark"
    # Third-party library config
    # 第三方库配置
    [params.page.library]
      [params.page.library.css]
        # someCSS = "some.css"
        # located in "assets/" 位于 "assets/"
        # Or 或者
        # someCSS = "https://cdn.example.com/some.css"
      [params.page.library.js]
        # someJavascript = "some.js"
        # located in "assets/" 位于 "assets/"
        # Or 或者
        # someJavascript = "https://cdn.example.com/some.js"
    # Page SEO config
    # 页面 SEO 配置
    [params.page.seo]
      # image URL
      # 图片 URL
      images = []
      # Publisher info
      # 出版者信息
      [params.page.seo.publisher]
        name = "xxxx"
        logoUrl = "/images/avatar.png"

  # TypeIt config
  # TypeIt 配置
  [params.typeit]
    # typing speed between each step (measured in milliseconds)
    # 每一步的打字速度 (单位是毫秒)
    speed = 100
    # blinking speed of the cursor (measured in milliseconds)
    # 光标的闪烁速度 (单位是毫秒)
    cursorSpeed = 1000
    # character used for the cursor (HTML format is supported)
    # 光标的字符 (支持 HTML 格式)
    cursorChar = "|"
    # cursor duration after typing finishing (measured in milliseconds, "-1" means unlimited)
    # 打字结束之后光标的持续时间 (单位是毫秒, "-1" 代表无限大)
    duration = -1

  # Site verification code for Google/Bing/Yandex/Pinterest/Baidu
  # 网站验证代码，用于 Google/Bing/Yandex/Pinterest/Baidu
  [params.verification]
    google = ""
    bing = ""
    yandex = ""
    pinterest = ""
    baidu = ""

  # Site SEO config
  # 网站 SEO 配置
  [params.seo]
    # image URL
    # 图片 URL
    image = "/images/Apple-Devices-Preview.png"
    # thumbnail URL
    # 缩略图 URL
    thumbnailUrl = "/images/screenshot.png"

  # Analytics config
  # 网站分析配置
  [params.analytics]
    enable = false
    # Google Analytics
    [params.analytics.google]
      id = ""
      # whether to anonymize IP
      # 是否匿名化用户 IP
      anonymizeIP = true
    # Fathom Analytics
    [params.analytics.fathom]
      id = ""
      # server url for your tracker if you're self hosting
      # 自行托管追踪器时的主机路径
      server = ""

  # Cookie consent config
  # Cookie 许可配置
  [params.cookieconsent]
    enable = false
    # text strings used for Cookie consent banner
    # 用于 Cookie 许可横幅的文本字符串
    [params.cookieconsent.content]
      message = ""
      dismiss = ""
      link = ""

  # CDN config for third-party library files
  # 第三方库文件的 CDN 设置
  [params.cdn]
    # CDN data file name, disabled by default
    # ("jsdelivr.yml")
    # located in "themes/LoveIt/assets/data/cdn/" directory
    # you can store your own data files in the same path under your project:
    # "assets/data/cdn/"
    # CDN 数据文件名称, 默认不启用
    # ("jsdelivr.yml")
    # 位于 "themes/LoveIt/assets/data/cdn/" 目录
    # 可以在你的项目下相同路径存放你自己的数据文件:
    # "assets/data/cdn/"
    data = "jsdelivr.yml"

  # Compatibility config
  # 兼容性设置
  [params.compatibility]
    # whether to use Polyfill.io to be compatible with older browsers
    # 是否使用 Polyfill.io 来兼容旧式浏览器
    polyfill = false
    # whether to use object-fit-images to be compatible with older browsers
    # 是否使用 object-fit-images 来兼容旧式浏览器
    objectFit = false

# Markup related configuration in Hugo
# Hugo 解析文档的配置
[markup]
  # Syntax Highlighting (https://gohugo.io/content-management/syntax-highlighting)
  # 语法高亮设置 (https://gohugo.io/content-management/syntax-highlighting)
  [markup.highlight]
    codeFences = true
    guessSyntax = true
    lineNos = true
    lineNumbersInTable = true
    # false is a necessary configuration (https://github.com/dillonzq/LoveIt/issues/158)
    # false 是必要的设置 (https://github.com/dillonzq/LoveIt/issues/158)
    noClasses = false
  # Goldmark is from Hugo 0.60 the default library used for Markdown
  # Goldmark 是 Hugo 0.60 以来的默认 Markdown 解析库
  [markup.goldmark]
    [markup.goldmark.extensions]
      definitionList = true
      footnote = true
      linkify = true
      strikethrough = true
      table = true
      taskList = true
      typographer = true
    [markup.goldmark.renderer]
      # whether to use HTML tags directly in the document
      # 是否在文档中直接使用 HTML 标签
      unsafe = true
  # Table Of Contents settings
  # 目录设置
  [markup.tableOfContents]
    startLevel = 2
    endLevel = 6

# Author config
# 作者配置
[author]
  name = "bore"
  email = "iwyang@qq.com"
  link = ""

# Sitemap config
# 网站地图配置
[sitemap]
  changefreq = "weekly"
  filename = "sitemap.xml"
  priority = 0.5

# Permalinks config (https://gohugo.io/content-management/urls/#permalinks)
# Permalinks 配置 (https://gohugo.io/content-management/urls/#permalinks)
[Permalinks]
  # posts = ":year/:month/:filename"
  posts = ":filename"

# Privacy config (https://gohugo.io/about/hugo-and-gdpr/)
# 隐私信息配置 (https://gohugo.io/about/hugo-and-gdpr/)
[privacy]
  # privacy of the Google Analytics (replaced by params.analytics.google)
  # Google Analytics 相关隐私 (被 params.analytics.google 替代)
  [privacy.googleAnalytics]
    # ...
  [privacy.twitter]
    enableDNT = true
  [privacy.youtube]
    privacyEnhanced = true

# Options to make output .md files
# 用于输出 Markdown 格式文档的设置
[mediaTypes]
  [mediaTypes."text/plain"]
    suffixes = ["md"]

# Options to make output .md files
# 用于输出 Markdown 格式文档的设置
[outputFormats.MarkDown]
  mediaType = "text/plain"
  isPlainText = true
  isHTML = false

# Options to make hugo output files
# 用于 Hugo 输出文档的设置
[outputs]
  home = ["HTML", "RSS", "JSON"]
  page = ["HTML", "MarkDown"]
  section = ["HTML", "RSS"]
  taxonomy = ["HTML", "RSS"]
  taxonomyTerm = ["HTML"]
```

#### 1.3.5. 设置文章模板

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

#### 1.3.6. 新建“关于”页面

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

#### 1.3.7. 启动博客的本地预览

建议在配置文件中设置好主题，或者使用 –t指令指定主题，在站点的根目录下使用命令进行本地启动，本地启动的命令如下：

```
hugo server -D
```

使用浏览器打开 http://localhost:1313 预览。

## 2. 部署到coding

### 2.1. coding上的操作

操作和部署到github大同小异，首先要在coding上开通pages静态网站服务，注意以下几点：

- 项目地址按iwyang.coding.me来写，建议勾选“启用readme.md初始化项目”
- 配置SSH公钥时要勾选启用推送权限。
- 开启Coding Pages 服务，要先在`项目设置—功能开关`里开启持续集成和持续部署。然后进行实名认证：右上角—团队管理—团队设置—高级设置。
- 删除项目，点左下角—项目设置—更多。
- 添加自定义域名，添加cname记录，指向给你的网址。线路选默认。这样就保证国内线路走coding。
- 注意：一定要选首选的域名，并且非首选域名要勾选跳转至首选域名，不然有些第三方服务数据会统计不到一起。
- 开启 HTTPS，要先去域名 DNS 把 GitHub 的解析暂停掉，然后再重新申请 SSL 证书，然后开启强制 HTTPS 访问。（不然会申请失败）
- 如果后面要用cdn全站加速，这里先不要开启ssl。

### 2.2. 提交本地仓库

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

### 2.3. 解决404错误

可是当你push完hugo生成的静态页面源码到你的repo中后点Coding给你分配的访问地址后却返回的是404页面，其实解决这个问题也很简单，就是点一下上图中的立即部署就行了。

### 2.4. 自动备份脚本

为了后续更新方便起见，可以在根目录新建一个一键自动部署脚本，命名为`deploy.sh`（如果对配置不做大的改动（例如：更换主题等），后续的更新可以使用以下脚本）

```
#!/bin/bash

echo -e "\033[0;32mDeploying updates to gitee...\033[0m"

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

## 3. 部署到gitee

和部署到coding大同小异，但需要注意以下几点：

免费版gitee page不支持绑定域名、不支持自动部署，并且上传了代码服务里才有gitee pages选项。还有关于首页地址见官方文档：

>如何创建一个首页访问地址不带二级目录的 pages，如ipvb.gitee.io？

答：如果你想你的 pages 首页访问地址不带二级目录，如ipvb.gitee.io，你需要建立一个与自己个性地址同名的仓库，如 https://gitee.com/ipvb 这个用户，想要创建一个自己的站点，但不想以子目录的方式访问，想以ipvb.gitee.io直接访问，那么他就可以创建一个名字为ipvb的仓库 https://gitee.com/ipvb/ipvb 部署完成后，就可以以 https://ipvb.gitee.io 进行访问了。

### 3.1. 提交本地仓库

```
rm -rf public/*
hugo
cd public
git remote rm origin
git init
git remote add origin git@gitee.com:iwyang/iwyang.git
git add .
git commit -m "Add a new post"
git push origin master --force
```

### 3.2. 备份hugo源码

```
git remote rm origin
git init
git checkout -b backup
git add .
git commit -m "备份源码"
git remote add origin git@gitee.com:iwyang/iwyang.git
git push origin backup --force
```

## 4. 备份hugo源码

### 4.1. 备份到gitee backup分支

在gitee上新建一个backup的分支，然后把下面代码加到`deploy.sh`末尾，这种方法有个问题，那就是themes等几个文件夹无法备份，还没找到原因。不过content文章文件夹可以备份，这样也行。

```
git remote rm origin
git init
git checkout -b backup
git add .
git commit -m "备份源码"
git remote add origin git@gitee.com:iwyang/iwyang.git
git push --force origin backup
```

---

PS: **如果执行第三步`git checkout -b backup`后，提示`fatal: A branch named 'backup' already exists.`，则执行以下操作：**

```
git branch -D backup    #删除分支:必须切换到其他的分之下才可操作
git checkout -b backup  #切换分支
```

### 4.2. 备份到github master分支

按理说备份到私人仓库为好，可为了`GitInfo`以及`lastmod`生效，需要新建一个公共仓库。（注意要先备份源码到github上，再部署public里的网页到服务器上，为了方便，需要在自动部署脚本里作相应设置）

**再次强调，只有先备份了源码到github，再部署网页，`lastmod`才会更新**

```
git remote rm origin
git init
git add .
git commit -m "备份源码"
git remote add origin git@github.com:iwyang/hugo-backup.git
git push --force origin master
```

然后在`config.toml`里作如下修改

```
enableGitInfo = true
gitRepo = "https://github.com/iwyang/hugo-backup"
```

## 5. 参考链接

[1.Hugo+github搭建个人博客 (windows10)](https://saquarius.com/2019/07/hugo-github%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2windows10/#%E5%87%86%E5%A4%87%E5%B7%A5%E4%BD%9C)

[2.如何利用 GitHub Pages 和 Hugo 轻松搭建个人博客？](https://zhuanlan.zhihu.com/p/57361697)

[3.Hugo 从入门到会用](https://blog.olowolo.com/post/hugo-quick-start/)

[4.码云Pages](https://gitee.com/help/articles/4136#article-header0)
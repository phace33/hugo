---
title: "Hugo LoveIt主题配置与使用"
subtitle: ""
date: 2020-06-03T22:44:36+08:00
lastmod: 2020-06-03T22:44:36+08:00
draft: false
toc:
  enable: true
weight: false
categories: ["建站笔记"]
tags: ["hugo"]
---

  ## 1. 安装主题

把这个主题克隆到 `themes` 目录:

```
git clone https://github.com/dillonzq/LoveIt.git themes/LoveIt
```

## 2. 配置主题

### 2.1 站点配置文件的修改

将`根目录\themes\LoveIt\exampleSite`路径下的`config.toml`文件复制到根目录下，覆盖掉根目录下的`config.toml`文件。然后，我们在notepad++中打开并对其作一定的修改就可以直接使用，具体可以修改的内容如下：

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
title = "Yang's Note"

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
          index = ""
          appID = ""
          searchKey = ""
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
  gitRepo = "https://github.com/dillonzq/LoveIt"
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
      name = "Yang's Note"
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
        enable = false
        appId = ""
        appKey = ""
        placeholder = ""
        avatar = "mp"
        meta= ""
        pageSize = 10
        lang = ""
        visitor = true
        recordIP = true
        highlight = true
        enableQQ = false
        serverURLs = "https://leancloud.hugoloveit.com"
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
  name = "yang"
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

其中搜索和评论部分，要根据实际情况修改。

### 2.2 默认文章模板的修改

将`根目录\archetypes`下的`default.md`修改如下：

```
title: "{{ replace .TranslationBaseName "-" " " | title }}"
subtitle: ""
date: {{ .Date }}
lastmod: {{ .Date }}
draft: false
toc:
  enable: true
weight: false
categories: [""]
tags: [""]
```

## 3. 官方文档

更多内容可查看官方文档：[主题文档 - 基本概念](https://hugoloveit.com/zh-cn/theme-documentation-basics/)

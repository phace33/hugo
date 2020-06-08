---
title: "hugo使用Valine并配置邮件提醒"
subtitle: ""
date: 2020-06-06T10:39:27+08:00
lastmod: 2020-06-06T10:39:27+08:00
draft: false
toc:
  enable: true
weight: false
categories: ["建站笔记"]
tags: ["hugo"]
---

## 1. 注册 Valine

注意右上角选择**国际版**。

  * 你可以点击 LeanCloud ，注册登录，进入控制台后点击创建应用。
  * 进入刚刚创建的应用，选择设置 》应用Keys，就能看到你的 APP ID 和 APP Key。

## 2. 修改config.toml

这里以[LoveIt](https://github.com/dillonzq/LoveIt)主题为例：

<!--more-->

```
 #  评论系统设置
    [params.page.comment]
      enable = true
      
# Valine 评论系统设置
      [params.page.comment.valine]
        enable = true
        appId = "你的appId"
        appKey = "你的appKey"
        placeholder = "在这里留下足迹吧!"
        avatar = "mp"
        meta= ['nick','mail']
        pageSize = 10
        lang = ""
        visitor = true
        recordIP = true
        highlight = true
        enableQQ = false
        serverURLs = ""
```

## 3. 配置邮件提醒功能

### 3.1. 基础设置

在 设置》安全中心》服务开关中，关闭除了数据存储外的所有功能，并在下方 web 安全域名中添加好你的域名。

### 3.2. 配置 Valine Admin

> Valine Admin 是 Valine  评论系统的扩展和增强，主要实现评论邮件通知、评论管理、垃圾评论过滤等功能。支持完全自定义的邮件通知模板。基于 Akismet API  实现准确的垃圾评论过滤。此外，使用云函数等技术解决了免费版云引擎休眠问题，支持云引擎自动唤醒，漏发邮件自动补发。兼容云淡风轻及 Deserts  维护的多版本 Valine。

#### 3.2.1. 云引擎” 一键” 部署

1.**在[ Leancloud](https://leancloud.cn/dashboard/#/apps)云引擎界面**，依次选择**`部署—部署项目—Git部署—配置Git`**，填写代码库并保存：

```
https://github.com/DesertsP/Valine-Admin.git
```

2.**在设置页面，设置环境变量以及 Web 二级域名**。

| SITE_NAME     | Bore's Notes                              | `[必填]` 博客名称                                            |
| ------------- | ----------------------------------------- | ------------------------------------------------------------ |
| SITE_URL      | `https://bore.vip/`                       | `[必填]` 首页地址                                            |
| SMTP_SERVICE  | QQ                                        | `[新版支持]` 邮件服务提供商，支持 QQ、163、126、Gmail 以及 更多 |
| SMTP_USER     | [xxxxxx@qq.com](mailto:xxxxxx@qq.com)     | `[必填]`SMTP 登录用户                                        |
| SMTP_PASS     | ccxxxxxxxxch                              | `[必填]`SMTP登录密码，一般为授权码，而不是邮箱的登陆密码     |
| SENDER_NAME   | bore                                      | `[必填]` 发件人                                              |
| SENDER_EMAIL  | [xxxxxx@qq.com](mailto:xxxxxx@qq.com)     | `[必填]` 发件邮箱                                            |
| ADMIN_URL     | `https://xxx.avosapps.us/`                | `[建议]`Web 主机二级域名，用于自动唤醒                       |
| BLOGGER_EMAIL | [xxxxx@gmail.com](mailto:xxxxx@gmail.com) | `[可选]` 博主通知收件地址，默认使用 SENDER_EMAIL             |
| AKISMET_KEY   | xxxxxxxxxxxx                              | `[可选]`Akismet Key 用于垃圾评论检测，设为 MANUAL_REVIEW 开启人工审核，留空不使用反垃圾 |

二级域名用于评论后台管理：例如 `https://xxx.avosapps.us/`，还可以绑定独立域名。

3.**切换到部署标签页**，分支使用 master，点击部署即可，第一次部署需要花点时间。

4.**评论管理**。访问设置的二级域名 `https://二级域名.avosapps.us/sign-up`，注册管理员登录信息。此后，可以通过 `https://tding.avosapps.us/` 管理评论。也可以这样注册管理员登录信息：

>设置后台管理登录信息，点击 存储 -> 结构化数据，选择_User -> 添加行，只需要填写password、username、email这三个字段即可, 使用 email 作为账号登陆、password 作为账号密码、username 任意即可。（为了安全考虑，此 email 必须为配置中的 SMTP_USER 或 TO_EMAIL， 否则不允许登录）

> 注：使用原版 Valine 如果遇到注册页面不显示直接跳转至登录页的情况，请手动删除_User 表中的全部数据。

此后，可以通过 `https://二级域名.leanapp.cn/` 管理评论。

5.**定时任务设置**

目前实现了两种云函数定时任务：

- (1) 自动唤醒，定时访问 Web APP 二级域名防止云引擎休眠；
- (2) 每天定时检查 24 小时内漏发的邮件通知。

进入云引擎 - 定时任务中，创建定时器，创建两个定时任务。

- 选择 `self-wake` 云函数，Cron 表达式为 `0 0/30 7-23 * * ?`，表示每天早 6 点到晚 23 点每隔 30 分钟访问云引擎，`ADMIN_URL` 环境变量务必设置正确
- 选择 `resend-mails` 云函数，Cron 表达式为 `0 0 8 * * ?`，表示每天早 8 点检查过去 24 小时内漏发的通知邮件并补发

添加定时器后记得点击启动方可生效。

至此，Valine Admin 已经可以正常工作，更多以下是可选的进阶配置。

#### 3.2.2. 邮件通知模板

邮件通知模板在**云引擎环境变量**中设定，可自定义通知邮件标题及内容模板。

| 环境变量              | 示例                                                     | 说明                              |
| --------------------- | -------------------------------------------------------- | --------------------------------- |
| `MAIL_SUBJECT`        | `${PARENT_NICK}`，您在 `${SITE_NAME}` 上的评论收到了回复 | `[可选]`@通知邮件主题（标题）模板 |
| `MAIL_TEMPLATE`       | 见下文                                                   | `[可选]`@通知邮件内容模板         |
| `MAIL_SUBJECT_ADMIN`  | `${SITE_NAME}` 上有新评论了                              | `[可选]` 博主邮件通知主题模板     |
| `MAIL_TEMPLATE_ADMIN` | 见下文                                                   | `[可选]` 博主邮件通知内容模板     |

邮件通知包含两种，分别是`被@通知`（上面的 `MAIL_TEMPLATE`）和`博主通知`（上面的 `MAIL_TEMPLATE_ADMIN`），这两种模板都可以完全自定义。默认使用经典的蓝色风格模板。

默认`被@通知`邮件内容模板如下：

```
<div style="border-top:2px solid #12ADDB;box-shadow:0 1px 3px #AAAAAA;line-height:180%;padding:0 15px 12px;margin:50px auto;font-size:12px;"><h2 style="border-bottom:1px solid #DDD;font-size:14px;font-weight:normal;padding:13px 0 10px 8px;">您在<a style="text-decoration:none;color: #12ADDB;" href="${SITE_URL}" target="_blank">            ${SITE_NAME}</a>上的评论有了新的回复</h2> ${PARENT_NICK} 同学，您曾发表评论：<div style="padding:0 12px 0 12px;margin-top:18px"><div style="background-color: #f5f5f5;padding: 10px 15px;margin:18px 0;word-wrap:break-word;">            ${PARENT_COMMENT}</div><p><strong>${NICK}</strong>回复说：</p><div style="background-color: #f5f5f5;padding: 10px 15px;margin:18px 0;word-wrap:break-word;"> ${COMMENT}</div><p>您可以点击<a style="text-decoration:none; color:#12addb" href="${POST_URL}" target="_blank">查看回复的完整內容</a>，欢迎再次光临<a style="text-decoration:none; color:#12addb" href="${SITE_URL}" target="_blank">${SITE_NAME}</a>。<br></p></div></div>
```

这里还提供一个彩虹风格的 `@通知`邮件模板代码：

```
<div style="border-radius: 10px 10px 10px 10px;font-size:13px;    color: #555555;width: 666px;font-family:'Century Gothic','Trebuchet MS','Hiragino Sans GB',微软雅黑,'Microsoft Yahei',Tahoma,Helvetica,Arial,'SimSun',sans-serif;margin:50px auto;border:1px solid #eee;max-width:100%;background: #ffffff repeating-linear-gradient(-45deg,#fff,#fff 1.125rem,transparent 1.125rem,transparent 2.25rem);box-shadow: 0 1px 5px rgba(0, 0, 0, 0.15);"><div style="width:100%;background:#49BDAD;color:#ffffff;border-radius: 10px 10px 0 0;background-image: -moz-linear-gradient(0deg, rgb(67, 198, 184), rgb(255, 209, 244));background-image: -webkit-linear-gradient(0deg, rgb(67, 198, 184), rgb(255, 209, 244));height: 66px;"><p style="font-size:15px;word-break:break-all;padding: 23px 32px;margin:0;background-color: hsla(0,0%,100%,.4);border-radius: 10px 10px 0 0;">您在<a style="text-decoration:none;color: #ffffff;" href="${SITE_URL}"> ${SITE_NAME}</a>上的留言有新回复啦！</p></div><div style="margin:40px auto;width:90%"><p>${PARENT_NICK} 同学，您曾在文章上发表评论：</p><div style="background: #fafafa repeating-linear-gradient(-45deg,#fff,#fff 1.125rem,transparent 1.125rem,transparent 2.25rem);box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);margin:20px 0px;padding:15px;border-radius:5px;font-size:14px;color:#555555;">${PARENT_COMMENT}</div><p>${NICK} 给您的回复如下：</p><div style="background: #fafafa repeating-linear-gradient(-45deg,#fff,#fff 1.125rem,transparent 1.125rem,transparent 2.25rem);box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);margin:20px 0px;padding:15px;border-radius:5px;font-size:14px;color:#555555;">${COMMENT}</div><p>您可以点击<a style="text-decoration:none; color:#12addb" href="${POST_URL}#comments">查看回复的完整內容</a>，欢迎再次光临<a style="text-decoration:none; color:#12addb"                href="${SITE_URL}"> ${SITE_NAME}</a>。</p><style type="text/css">a:link{text-decoration:none}a:visited{text-decoration:none}a:hover{text-decoration:none}a:active{text-decoration:none}</style></div></div>
```

默认博主通知邮件内容模板如下：

```
<div style="border-top:2px solid #12ADDB;box-shadow:0 1px 3px #AAAAAA;line-height:180%;padding:0 15px 12px;margin:50px auto;font-size:12px;"><h2 style="border-bottom:1px solid #DDD;font-size:14px;font-weight:normal;padding:13px 0 10px 8px;">您在<a style="text-decoration:none;color: #12ADDB;" href="${SITE_URL}" target="_blank">${SITE_NAME}</a>上的文章有了新的评论</h2><p><strong>${NICK}</strong>回复说：</p><div style="background-color: #f5f5f5;padding: 10px 15px;margin:18px 0;word-wrap:break-word;"> ${COMMENT}</div><p>您可以点击<a style="text-decoration:none; color:#12addb" href="${POST_URL}" target="_blank">查看回复的完整內容</a><br></p></div></div>
```

#### 3.2.3. 垃圾评论检测

如果还没有 Akismet Key，你可以去 [AKISMET FOR DEVELOPERS 免费申请一个](https://akismet.com/development/)；
**当 AKISMET_KEY 设为 MANUAL_REVIEW 时，开启人工审核模式；**
如果你不需要反垃圾评论，Akismet Key 环境变量可以忽略。

**为了实现较为精准的垃圾评论识别，采集的判据除了评论内容、邮件地址和网站地址外，还包括评论者的 IP 地址、浏览器信息等，但仅在云引擎后台使用这些数据，确保隐私和安全。**

**如果使用了本站最新的 Valine 和 Valine Admin，并设置了 Akismet Key，可以有效地拦截垃圾评论。被标为垃圾的评论可以在管理页面取消标注。**

| 环境变量    | 示例         | 说明                                |
| ----------- | ------------ | ----------------------------------- |
| AKISMET_KEY | xxxxxxxxxxxx | [可选] Akismet Key 用于垃圾评论检测 |

## 4. 参考链接

+ [1.Hexo-NexT 配置 Valine ](https://tding.top/archives/ed8b904f.html)

+ [2.Valine 评论系统配置邮件提醒功能](https://blog.juanertu.com/archives/cc0b1d61.html)

+ [3.Valine Admin 配置手册](https://deserts.io/valine-admin-document/)


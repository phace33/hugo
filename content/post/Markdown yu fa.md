---
title: "markdown基本语法"
date: 2020-05-16T08:47:17+08:00
draft: false
weight: false
categories: ["学习笔记"]
tags: [""]
---

 标题

```
# 这是一级标题
## 这是二级标题
### 这是三级标题
#### 这是四级标题
##### 这是五级标题
###### 这是六级标题

```

## 字体

<!-- more-->

### 加粗

要加粗的文字左右分别用两个*号包起来

### 斜体加粗

要倾斜和加粗的文字左右分别用三个*号包起来

### 删除线

要加删除线的文字左右分别用两个~~号包起来

### 引用

在引用的文字前加>即可。引用也可以嵌套，如加两个>>三个>>>
n个...

## 分割线

三个或者三个以上的 - 或者 * 都可以。

## 图片

`![](url)`

## 超链接

`[]()`

## 列表

### 无序列表

无序列表用 - + * 任何一种都可以

```java
- 列表内容
+ 列表内容
* 列表内容

注意：- + * 跟内容之间都要有一个空格
```

### 有序列表

数字加点

```python
1. 列表内容
2. 列表内容
3. 列表内容

注意：序号跟内容之间要有空格

```

### 列表嵌套

**上一级和下一级之间敲三个空格即可**

## 表格

```js
表头|表头|表头
---|:--:|---:
内容|内容|内容
内容|内容|内容

第二行分割表头和内容。
- 有一个就行，为了对齐，多加了几个
文字默认居左
-两边加：表示文字居中
-右边加：表示文字居右
注：原生的语法两边都要用 | 包起来。此处省略

```

## 代码

单行代码：代码之间分别用一个反引号包起来

代码块：代码之间分别用三个反引号包起来，且两边的反引号单独占一行

## 流程图

```markdown
​```flow
st=>start: 开始
op=>operation: My Operation
cond=>condition: Yes or No?
e=>end
st->op->cond
cond(yes)->e
cond(no)->op
&```

```

## 添加空格

在中文输入法的情况下：`shift＋空格键`切换至全角模式，之后再按空格键，那么空格键就会生效。

## 参考链接

[Markdown基本语法](https://www.jianshu.com/p/191d1e21f7ed)

推荐使用[Typora](https://typora.io/)编辑器
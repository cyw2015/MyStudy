# 概述
GitBook 是使用 GitHub / Git 和 Markdown（或AsciiDoc）构建漂亮书籍的命令行工具（和Node.js库）。  
GitBook 可以将您的内容作为网站（可定制和可扩展）或电子书（PDF，ePub或Mobi）输出。  
[Gitbook.com](https://app.gitbook.com/)是使用 GitBook 格式创建和托管图书的在线平台。它提供托管，协作功能和易于使用的编辑器。 

# GitBook在Mac上的安装
## 环境要求
需要提前安装好node,npm

## 通过npm安装
只需运行以下命令即可安装 GitBook
```shell
npm install gitbook-cli -g
```

gitbook-cli 是 GitBook 的一个命令行工具。它将自动安装所需版本的 GitBook 来构建一本书。  
执行下面的命令，查看 GitBook 版本，以验证安装成功。
```shell
gitbook -V
```

# 创建书籍
## 初始化
GitBook可以设置一个样板书：
```shell
gitbook init
```

## 构建
使用下面的命令，会在项目的目录下生成一个 _book 目录，里面的内容为静态站点的资源文件：
```shell
gitbook build
```

## 启动服务
使用下列命令会运行一个 web 服务, 通过 http://localhost:4000/ 可以预览书籍
```shell
gitbook serve
```

# 遇到的问题
我本地node版本是v15.12.0,npm版本是7.6.3，执行`gitbook -V`或`gitbook init` 遇到了两个问题
## 问题1：
```
xcode-select: error: tool 'xcodebuild' requires Xcode, but active developer directory 
'/Library/Developer/CommandLineTools' is a command line tools instance
```
这个问题是表明本地没有安装Xcode，可以在AppStore中，搜索Xcode安装。  
安装之后还是会出现这个异常，需要执行以下操作
1. 找到xcode-select的当前路径终端命令行
```shell
xcode-select --print-path
输出：/Library/Developer/CommandLineTools
```
2. 设置xcode-select到指定位置
```shell
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/ 
```
3. 验证是否设置成功
```shell
xcode-select --print-path
输出: /Applications/Xcode.app/Contents/Developer
```

## 问题2
详细错误如下:
```shell
/data/soft/nodejs/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js:287
      if (cb) cb.apply(this, arguments)

TypeError: cb.apply is not a function
    at /data/soft/nodejs/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js:287:18
    at FSReqCallback.oncomplete (fs.js:169:5)
```

打开polyfills.js文件，找到这个函数
```js
function statFix (orig) {
  if (!orig) return orig
  // Older versions of Node erroneously returned signed integers for
  // uid + gid.
  return function (target, cb) {
    return orig.call(fs, target, function (er, stats) {
      if (!stats) return cb.apply(this, arguments)
      if (stats.uid &lt; 0) stats.uid &#43;&#61; 0x100000000
      if (stats.gid &lt; 0) stats.gid &#43;&#61; 0x100000000
      if (cb) cb.apply(this, arguments)
    })
  }
```
在polyfills.js文件中有连续三次调用，大概在62-64行，将它们注释
```js
// fs.stat = statFix(fs.stat)
// fs.fstat = statFix(fs.fstat)
// fs.lstat = statFix(fs.lstat)
```
注释掉之后，重新执行初始化，成功创建项目。  
初始化完成后，在执行目录中生成README.md 和 SUMMARY.md 两个文件。


# 参考资料
* [使用 Gitbook 打造你的电子书-慕课网](https://zhuanlan.zhihu.com/p/34946169)  
* [iOS自动化构建 xcode-select: error-王家小雷](https://www.jianshu.com/p/e828afede8cc)  
* [Mac安装和使用GitBook-慎思知行](https://blog.csdn.net/bengofrank/article/details/120884189)  
* [安装gitbook的一些问题-笑道三千](https://blog.csdn.net/weixin_42349568/article/details/108414441)

# windowns 安装 node
## 下载
1. 官网下载 https://nodejs.org/zh-cn/download/ ，下载二进制文件.zip
2. 解压文件，比如解压到D:\node

## 配置环境变量
PATH增加配置 D:\node;D:\node\node_global

设置全局路径
```sh
npm config set cache "D:\node\node_cache"
npm config set prefix "D:\node\node_global"
```

或者更改.npmrc配置文件(D:\node\node_modules\npm)
```txt
prefix=D:\node\node_global
cache=D:\node\node_cache
```

## 验证
```
node -v
npm -v
```

# 修改国内镜像

```sh
npm config set registry https://registry.npm.taobao.org
```
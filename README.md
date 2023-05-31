# DeltaZX_Authenticator

使用Dart语言编写的一个两步验证器

## 安装

前往[Release](https://github.com/patryyyy/deltazx_authenticator/releases)

## 使用

### 添加账户

```
dau add <secret>
```

账户将会保存在`~/.dau/config.ini`

如果想保存在其它路径，请使用`--prefix`或`-p`选项指定保存路径

```
dau add <secret> -p <path>
```

### 生成验证码

```
dau gen
```

如果想使用保存在其他路径的账户，请使用`--prefix`或`-p`选项指定路径

```
dau gen -p <path>
```

如果想停止生成，使用 Ctrl + C 退出程序

### 删除账户

```
dau rm <account name>
```

如果想删除保存在其他路径的账户，请使用`--prefix`或`-p`选项指定路径

```
dau rm <account name> -p <path>
```

### 查看已添加的账户

```
dau list
```

同样的，如果想查看保存在其他路径的账户，请使用`--prefix`或`-p`选项指定路径

```
dau list -p <path>
```

### 查看版本

```
dau version
```

## 许可证

本项目自**e573dada8c350b1db4119b46c2a25244198c72f3**提交后，采用[**MIT**](https://github.com/patryyyy/deltazx_authenticator/blob/main/LICENSE)许可证

~~LGPL-3.0~~已不再使用


# DeltaZX_Authenticator

使用Dart语言编写的一个两步验证器，可以让你的账号更安全

生成验证码部分采用第三方包，有时间会替换成自己写的

## 安装

前往[Release](https://github.com/patryyyy/deltazx_authenticator/releases)页面

## 使用

生成验证码（需要添加账户）：

```
dau
```

添加账户：

```
dau add <Your Secret>
```

> 注意：密钥将会以加密形式保存在 ~/.deltazxapp/deltazx_authenticator/config.ini

删除账户：

```
dau rm <Your Account Name>
```

查看已添加的账户：

```
dau list
```

其他命令请查看帮助：
```
dau --help
```

## 许可证

本项目采用[**LGPL-3.0**](https://github.com/patryyyy/deltazx_authenticator/blob/main/LICENSE)


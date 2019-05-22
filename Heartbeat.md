# 2019-05-22
+  Tomcat 启动报错
   + 错误信息：`the session manager failed to start`
   + 解决办法：重启服务器，百度不到相关解决办法。

# 2019-05
## 五花八门的玩不转

+ IDEA Console `System.out.println(str);`
   + 错误信息：str为读取Word内容后的String类型，包含回车换行等，在打印时只显示最后一行内容。如果Debug str或把str传到页面显示，均显示str完整信息。
   + 解决办法：I don't know！


+ 不知道是IDEA还是JVM，`String str="中国"；System.out.println(str);`
   + 错误信息：编译后中文乱码,赋值和读值过程中无其他过程参与。
   + 解决办法：把中文换成英文，再replace；或者重启电脑，重新编译，如此循环操作n次；或者在乱码代码附近加其他辅助代码进行调试，也有可能解决。
   
   
+ 某一天突然发现一些文件内容被改
   + 错误信息：例如`upload` 变为 `uploadCheckRd`
   + 自己再改回去呗，还能怎么办




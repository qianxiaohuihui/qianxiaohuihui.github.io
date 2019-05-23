# 2019-05  五花八门的玩不转
+  Tomcat 启动报错
   + 错误信息：`the session manager failed to start`
   + 解决办法：重启服务器，百度不到相关解决办法。

+ IDEA Console `System.out.println(str);`
   + 错误信息：str为读取Word内容后的String类型，包含回车换行等，在打印时只显示最后一行内容。如果Debug str或把str传到页面显示，均显示str完整信息。
   + 解决办法：I don't know！


+ 不知道是IDEA还是JVM，`String str="中国"；System.out.println(str);`
   + 错误信息：编译后中文乱码,赋值和读值过程中无其他过程参与。
   + 解决办法：把中文换成英文，再replace；或者重启电脑，重新编译，如此循环操作n次；或者在乱码代码附近加其他辅助代码进行调试，也有可能解决。
   
   
+ 某一天突然发现一些文件内容被改
   + 错误信息：例如`upload` 变为 `uploadCheckRd`
   + 自己再改回去呗，还能怎么办


```java
   /**
   ***  把password中的汉字过滤掉
   **/
   String regEx = "[a-zA-Z0-9]";
   Pattern p = Pattern.compile(regEx);
   Matcher m = p.matcher(password);
   StringBuffer tmp = new StringBuffer();
   while (m.find()) {
       tmp.append(m.group());
   }
    password=tmp.toString();
```

+ C#与Java同步加密解密DES算法
   + 参考：https://blog.csdn.net/softwave/article/details/53939824
   + Java 示例代码：
   
```java
   import javax.crypto.Cipher;
   import javax.crypto.SecretKey;
   import javax.crypto.SecretKeyFactory;
   import javax.crypto.spec.DESKeySpec;
   import javax.crypto.spec.IvParameterSpec;

   public class MyDes {
       private static String IV = "82EC1A80";

       /**
        * DES解密
        */
       public static String DecodeDES(String message, String key) throws Exception {
           byte[] bytesrc = convertHexString(message);
           Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
           DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
           SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
           SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
           IvParameterSpec iv = new IvParameterSpec(IV.getBytes("UTF-8"));
           cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
           byte[] retByte = cipher.doFinal(bytesrc);
           return new String(retByte);
       }

       /**
        * DES加密
        */
       public static byte[] EncodeDES(String message, String key) throws Exception {
           Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
           DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
           SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
           SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
           IvParameterSpec iv = new IvParameterSpec(IV.getBytes("UTF-8"));
           cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
           return cipher.doFinal(message.getBytes("UTF-8"));
       }

       public static byte[] convertHexString(String ss) {
           byte digest[] = new byte[ss.length() / 2];
           for (int i = 0; i < digest.length; i++) {
               String byteString = ss.substring(2 * i, 2 * i + 2);
               int byteValue = Integer.parseInt(byteString, 16);
               digest[i] = (byte) byteValue;
           }
           return digest;
       }

       public static String toHexString(byte b[]) {
           StringBuffer hexString = new StringBuffer();
           for (int i = 0; i < b.length; i++) {
               String plainText = Integer.toHexString(0xff & b[i]);
               if (plainText.length() < 2)
                   plainText = "0" + plainText;
               hexString.append(plainText);
           }
           return hexString.toString();
       }
       
      @org.junit.Test
      public void test() {
           try{
               String msg = "测试abc123";
               String key = "82EC1A80";
               System.out.println("msg：" + msg);
               System.out.println("key：" + key);
               System.out.println("加密后内容："+MyDes.toHexString(MyDes.EncodeDES(msg,key)));
           }catch (Exception e){
               e.getMessage();
           }
       }

   }

```

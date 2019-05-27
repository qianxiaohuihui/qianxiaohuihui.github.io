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
   + 错误信息：例如`upload` 变为 `uploadCheckRd`，20190-5-27遇到又.java和.js文件中的`index`变为`indexSop`
   + 自己再改回去呗，还能怎么办，Revert


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

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;
import java.security.Key;
import java.security.spec.AlgorithmParameterSpec;

public class MyDes {
    private Key key;                                // 密钥的key值
    private String DESkey="EB9925W6";
    private byte[] DESIV = {(byte)0xAC, 0x12,(byte)0xEF, 0x1D, 0x56, 0x78, (byte)0x9C, (byte)0xAB};
    private AlgorithmParameterSpec iv = null;       // 加密算法的参数接口

    public MyDes() {
        try {
            DESKeySpec keySpec = new DESKeySpec(DESkey.getBytes());         // 设置密钥参数
            iv = new IvParameterSpec(DESIV);                                // 设置向量
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");// 获得密钥工厂
            key = keyFactory.generateSecret(keySpec);                       // 得到密钥对象
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 加密String 明文输入密文输出
     *
     * @param inputString 待加密的明文
     * @return 加密后的字符串
     */
    public String getEnc(String inputString) {
        byte[] byteMi = null;
        byte[] byteMing = null;
        String outputString = "";
        try {
            byteMing = inputString.getBytes("UTF-8");
            byteMi = this.getEncCode(byteMing);
            BASE64Encoder encoder = new BASE64Encoder();
            String temp = encoder.encode(byteMi);
            outputString = new String(temp);
        } catch (Exception e) {
        } finally {
            byteMing = null;
            byteMi = null;
        }
        return outputString;
    }


    /**
     * 解密String 以密文输入明文输出
     *
     * @param inputString 需要解密的字符串
     * @return 解密后的字符串
     */
    public String getDec(String inputString) {
        byte[] byteMing = null;
        byte[] byteMi = null;
        String strMing = "";
        try {
            BASE64Decoder decoder = new BASE64Decoder();
            byteMi = decoder.decodeBuffer(inputString);
            byteMing = this.getDesCode(byteMi);
            strMing = new String(byteMing, "UTF-8");
        } catch (Exception e) {
        } finally {
            byteMing = null;
            byteMi = null;
        }
        return strMing;
    }

    /**
     * 加密以byte[]明文输入,byte[]密文输出
     *
     * @param bt 待加密的字节码
     * @return 加密后的字节码
     */
    private byte[] getEncCode(byte[] bt) {
        byte[] byteFina = null;
        Cipher cipher;
        try {
            // 得到Cipher实例
            cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, key, iv);
            byteFina = cipher.doFinal(bt);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cipher = null;
        }
        return byteFina;
    }

    /**
     * 解密以byte[]密文输入,以byte[]明文输出
     *
     * @param bt 待解密的字节码
     * @return 解密后的字节码
     */
    private byte[] getDesCode(byte[] bt) {
        Cipher cipher;
        byte[] byteFina = null;
        try {
            // 得到Cipher实例
            cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, key, iv);
            byteFina = cipher.doFinal(bt);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cipher = null;
        }
        return byteFina;
    }

    public static void main(String[] args) {
        MyDes u = new MyDes();
        String aa="Tomorrow will be better.";
        String mi = u.getEnc(aa);
        System.out.println("加密后：\n"+mi);
    }
}

```

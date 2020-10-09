import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.junit.Test;

public class TestMD5 {
    @Test
    public void testMd5(){
        String md5Pass = new Md5Hash("123").toString();//对123进行MD5加密
        System.out.println("未加盐:"+md5Pass);
        String md5Pass1 = new Md5Hash("123","yunhe",1).toString();//对123加盐salt进行MD5加密
        System.out.println("加盐迭代1次:"+md5Pass1);
        String md5Pass3 = new Md5Hash("123","yunhe",3).toString();//对123加盐salt进行MD5加密
        System.out.println("加盐迭代3次:"+md5Pass3);
        String md5Pass4 = new SimpleHash("MD5","123","yunhe",1).toString();
        System.out.println(md5Pass4);
    }
}

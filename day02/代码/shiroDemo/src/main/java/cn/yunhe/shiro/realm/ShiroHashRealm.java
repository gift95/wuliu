package cn.yunhe.shiro.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ShiroHashRealm extends AuthorizingRealm {

    /**
     * 认证的方法
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //1.从token中获取身份信息
        String principal = authenticationToken.getPrincipal().toString();//身份信息
        //2.根据身份信息从数据库中查找凭证信息和盐
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "111");
            String sql="select * from userinfo where userName=?";
            PreparedStatement psmt = connection.prepareStatement(sql);
            psmt.setString(1,principal);
            ResultSet rs = psmt.executeQuery();
            String userPass = null;
            String salt = null;
            while(rs.next()){
                userPass = rs.getString("userPass"); //获取密码
                salt = rs.getString("salt"); //获取盐
            }
            SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(principal,userPass, ByteSource.Util.bytes(salt),this.getName());
            return simpleAuthenticationInfo;
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return null;
    }

    /**
     * 授权的方法
     * @param principalCollection
     * @return
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }
}

package cn.yunhe.shiro.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * 自定义Realm:从数据库中获取数据
 */
public class ShiroJdbcRealm  extends AuthorizingRealm {
    /***
     * 认证
     * @param authenticationToken:封装用户的身份信息(用户名)和凭证信息(密码)
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //1.从token中获取身份信息
        String userName = (String)authenticationToken.getPrincipal();//身份信息(用户输入)
        //String password = (String)authenticationToken.getCredentials();//凭证信息(用户输入)
        //2.根据身份信息(用户名)连接数据库查询该用户的凭证信息(数据库中的信息)
       try {
           Class.forName("com.mysql.jdbc.Driver");
           Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "111");
           String sql="select * from userinfo where userName=?";
           PreparedStatement psmt = connection.prepareStatement(sql);
           psmt.setString(1,userName);
           ResultSet rs = psmt.executeQuery();
           String userPass = null;
           while(rs.next()){
               userPass = rs.getString("userPass");
           }
           SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(userName,userPass,this.getName());
           return simpleAuthenticationInfo;
       }catch (Exception ex){
           ex.printStackTrace();
       }
        return null;
    }

    /**
     * 授权
     * @param principalCollection
     * @return
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }
}

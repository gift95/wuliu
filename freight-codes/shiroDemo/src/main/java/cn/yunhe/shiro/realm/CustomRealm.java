package cn.yunhe.shiro.realm;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashSet;
import java.util.Set;

public class CustomRealm extends AuthorizingRealm {
    /**
     * 认证
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        //从token中获取身份信息
        String account = authenticationToken.getPrincipal().toString();
        String[] strs = getPasswordAndSaltByAccount(account);//根据用户名查询数据库获取密码和盐
        if(strs!=null&&strs.length>0){
            SimpleAuthenticationInfo  simpleAuthenticationInfo = new SimpleAuthenticationInfo(account,strs[0], ByteSource.Util.bytes(strs[1]),this.getName());
            return simpleAuthenticationInfo;
        }
        return null;
    }

    /**
     * 授权
     * @param principalCollection
     * @return
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String account = principalCollection.getPrimaryPrincipal().toString();//获取主身份信息
        //根据身份信息查询拥有的角色
        Set<String> roles = getRoleNamesByAccount(account);
        //根据身份信息查询拥有的权限
        Set<String> permissions = getPermissionsByAccount(account);
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        simpleAuthorizationInfo.setRoles(roles);//将拥有的角色添加到SimpleAuthorizationInfo
        simpleAuthorizationInfo.setStringPermissions(permissions);//将拥有的权限添加到SimpleAuthorizationInfo
        return simpleAuthorizationInfo;
    }

    /**
     * 根据账号名称获取密码和盐--->认证
     * @param account
     * @return
     */
    private String[] getPasswordAndSaltByAccount(String account){
        String[] strs = new String[2];
        String sql="select password,salt from  sys_user where account = ? ";
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shiro","root","111");
            PreparedStatement psmt = conn.prepareStatement(sql);
            psmt.setString(1,account);
            ResultSet rs = psmt.executeQuery();
            while(rs.next()){
                strs[0] = rs.getString("password");
                strs[1] = rs.getString("salt");
            }
            rs.close();
            psmt.close();
            conn.close();
        }catch (Exception ex) {
            ex.printStackTrace();
        }
        return strs;
    }

    /**
     * 根据账号名称查询所拥有的角色
     * @param account
     * @return
     */
    private Set<String>  getRoleNamesByAccount(String account){
        Set<String> roles = new HashSet<String>();
        String sql="select role_name from sys_user,sys_user_role,sys_role where sys_user.user_id=sys_user_role.user_id " +
                "and sys_user_role.role_id=sys_role.role_id and sys_user.account=?";
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shiro","root","111");
            PreparedStatement psmt = conn.prepareStatement(sql);
            psmt.setString(1,account);
            ResultSet rs = psmt.executeQuery();
            while(rs.next()){
                roles.add(rs.getString("role_name"));
            }
            rs.close();
            psmt.close();
            conn.close();
        }catch (Exception ex) {
            ex.printStackTrace();
        }
        return roles;
    }

    /**
     * 根据账号名称查询所拥有的权限
     * @param account
     * @return
     */
    private Set<String>  getPermissionsByAccount(String account){
        Set<String> permissions = new HashSet<String>();
        String sql="select resource_permission from sys_user,sys_user_role,sys_role,sys_role_resource,sys_resource " +
                "where sys_user.user_id=sys_user_role.user_id and sys_user_role.role_id=sys_role.role_id \n" +
                "and sys_role.role_id=sys_role_resource.role_id and sys_role_resource.resource_id=sys_resource.resource_id " +
                "and sys_user.account=?";
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/shiro","root","111");
            PreparedStatement psmt = conn.prepareStatement(sql);
            psmt.setString(1,account);
            ResultSet rs = psmt.executeQuery();
            while(rs.next()){
                permissions.add(rs.getString("resource_permission"));
            }
            rs.close();
            psmt.close();
            conn.close();
        }catch (Exception ex) {
            ex.printStackTrace();
        }
        return permissions;
    }



}

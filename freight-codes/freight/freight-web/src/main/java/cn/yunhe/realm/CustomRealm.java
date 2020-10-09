package cn.yunhe.realm;
import cn.yunhe.pojo.CurrentUser;
import cn.yunhe.pojo.ModuleP;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import cn.yunhe.pojo.UserP;
import cn.yunhe.service.UserPService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;


public class CustomRealm extends AuthorizingRealm {

    @Autowired
    private UserPService userPService;
    /**
     * 认证
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String username = authenticationToken.getPrincipal().toString();//获取身份信息
        UserP userP = userPService.login(username);//根据用户名查找用户信息
        if(userP==null){
            return null;
        }
        //根据用户信息查询用户扩展信息和部门信息
        CurrentUser currentUser = userPService.findUserInfoDeptByUser(userP);
        String password = userP.getPassword();//获取密码
        String salt = userP.getUserName()+userP.getUserId();//根据用户名和编号作为盐值
        //SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(username,password, ByteSource.Util.bytes(salt),this.getName());

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(currentUser,password, ByteSource.Util.bytes(salt),this.getName());

        return info;
    }

    /**
     * 授权
     * @param principalCollection
     * @return
     */
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //获取主身份信息
        CurrentUser currentUser = (CurrentUser)principalCollection.getPrimaryPrincipal();
        //从CurrentUser中获取用户信息
        UserP userP = currentUser.getUserP();
        //根据用户编号查询该用户拥有的权限信息
        List<ModuleP> list = userPService.getPermissionsByUserId(userP.getUserId());
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        for(ModuleP moduleP:list){
            info.addStringPermission(moduleP.getCpermission());
        }
        return info;
    }

    //清空缓存:在权限修改后调用realm中的方法，realm已经由spring管理，所以从spring中获取realm实例，调用clearCached方法。
    public void clearCached() {
        //获取身份信息
        PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
        //调用父类中清空缓存的方法
        super.clearCache(principals);
    }

}

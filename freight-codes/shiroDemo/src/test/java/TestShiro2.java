import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.Factory;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class TestShiro2 {
    /**
     * 测试授权(需要对用户先执行认证,然后才能判断是否拥有权限)
     * 读取ini中的信息(用户,角色,权限)
     */
    @Test
    public void test01(){
        //1. 构建SecurityManager工厂，IniSecurityManagerFactory可以从ini文件中初始化SecurityManager环境
        Factory <SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro-permission.ini");
        //2. 通过工厂创建SecurityManager
        SecurityManager securityManager = factory.getInstance();
        //3. 使用SecurityUtils将securityManager设置到运行环境中
        SecurityUtils.setSecurityManager(securityManager);
        //4. 使用SecurityUtils创建一个Subject实例，该实例认证要使用上边创建的securityManager进行
        Subject subject = SecurityUtils.getSubject();
        //5. 创建token令牌，记录用户认证的身份和凭证即账号和密码
        UsernamePasswordToken token = new UsernamePasswordToken("zhangsan","123456");
        //6. 用户登录
        subject.login(token);
        //7. 查看认证状态
        boolean isAuthenticated = subject.isAuthenticated();
        System.out.println("认证状态:"+isAuthenticated);
       //判断是否拥有角色
        boolean hasRole1 = subject.hasRole("role1");
        System.out.println("是否拥有指定的一个角色:"+hasRole1);
        List<String> roles = new ArrayList<String>();
        roles.add("role1");
        roles.add("role2");
        boolean hasAllRoles =subject.hasAllRoles(roles);
        System.out.println("是否拥有指定的多个角色:"+hasAllRoles);
        //subject.checkRole("role3"); //无返回值,如果没有指定的角色将抛出异常
        //subject.checkRoles(roles);
        boolean isPerimitted = subject.isPermitted("user:query");//判断是否拥有指定的权限
        System.out.println("是否拥有指定的权限:"+isPerimitted);
        boolean isPerimitted2 = subject.isPermittedAll("user:create","user:update");//判断是否拥有指定的权限
        System.out.println("是否拥有指定的所有权限:"+isPerimitted2);
        subject.checkPermission("user:create");//检查是否拥有指定的权限,如果没有指定的角色将抛出异常
        subject.checkPermissions("user:create","user:update");//检查是否拥有指定的权限,如果没有指定的角色将抛出异常


    }

    /**
     * 测试授权(需要对用户先执行认证,然后才能判断是否拥有权限)
     * 读取数据库中的信息(用户,角色,权限)
     */
    @Test
    public void test02(){
        //1. 构建SecurityManager工厂，IniSecurityManagerFactory可以从ini文件中初始化SecurityManager环境
        Factory <SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro-custom.ini");
        //2. 通过工厂创建SecurityManager
        SecurityManager securityManager = factory.getInstance();
        //3. 使用SecurityUtils将securityManager设置到运行环境中
        SecurityUtils.setSecurityManager(securityManager);
        //4. 使用SecurityUtils创建一个Subject实例，该实例认证要使用上边创建的securityManager进行
        Subject subject = SecurityUtils.getSubject();
        //5. 创建token令牌，记录用户认证的身份和凭证即账号和密码
        UsernamePasswordToken token = new UsernamePasswordToken("zhangsan","123");
        //6. 用户登录
        subject.login(token);
        //7. 查看认证状态
        boolean isAuthenticated = subject.isAuthenticated();
        System.out.println("认证状态:"+isAuthenticated);
        //判断是否拥有角色
        boolean hasRole1 = subject.hasRole("普通用户");
        System.out.println("是否拥有指定的一个角色:"+hasRole1);
        //subject.checkRole("role3"); //无返回值,如果没有指定的角色将抛出异常
        //subject.checkRoles(roles);
        boolean isPerimitted = subject.isPermitted("user:create");//判断是否拥有指定的权限
        System.out.println("是否拥有指定的权限:"+isPerimitted);
        boolean isPerimitted2 = subject.isPermittedAll("user:create","user:edit");//判断是否拥有指定的权限
        System.out.println("是否拥有指定的所有权限:"+isPerimitted2);
        subject.checkPermission("user:create");//检查是否拥有指定的权限,如果没有指定的角色将抛出异常
        subject.checkPermissions("user:create","user:update");//检查是否拥有指定的权限,如果没有指定的角色将抛出异常


    }


}

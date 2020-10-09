import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.config.IniSecurityManagerFactory;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.Factory;
import org.junit.Test;

public class TestShiro {
    /**
     * 测试认证
     */
    @Test
    public void test01(){
        //1. 构建SecurityManager工厂，IniSecurityManagerFactory可以从ini文件中初始化SecurityManager环境
        Factory <SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro.ini");
        //2. 通过工厂创建SecurityManager
        SecurityManager securityManager = factory.getInstance();
        //3. 使用SecurityUtils将securityManager设置到运行环境中
        SecurityUtils.setSecurityManager(securityManager);
        //4. 使用SecurityUtils创建一个Subject实例，该实例认证要使用上边创建的securityManager进行
        Subject subject = SecurityUtils.getSubject();
        //5. 创建token令牌，记录用户认证的身份和凭证即账号和密码
        UsernamePasswordToken token = new UsernamePasswordToken("zhangsan","1234");
        //6. 用户登录
        subject.login(token);
        //7. 查看认证状态
        boolean isAuthenticated = subject.isAuthenticated();
        System.out.println("认证状态:"+isAuthenticated);
        //8. 退出登录
        subject.logout();
        isAuthenticated = subject.isAuthenticated();
        System.out.println("认证状态:"+isAuthenticated);

    }

    /**
     * 测试认证(自定义realm):通过自定义realm从数据库中读取数据
     */
    @Test
    public void test02(){
        //1. 构建SecurityManager工厂，IniSecurityManagerFactory可以从ini文件中初始化SecurityManager环境
        Factory <SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro-realm.ini");
        //2. 通过工厂创建SecurityManager
        SecurityManager securityManager = factory.getInstance();
        //3. 使用SecurityUtils将securityManager设置到运行环境中
        SecurityUtils.setSecurityManager(securityManager);
        //4. 使用SecurityUtils创建一个Subject实例，该实例认证要使用上边创建的securityManager进行
        Subject subject = SecurityUtils.getSubject();
        //5. 创建token令牌，记录用户认证的身份和凭证即账号和密码
        UsernamePasswordToken token = new UsernamePasswordToken("lisi","12345");
        //6. 用户登录
        subject.login(token);
        //7. 查看认证状态
        boolean isAuthenticated = subject.isAuthenticated();
        System.out.println("认证状态:"+isAuthenticated);
        //8. 退出登录
        subject.logout();
        isAuthenticated = subject.isAuthenticated();
        System.out.println("认证状态:"+isAuthenticated);

    }

    /**
     * 测试认证(自定义realm): 添加凭证匹配器
     */
    @Test
    public void test03(){
        //1. 构建SecurityManager工厂，IniSecurityManagerFactory可以从ini文件中初始化SecurityManager环境
        Factory <SecurityManager> factory = new IniSecurityManagerFactory("classpath:shiro-hash.ini");
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
        //8. 退出登录
        subject.logout();
        isAuthenticated = subject.isAuthenticated();
        System.out.println("认证状态:"+isAuthenticated);

    }
}

package cn.yunhe.controller;

import cn.yunhe.pojo.UserP;
import cn.yunhe.service.UserPService;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserPController {
    @Autowired
    private UserPService userService;

    /**
     * 认证：注意认证成功不调用该方法
     * @return
     */
    @RequestMapping("/login")
    public String login(HttpServletRequest request){
        //1.从request范围中获取错误信息: shiroLoginFailure
        String shiroLoginFailure = (String)request.getAttribute("shiroLoginFailure");
        System.out.println(shiroLoginFailure+"----->");
        //2.判断错误消息的类型
        if(UnknownAccountException.class.getName().equals(shiroLoginFailure)){
            request.setAttribute("errorInfo","账号不正确!");
        }else if(IncorrectCredentialsException.class.getName().equals(shiroLoginFailure)){
            request.setAttribute("errorInfo","密码不正确!");
        }
        return "/index";
    }
}

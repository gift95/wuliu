package cn.yunhe.controller;

import cn.yunhe.pojo.CurrentUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {
    //欢迎页
    @RequestMapping("/")
    public String index(){
        return "index";
    }

    //登录
    @RequestMapping("/index")
    public String showLogin(){
        return "index";
    }

    //跳转主页
    @RequestMapping("/main")
    public String main(){
        return "home/fmain";
    }

    //跳转title.jsp页面
    @RequestMapping("/homeAction_title")
    public String homeAction_title(Model model){
        //获取Subject主题
        Subject subject =SecurityUtils.getSubject();
        //获取身份信息
        CurrentUser currentUser = (CurrentUser)subject.getPrincipal();
        model.addAttribute("currentUser",currentUser);//保存身份信息(用户信息，用户扩展信息， 部门信息)
        return "home/title"; // /WEB-INF/pages/home/title.jsp
    }

    //跳转左侧菜单
    @RequestMapping("homeAction_toleft")
    public String homeAction_left(String moduleName, Model model){
        model.addAttribute("moduleName", moduleName);
        return moduleName + "/left";
    }

    //跳转主窗口
    @RequestMapping("homeAction_tomain")
    public String homeAction_main(String moduleName, Model model){
        model.addAttribute("moduleName", moduleName);
        return moduleName + "/main";
    }


}

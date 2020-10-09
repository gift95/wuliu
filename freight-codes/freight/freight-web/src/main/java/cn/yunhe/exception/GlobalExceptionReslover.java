package cn.yunhe.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GlobalExceptionReslover implements HandlerExceptionResolver {
    private Logger logger = LoggerFactory.getLogger(GlobalExceptionReslover.class);

    /**
     * 异常处理的方法
     */
    public ModelAndView resolveException(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) {
        //1.写入日志
        logger.error("系统发生异常",e);
        //2.发送邮件或短信通知开发者
        //3. 定制错误消息,并跳转错误页面
        ModelAndView mv = new ModelAndView();
        mv.addObject("message","系统发生异常,请联系管理员");
        mv.addObject("stack",e);
        mv.setViewName("error");
        return mv;
    }
}

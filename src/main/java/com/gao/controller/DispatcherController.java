package com.gao.controller;

import com.gao.bean.User;
import com.gao.service.UserService;
import com.gao.util.AjaxResult;
import com.gao.util.Const;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class DispatcherController {

    @RequestMapping("/index")
    public String index(){
        return "login";
    }

    @Autowired
    UserService userService;

    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(String loginacct, String userpswd, String type, HttpSession session){
        AjaxResult result=new AjaxResult();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("loginacct", loginacct);
            map.put("userpswd", userpswd);
            map.put("type", type);

            User user = userService.queryUserlogin(map);

            session.setAttribute(Const.LOGIN_USER, user);
            result.setSuccess(true);
        }catch (Exception e){
            result.setMessage("登录失败！");
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/main")
    public String main(){
        return "main";
    }
}

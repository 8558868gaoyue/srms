package com.gao.controller;

import com.gao.service.UserService;
import com.gao.util.AjaxResult;
import com.gao.util.Page;
import com.gao.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("/toIndex")
    public String toIndex(){
        return "user/index";
    }

    @ResponseBody
    @RequestMapping("/doIndex")
    public Object index(@RequestParam(value = "pageno",required = false,defaultValue = "1") Integer pageno,
                        @RequestParam(value = "pagesize",required = false,defaultValue = "2") Integer pagesize,
                        String queryText){
        AjaxResult result=new AjaxResult();
        try{
            Map paramMap=new HashMap();
            paramMap.put("pageno",pageno);
            paramMap.put("pagesize",pagesize);

            if(StringUtil.isNotEmpty(queryText)){
                paramMap.put("queryText",queryText);
            }
            Page page=userService.queryPage(paramMap);
            result.setSuccess(true);
            result.setPage(page);
        }catch(Exception e){
            result.setSuccess(false);
            e.printStackTrace();
            result.setMessage("查询失败");
        }
        return result;
    }

    @RequestMapping("/toAdd")
    public String toAdd(){
        return "user/add";
    }
}

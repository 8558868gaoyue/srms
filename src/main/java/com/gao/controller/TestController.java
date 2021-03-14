package com.gao.controller;

import com.gao.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {

    @Autowired
    private TestService testService;

    @RequestMapping("/test.do")
    public String test(){
        testService.insert();
        return "success";
    }
}

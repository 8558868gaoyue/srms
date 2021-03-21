package com.gao.controller;

import com.gao.bean.Role;
import com.gao.bean.User;
import com.gao.service.UserService;
import com.gao.util.AjaxResult;
import com.gao.util.Data;
import com.gao.util.Page;
import com.gao.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

    @ResponseBody
    @RequestMapping("/doAdd")
    public Object doAdd(User user){
        AjaxResult result=new AjaxResult();
        try{
            int count=userService.saveUser(user);
            result.setSuccess(count==1);
        }catch(Exception e){
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public AjaxResult delete(int id){
        AjaxResult result=new AjaxResult();
        try{
            userService.deleteUserById(id);
            result.setSuccess(true);
        }catch(Exception e){
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/toUpdate")
    public String toUpdate(int id,Map map){
        User user=userService.getUserById(id);
        map.put("user",user);
        return "user/update";
    }

    @ResponseBody
    @RequestMapping("/update")
    public Object update(User user){
        AjaxResult result=new AjaxResult();
        try{
            int count=userService.updateUser(user);
            result.setSuccess(count==1);
        }catch(Exception e){
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/toAssignrole")
    public String toAssignrole(Integer id,Map map){
        List<Integer> userRole=userService.queryRoleByUserId(id);
        List<Role> allRoles=userService.queryAllRole();

        List<Role> leftList=new ArrayList<Role>();//未分配角色
        List<Role> rightList=new ArrayList<Role>();//已分配角色
        for (Role role:allRoles) {
            if(userRole.contains(role.getId())){
                rightList.add(role);
            }else {
                leftList.add(role);
            }
        }
        map.put("leftList",leftList);
        map.put("rightList",rightList);
        return "user/assignrole";
    }

    //分配角色
    @ResponseBody
    @RequestMapping("/doAssignRole")
    public Object doAssignRole(Integer userid, Data data){
        AjaxResult result=new AjaxResult();
        try{
            int count=userService.saveUserRole(userid,data);
            result.setSuccess(count==data.getIds().size());
        }catch(Exception e){
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }

    //取消分配角色
    @ResponseBody
    @RequestMapping("/doUnAssignRole")
    public Object doUnAssignRole(Integer userid, Data data){
        AjaxResult result=new AjaxResult();
        try{
            int count=userService.deleteUserRole(userid,data);
            result.setSuccess(count==data.getIds().size());
        }catch(Exception e){
            result.setSuccess(false);
            e.printStackTrace();
        }
        return result;
    }
}

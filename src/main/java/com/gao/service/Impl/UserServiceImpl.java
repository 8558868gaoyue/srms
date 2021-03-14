package com.gao.service.Impl;

import com.gao.bean.User;
import com.gao.dao.UserMapper;
import com.gao.service.UserService;
import com.gao.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    UserMapper userMapper;

    public User queryUserlogin(Map<String, Object> map) {
        return userMapper.queryUserlogin(map);
    }

    public Page queryPage(Map paramMap) {
        Integer pageno=(Integer) paramMap.get("pageno");
        Integer pagesize=(Integer) paramMap.get("pagesize");

        Page page=new Page(pageno,pagesize);

        List<User> userList=userMapper.queryPage(page.getStartIndex(),pagesize);
        page.setDatas(userList);

        int count=userMapper.queryTotalSize();
        page.setTotalsize(count);

        return page;
    }
}

package com.gao.service.Impl;

import com.gao.bean.User;
import com.gao.dao.UserMapper;
import com.gao.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    UserMapper userMapper;

    public User queryUserlogin(Map<String, Object> map) {
        return userMapper.queryUserlogin(map);
    }
}

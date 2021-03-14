package com.gao.dao;

import com.gao.bean.User;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    User selectByPrimaryKey(Integer id);

    List<User> selectAll();

    int updateByPrimaryKey(User record);

    User queryUserlogin(Map<String,Object> map);

}
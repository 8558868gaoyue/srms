package com.gao.service.Impl;

import com.gao.bean.Role;
import com.gao.bean.User;
import com.gao.dao.UserMapper;
import com.gao.service.UserService;
import com.gao.util.Const;
import com.gao.util.Data;
import com.gao.util.MD5Util;
import com.gao.util.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
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

    public int saveUser(User user) {
        user.setPassword(MD5Util.digest(Const.pwd));
        return userMapper.insert(user);
    }

    public void deleteUserById(int id) {
        userMapper.deleteByPrimaryKey(id);
    }

    public User getUserById(int id) {
        return userMapper.selectByPrimaryKey(id);
    }

    public int updateUser(User user) {
        return userMapper.updateByPrimaryKey(user);
    }

    public List<Integer> queryRoleByUserId(Integer id) {
        return userMapper.queryRoleByUserId(id);
    }

    public List<Role> queryAllRole() {
        return userMapper.queryAllRole();
    }

    public int deleteUserRole(Integer userid, Data data) {
        return userMapper.deleteUserRole(userid,data);
    }

    public int saveUserRole(Integer userid, Data data) {
        return userMapper.saveUserRole(userid,data);
    }
}

package com.gao.service;

import com.gao.bean.Role;
import com.gao.bean.User;
import com.gao.util.Data;
import com.gao.util.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

public interface UserService {
    User queryUserlogin(Map<String, Object> map);

    Page queryPage(Map paramMap);

    int saveUser(User user);

    void deleteUserById(int id);

    int updateUser(User user);

    User getUserById(int id);

    List<Integer> queryRoleByUserId(Integer id);

    List<Role> queryAllRole();

    int deleteUserRole(Integer userid, Data data);

    int saveUserRole(Integer userid, Data data);
}

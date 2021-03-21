package com.gao.dao;

import com.gao.bean.Role;
import com.gao.bean.User;
import com.gao.util.Data;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    User selectByPrimaryKey(Integer id);

    List<User> selectAll();

    int updateByPrimaryKey(User record);

    User queryUserlogin(Map<String,Object> map);

    List<User> queryPage(@Param("startIndex") Integer startIndex,@Param("pagesize") Integer pagesize);

    int queryTotalSize();

    List<Integer> queryRoleByUserId(Integer id);

    List<Role> queryAllRole();

    int deleteUserRole(@Param("userid") Integer userid,@Param("data") Data data);

    int saveUserRole(@Param("userid") Integer userid,@Param("data") Data data);
}
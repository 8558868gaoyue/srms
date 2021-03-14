package com.gao.service;

import com.gao.bean.User;
import com.gao.util.Page;
import org.springframework.stereotype.Service;

import java.util.Map;

public interface UserService {
    User queryUserlogin(Map<String, Object> map);

    Page queryPage(Map paramMap);
}

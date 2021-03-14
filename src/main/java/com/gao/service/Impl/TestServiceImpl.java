package com.gao.service.Impl;

import com.gao.dao.TestDao;
import com.gao.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class TestServiceImpl implements TestService {
    @Autowired
    private TestDao testDao;

    public void insert() {
        Map map=new HashMap();
        map.put("name","gao");
        testDao.insert(map);
    }
}

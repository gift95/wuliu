package cn.yunhe.service.impl;

import cn.yunhe.mapper.DeptPMapper;
import cn.yunhe.mapper.ModulePMapper;
import cn.yunhe.mapper.UserInfoPMapper;
import cn.yunhe.mapper.UserPMapper;
import cn.yunhe.pojo.*;
import cn.yunhe.service.UserPService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserPServiceImpl implements UserPService {
    @Autowired
    private UserPMapper userPMapper;
    @Autowired
    private UserInfoPMapper userInfoPMapper;
    @Autowired
    private DeptPMapper deptPMapper;
    @Autowired
    private ModulePMapper modulePMapper;

    public List<UserP> findByUserName(String username){
        //创建UserPExample对偶
        UserPExample userPExample = new UserPExample();
        UserPExample.Criteria criteria = userPExample.createCriteria();//用于封装条件
        criteria.andUserNameEqualTo(username); //username=xxx
        return userPMapper.selectByExample(userPExample);
    }

    public UserP login(String username) {
        //创建UserPExample对偶
        UserPExample userPExample = new UserPExample();
        UserPExample.Criteria criteria = userPExample.createCriteria();//用于封装条件
        criteria.andUserNameEqualTo(username); //username=xxx
        criteria.andStateEqualTo(1);//1代表启用,0代表禁用
        List<UserP> list = userPMapper.selectByExample(userPExample);
        if(list!=null&&list.size()>0){
            return list.get(0);
        }
        return null;
    }

    public CurrentUser findUserInfoDeptByUser(UserP userP) {
        String userId = userP.getUserId(); //获取用户编号
        //根据用户编号查询用户扩展信息
        UserInfoP userInfoP = userInfoPMapper.selectByPrimaryKey(userId);
        //根据部门编号查询部门信息
        DeptP deptP = deptPMapper.selectByPrimaryKey(userP.getDeptId());
        CurrentUser currentUser = new CurrentUser();
        currentUser.setUserP(userP);
        currentUser.setUserInfoP(userInfoP);
        currentUser.setDeptP(deptP);
        return currentUser;

    }

    public List<ModuleP> getPermissionsByUserId(String userid) {
        return modulePMapper.getPermissionsByUserId(userid);
    }
}

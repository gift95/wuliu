package cn.yunhe.service;

import cn.yunhe.pojo.CurrentUser;
import cn.yunhe.pojo.ModuleP;
import cn.yunhe.pojo.UserP;

import java.util.List;

public interface UserPService {
    /**
     * 根据用户名查找
     * @param username
     * @return
     */
    public List<UserP> findByUserName(String username);

    /**
     * 用户登录
     * @param username
     * @return
     */
    public UserP login(String username);

    /**
     * 根据用户信息查询扩展信息和部门信息
     * @param userP
     * @return
     */
    CurrentUser findUserInfoDeptByUser(UserP userP);

    /**
     * 根据用户编号查询该用户拥有的权限信息
     * @param userid
     * @return
     */
    public List<ModuleP> getPermissionsByUserId(String userid);
}

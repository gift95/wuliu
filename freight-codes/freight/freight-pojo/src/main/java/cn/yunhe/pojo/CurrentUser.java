package cn.yunhe.pojo;

import java.io.Serializable;

public class CurrentUser implements Serializable {
    private UserP userP;//封装用户信息
    private UserInfoP userInfoP; //用户扩展信息
    private DeptP deptP; //部门信息

    public UserP getUserP() {
        return userP;
    }

    public void setUserP(UserP userP) {
        this.userP = userP;
    }

    public UserInfoP getUserInfoP() {
        return userInfoP;
    }

    public void setUserInfoP(UserInfoP userInfoP) {
        this.userInfoP = userInfoP;
    }

    public DeptP getDeptP() {
        return deptP;
    }

    public void setDeptP(DeptP deptP) {
        this.deptP = deptP;
    }
}

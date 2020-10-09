package cn.yunhe.service;

import cn.yunhe.pojo.DeptP;
import cn.yunhe.pojo.PageBean;

import java.util.List;

public interface DeptService {
    /**
     * 查询部门信息并分页展示
     * @param pageBean
     * @return
     */
    public PageBean listDeptOfPage(PageBean pageBean);

    /**
     * 查询部门列表
     * @return
     * @throws Exception
     */
    public List<DeptP> listDept()throws Exception;

    /**
     * 新增部门
     * @param deptP
     * @throws Exception
     */
    public void createDept(DeptP deptP)throws Exception;
}

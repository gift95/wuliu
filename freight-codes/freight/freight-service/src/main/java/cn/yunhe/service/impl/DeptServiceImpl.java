package cn.yunhe.service.impl;

import cn.yunhe.mapper.DeptPMapper;
import cn.yunhe.pojo.DeptP;
import cn.yunhe.pojo.DeptPVo;
import cn.yunhe.pojo.PageBean;
import cn.yunhe.service.DeptService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class DeptServiceImpl implements DeptService {
    @Autowired
    private DeptPMapper deptPMapper;

    public PageBean listDeptOfPage(PageBean pageBean) {
        //设置当前页和分页单位
        PageHelper.startPage(pageBean.getCurPage(),pageBean.getPageSize());
        //查询部门信息
        List<DeptPVo> list = deptPMapper.listDeptAndParent();

        //创建PageInfo对象,是PageHelper提供的工具类
        PageInfo<DeptPVo> pageInfo = new PageInfo<DeptPVo>(list);
        //获取分页的数据
        List<DeptPVo> data = pageInfo.getList();
        //获取总记录数
        long totalRows = pageInfo.getTotal();
        //获取总页数
        int totalPages = pageInfo.getPages();
        //将数据封装到PageBean中
        pageBean.setDatas(data);
        pageBean.setTotalRows(totalRows);
        pageBean.setTotalPages(totalPages);
        return pageBean;
    }

    public List<DeptP> listDept() throws Exception {
        return deptPMapper.selectByExample(null);
    }

    public void createDept(DeptP deptP) throws Exception {
        //生成dept_id,使用UUID
        deptP.setDeptId(UUID.randomUUID().toString());
        //设置state
        deptP.setState(1);
        //设置dept_no
        deptP.setDeptNo(String.valueOf(System.currentTimeMillis()));
        deptPMapper.insertSelective(deptP);
    }
}

package cn.yunhe.mapper;

import cn.yunhe.pojo.DeptP;
import cn.yunhe.pojo.DeptPExample;
import cn.yunhe.pojo.DeptPVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeptPMapper {
    long countByExample(DeptPExample example);

    int deleteByExample(DeptPExample example);

    int deleteByPrimaryKey(String deptId);

    int insert(DeptP record);

    int insertSelective(DeptP record);

    List<DeptP> selectByExample(DeptPExample example);

    DeptP selectByPrimaryKey(String deptId);

    int updateByExampleSelective(@Param("record") DeptP record, @Param("example") DeptPExample example);

    int updateByExample(@Param("record") DeptP record, @Param("example") DeptPExample example);

    int updateByPrimaryKeySelective(DeptP record);

    int updateByPrimaryKey(DeptP record);

    /**
     * 查询部门和上级部门信息
     * @return
     */
    List<DeptPVo> listDeptAndParent();
}
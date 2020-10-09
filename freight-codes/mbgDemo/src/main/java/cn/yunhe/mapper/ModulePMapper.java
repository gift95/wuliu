package cn.yunhe.mapper;

import cn.yunhe.pojo.ModuleP;
import cn.yunhe.pojo.ModulePExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ModulePMapper {
    long countByExample(ModulePExample example);

    int deleteByExample(ModulePExample example);

    int deleteByPrimaryKey(String moduleId);

    int insert(ModuleP record);

    int insertSelective(ModuleP record);

    List<ModuleP> selectByExample(ModulePExample example);

    ModuleP selectByPrimaryKey(String moduleId);

    int updateByExampleSelective(@Param("record") ModuleP record, @Param("example") ModulePExample example);

    int updateByExample(@Param("record") ModuleP record, @Param("example") ModulePExample example);

    int updateByPrimaryKeySelective(ModuleP record);

    int updateByPrimaryKey(ModuleP record);
}
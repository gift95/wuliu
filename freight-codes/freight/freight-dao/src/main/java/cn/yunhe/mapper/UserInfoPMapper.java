package cn.yunhe.mapper;

import cn.yunhe.pojo.UserInfoP;
import cn.yunhe.pojo.UserInfoPExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserInfoPMapper {
    long countByExample(UserInfoPExample example);

    int deleteByExample(UserInfoPExample example);

    int deleteByPrimaryKey(String userInfoId);

    int insert(UserInfoP record);

    int insertSelective(UserInfoP record);

    List<UserInfoP> selectByExample(UserInfoPExample example);

    UserInfoP selectByPrimaryKey(String userInfoId);

    int updateByExampleSelective(@Param("record") UserInfoP record, @Param("example") UserInfoPExample example);

    int updateByExample(@Param("record") UserInfoP record, @Param("example") UserInfoPExample example);

    int updateByPrimaryKeySelective(UserInfoP record);

    int updateByPrimaryKey(UserInfoP record);
}
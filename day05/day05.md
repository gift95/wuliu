# 1.给用户分配角色

## 1.1   mapper

逆向工程

## 1.2   service

注意：给用户分配角色必须先删除原有的角色，在删除新分配的角色，否则会重复保存角色

```java
@Service
public class RoleUserServiceImpl implements RoleUserService{

    @Autowired
    private RoleUserPMapper roleUserPMapper;

    //查询当前配置用户所拥有的角色
    @Override
    public List<RoleUserPKey> listRoleUser(String userid) throws Exception {
        RoleUserPExample roleUserPExample = new RoleUserPExample();
        RoleUserPExample.Criteria criteria = roleUserPExample.createCriteria();
        criteria.andUserIdEqualTo(userid);
        return roleUserPMapper.selectByExample(roleUserPExample);
    }

    @Override
    public void addRoleUser(String id, String[] roleIds) throws Exception {
        //必须先删除用户原来的角色
        RoleUserPExample roleUserPExample = new RoleUserPExample();
        RoleUserPExample.Criteria criteria = roleUserPExample.createCriteria();
        criteria.andUserIdEqualTo(id);
        roleUserPMapper.deleteByExample(roleUserPExample);

        //保存新的角色
        for (int i = 0; i < roleIds.length; i++) {
            String roleId = roleIds[i];
            RoleUserPKey roleUserPKey = new RoleUserPKey();
            roleUserPKey.setUserId(id);
            roleUserPKey.setRoleId(roleId);
            roleUserPMapper.insertSelective(roleUserPKey);
        }
    }
}
  
```

## 1.3   controller

```java
`///跳转分配角色页面
@RequestMapping("torole")
public String torole(String id,Model model) throws Exception {
    model.addAttribute("id",id);
    //查询用户扩展信息
    UserInfoP userInfoP = userInfoService.getUserInfoPById(id);
    model.addAttribute("userInfoP",userInfoP);

    //查询所有角色
    List<RoleP> rolePList = roleService.listRole();
    model.addAttribute("rolePList",rolePList);

    //查询当前配置的用户拥有的角色
    List<RoleUserPKey> roleUserList = roleUserService.listRoleUser(id);
    //遍历roleUserList--把所有的user_id拼成1,2,3,4,5
    String[] roleidsArr = new String[roleUserList.size()];
    for (int i = 0; i < roleUserList.size(); i++) {
        RoleUserPKey roleUserPKey =  roleUserList.get(i);
        roleidsArr[i]=roleUserPKey.getRoleId();
        
    }
    String roleids = StringUtils.join(roleidsArr, ",");
    model.addAttribute("roleids",roleids);
    return "sysadmin/user/jUserRole";
}

```

## 1.4   jsp

修改jUserRole.jsp，完成回显角色

```jsp
<div style="text-align:left">
<c:forEach items="${rolePList}" var="obj">
    <span style="padding:3px;">
    <input type="checkbox" name="roleId" value="${obj.roleId}" class="input"
           <c:if test="${fn:contains(roleids,obj.roleId)}">checked</c:if>
    >
    ${obj.name}
    </span>
</c:forEach>
</div>
    `     
```

 

# 2.  角色管理

## 2.1   查询

### 2.1.1   mapper

逆向工程

### 2.1.2   service

修改RoleServiceImpl

```java
@Override
public PageBean listRoleOfPage(PageBean pageBean) throws Exception {
    //设置查询条件
    PageHelper.startPage(pageBean.getCurPage(),pageBean.getPageSize());

    //排序
    RolePExample rolePExample = new RolePExample();
    rolePExample.setOrderByClause("order_no desc");
    List<RoleP> deptPVoList = rolePMapper.selectByExample(rolePExample);

    //获取分页信息
    PageInfo<RoleP> pageInfo = new PageInfo<RoleP>(deptPVoList);

    pageBean.setTotalPages(pageInfo.getPages());
    pageBean.setDatas(pageInfo.getList());
    pageBean.setTotalRows(pageInfo.getTotal());
    return pageBean;
}

```

### 2.1.3   controller



```java
@Controller
@RequestMapping("/role")
public class RoleController {

    @Resource(name="roleServiceImpl")
    private RoleService roleService;

    @RequestMapping("list")
    public String listDeptAndParentOfPage(PageBean pageBean, Model model) throws Exception {
        PageBean pb = roleService.listRoleOfPage(pageBean);
        model.addAttribute("pb",pb);
        return "sysadmin/role/jRoleList";
    }
}

```



### 2.1.4   jsp

修改jRoleList.jsp

```jsp
<script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
... ...
<li id="new"><a href="#" onclick="formSubmit('${ctx}/role/tocreate','_self');this.blur();">新增</a>

```

 

## 2.2   新增

### 2.2.1   mapper

1、逆向工程

2、查询最大的orderNo

修改RolePMapper

```java
`Integer getMaxOrderNo();`
```

 

修改RolePMapper.xml

```xml
<!--查询最大的orderNo-->
<select id="getMaxOrderNo" resultType="Integer">
  select max(order_no)+1 order_no from role_p
</select>
    
```

 

### 2.2.2   service

```java
@Override
public void createRole(RoleP roleP) throws Exception {
    //获取当前登录用户的信息
    Subject subject = SecurityUtils.getSubject();
    CurrentUser currentUser = (CurrentUser) subject.getPrincipal();
    UserP user = currentUser.getUserP();
    DeptP deptP = currentUser.getDeptP();

    //补全角色的信息
    roleP.setRoleId(UUID.randomUUID().toString());
    roleP.setCreateBy(user.getUserId());
    roleP.setCreateDept(deptP.getDeptId());
    roleP.setUpdateBy(user.getUserId());
    roleP.setCreateTime(new Date());
    roleP.setUpdateTime(new Date());

    //获取最大的orderNo
    Integer orderNo = rolePMapper.getMaxOrderNo();
    roleP.setOrderNo(orderNo);
    rolePMapper.insertSelective(roleP);
}
  
```

### 2.2.3   controller

```java
//跳转信息页面

@RequestMapping("/tocreate")
public String tocreate(Model model) throws Exception {
    return "sysadmin/role/jRoleCreate";
}

@RequestMapping("/create")
public String create(RoleP roleP,Model model) throws Exception {
    roleService.createRole(roleP);
    return "redirect:/role/list";
}
     
```

 

### 2.2.4   jsp

修改jRoleCreate.jsp

## 2.3   修改

## 2.4   明细

## 2.5   删除

## 2.6   excel导出



## 2.3   给角色分配权限

### 2.3.1   跳转分配权限页面

#### 2.3.1.1  jsp

修改jRoleList.jsp

```jsp
//实现权限  
function toModule() {   
	if(isOnlyChecked()) {    
		formSubmit('${ctx}/role/tomodule', '_self');  
	}else{    
		alert("请先选择一项并且只能选择一项，再进行操作！"); 
	} 
}
... ...
<li id="people"><a  href="#" onclick="toModule();this.blur();" title="分配权限">权限`
```

 

#### 2.3.1.2  controller

修改RoleController

```java
//跳转分配权限页面  
@RequestMapping("/tomodule")  
public String tomodule(Model model) throws Exception {   
    return "sysadmin/role/jRoleModule";
}
```

### 2.3.2   zTree的使用

#### 2.3.2.1  ztree简介

 zTree 是一个依靠 jQuery 实现的多功能 “树插件”。

 

#### 2.3.2.2  下载

https://gitee.com/zTree/zTree_v3

#### 2.3.2.3  api的使用

注意：切换成ie模式，并允许阻止内容

#### 2.3.2.4  demo的使用

![img](day05.assets/clip_image002-1600181061380.jpg)

#### 2.3.2.5  引用

![img](day05.assets/clip_image004-1600181061381.jpg)

### 2.3.3   zTree展示权限

#### 2.3.3.1  pojo

1、因为ztree的zNode要求必须是如下形式：

![img](day05.assets/clip_image006-1600181061381.jpg)

 

2、所以可以创建一个bean对象：

```java 
//ztree的bean对象
public class TreeNode {
    private String id;
    private String pId;
    private String name;
    private Boolean open=true;
    private Boolean checked;
... ...
}

```

#### 2.3.3.2  mapper

修改ModulePMapper

```java
    //查询所有的权限，并把查询结果装到TreeNode里
    List<TreeNode> listModuleOfTreeNode();
```

 

修改ModulePMapper.xml

```xml
  <select id="listModuleOfTreeNode" resultType="cn.yunhe.pojo.TreeNode">
     select m.module_id id,m.parent_id pId,m.name from module_p m
  </select>
```

 

#### 2.3.3.3  service

```java
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RolePMapper rolePMapper;
    @Autowired
    private ModulePMapper modulePMapper;
    ....
	public List listModuleOfTreeBean() throws Exception {
        return modulePMapper.listModuleOfTreeNode();
    }
}
```

 

#### 2.3.3.4  controller

```java
@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private RoleService roleService;
     /**
     * 跳转至分配权限的页面
     * @return
     * @throws Exception
     */
    @RequestMapping("/tomoduel")
    public String tomoduel() throws Exception {
        return "sysadmin/role/jRoleModule";
    }

    /**
     * 查询数据库，获取权限信息，将权限数据转换为TreeNode
     * @return
     */
    @RequestMapping("/listModuleOfTreeNode")
    @ResponseBody
    public List<TreeNode> listModuleOfTreeNode() throws  Exception{
        return  roleService.listModuleOfTreeBean();
    }
}
```

 

#### 2.3.3.5  jsp

修改jRoleModule.jsp

```jsp
<script type="text/javascript">
   var setting = {
      check: {
         enable: true //显示checkbox/radio
      },
      data: {
         simpleData: {
            enable: true//使用简单的数据模式
         }
      }
   };
   //树的节点数据
/* var zNodes = [
      {"id":1, "pId":0, "name":"系统管理",open:true},
      {"id":11, "pId":1, "name":"用户管理",open:true},
      {"id":12, "pId":1, "name":"角色管理",open:true},
      {"id":111, "pId":11, "name":"新增",open:true,checked:true }
   ];*/
   $(function(){
      $.ajax({
         url:'${ctx}/role/listModuleOfTreeBean',
         type:'post',
         success:initzTree
      });
   });
   function initzTree(zNodes){
      /**
       obj：显示zTree的dom节点
       setting：树的配置信息
       zNodes：树的节点数据
       */
      $.fn.zTree.init($("#jTree"), setting, zNodes);
   }

```

 

```jsp
<div>
   <%--显示zTree的dom节点--%>
   <ul id="jTree" class="ztree"></ul>
</div>
     
```

### 2.3.4   zTree回显权限

#### 2.3.4.1  mapper

修改ModulePMapper.xml

```xml
<!--查询所有的权限，并把查询结果装到TreeBean里,并支持回显-->
<select id="listModuleOfTreeNodeByRoleId" parameterType="String" resultType="cn.yunhe.pojo.TreeNode">
    select m.module_id id,m.parent_id pId,m.name,'true' checked from module_p m where m.module_id in(
        select module_id from role_module_p rm where role_id=#{roleId}
    )
    union
    select m.module_id id,m.parent_id pId,m.name,'false' checked from module_p m where m.module_id not in(
        select module_id from role_module_p rm where role_id=#{roleId}
    )
</select>`     

```

 

修改ModulePMapper

```java
 //查询所有的权限，并把查询结果装到TreeBean里，并支持回显
    List<TreeNode> listModuleOfTreeNodeByRoleId(String roleId);
```

#### 2.3.4.2  Service

修改RoleServiceImpl

```java
@Override
public RoleP getRoleByRoleId(String id) throws Exception {
    return rolePMapper.selectByPrimaryKey(id);
}

@Override
public List<TreeNode> listModuleOfTreeBeanByRoleId(String roleid) throws Exception {
    /***第一套思路：不推荐**/
    //1、先查询所有权限装到ArrayList
    //2、再查询当前角色所拥有的权限ArrayList
    //3、遍历所有权限，如果找到则checked为true

    /***第二套思路：推荐**/
    //1、查询当前角色所拥有的权限： select id,pid,name,'true' checked from module_p
    //中间用union all连接
    //2、查询当前角色所不拥有的权限：select id,pid,name,'false' checked from module_p
    return modulePMapper.listModuleOfTreeBeanByRoleId(roleid);
}
     
```

 

#### 2.3.4.3  controller

修改ModuleController

```java
//跳转分配权限页面
@RequestMapping("/tomodule")
public String tomodule(String id,Model model) throws Exception {
    //查询当前角色的详细信息
     RoleP role = roleService.getRoleByRoleId(id);
    model.addAttribute("role",role);
    return "sysadmin/role/jRoleModule";
}


//查询zTree的数据
@RequestMapping("/listModuleOfTreeBeanByRoleId")
@ResponseBody
public  List<TreeNode> listModuleOfTreeBeanByRoleId(String roleid,Model model) throws Exception {
    List<TreeNode> treeNodes = roleService. listModuleOfTreeBeanByRoleId(roleid);
    return treeNodes;
}

```

 

#### 2.3.4.4  jsp

修改jRoleModule.jsp

```java
$(function(){
   $.ajax({
      url:'${ctx}/role/listModuleOfTreeBean',
      type:'post',
      data:{"roleid":'${roleid}'},
      success:initzTree
   });
});
     
```

 

### 2.3.5   分配权限

保存zTree选中的节点信息

#### 2.3.5.1  mapper

逆向工程

#### 2.3.5.2  service

思路：先删除角色原来的权限，再保存新的权限

```java
package cn.yunhe.service;

import cn.yunhe.mapper.RoleModulePMapper;
import cn.yunhe.pojo.RoleModulePExample;
import cn.yunhe.pojo.RoleModulePKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("roleModuleServiceImpl")
public class RoleModuleServiceImpl implements RoleModuleService{

    @Autowired
    private RoleModulePMapper roleModulePMapper;

    @Override
    public void createRoleModule(String roleId, String[] moduleIds) throws Exception {
        //先删除原来的权限
        RoleModulePExample roleModulePExample = new RoleModulePExample();
        RoleModulePExample.Criteria criteria = roleModulePExample.createCriteria();
        criteria.andRoleIdEqualTo(roleId);
        roleModulePMapper.deleteByExample(roleModulePExample);

        //再保存新的权限
        for (int i = 0; i < moduleIds.length; i++) {
            String moduleId = moduleIds[i];
            RoleModulePKey roleModulePKey = new RoleModulePKey();
            roleModulePKey.setRoleId(roleId);
            roleModulePKey.setModuleId(moduleId);
            roleModulePMapper.insertSelective(roleModulePKey);
        }
    }
}

```

 

 

#### 2.3.5.3  controller

修改RoleController

```java
//权限分配
@RequestMapping("/role")
public String createRoleModule(String roleId,String[] moduleIds,Model model) throws Exception {
    roleModuleService.createRoleModule(roleId,moduleIds);
    //清空缓存
    customRealm.clearCached();
    return "redirect:/role/list";
}
   
```

修改UserController

```java
@RequestMapping("/role")
public String role(String id,String[] roleId) throws Exception {
    //把数据保存到role_user_p表
    roleUserService.addRoleUser(id,roleId);
    //清空缓存
    customRealm.clearCached();
    return "redirect:/user/list";
}

```

 

#### 2.3.5.4  jsp

修改jRoleModule.jsp

```jsp
//获取所有选择的节点
function submitCheckedNodes() {
   var nodes = new Array();//装选中的节点
   //获得选中的节点
   nodes = zTreeObj.getCheckedNodes(true);
   //选中的id
   var ids = new Array();
   //遍历选中的节点数组，并把节点对象的id属性装到ids数组中
   for (var i = 0; i < nodes.length; i++) {
      ids.push(nodes[i].id);
   }
   //把数组ids转换成1,2,3,4这种形式
   ids = ids.join(",")
   $("#moduleIds").val(ids);
}

... ...

<input type="hidden" name="roleId" value="${role.roleId}"/>
<input type="hidden" id="moduleIds" name="moduleIds" />

... ...

<li id="save"><a href="#" onclick="submitCheckedNodes();formSubmit('${ctx}/role/module','_self');this.blur();">保存</a></li>
 
```

 

# 3.  模块管理

即权限管理

## 3.1   查询

作业

## 3.2   新增

### 3.2.1   pojo

修改TreeNode：新增权限时需要使用ztree显示上级



```java
//ztree的bean对象
public class TreeNode {
    private String id;
    private String pId;
    private String name;
    private Boolean open=true;
    private Boolean checked;
    private Integer layerNum;
... ...
}

```



### 3.2.2   mapper

修改ModuleMapper.xml

```xml
<!--查询所有的权限，并把查询结果装到TreeBean里-->
<select id="listModuleOfTreeBean" resultType="cn.yunhe.pojo.TreeNode">
    select m.module_id id,m.parent_id pId,m.name,'false' open,layer_num+1 layerNum from module_p m
</select>
```

修改ModuleMapper

```java
`//查询所有的权限 
 List listModuleOfTreeBean();`
```

### 3.2.3   service

```java
@Override
public List<TreeNode> listModuleOfTreeBean() throws Exception {
    return modulePMapper.listModuleOfTreeBean();
}

```

 

### 3.2.4   controller

```java
@RequestMapping("/tocreate")
public String tocreate(Model model) throws Exception {
    return "sysadmin/module/jModuleCreate";
}

//查询zTree的数据
@RequestMapping("/listModuleOfTreeBean")
@ResponseBody
public List<TreeNode> listModuleOfTreeBean(Model model) throws Exception {
    List<TreeNode> treeNodes = moduleService.listModuleOfTreeBean();
    return treeNodes;
}
 
```

 

### 3.2.5   jsp

修改jModuleCreate.jsp

```jsp
<link rel="stylesheet" href="${ctx }/components/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<link rel="stylesheet" href="${ctx }/components/zTree/css/demo.css" type="text/css">
<script type="text/javascript" src="${ctx }/components/zTree/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${ctx }/components/zTree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="${ctx }/components/zTree/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript">
    var zTreeObj;
    var setting = {
        check: {
            enable: true, //显示checkbox/radio
            chkStyle: "radio",
            radioType: "all"
        },
        data: {
            simpleData: {
                enable: true//使用简单的数据模式
            }
        },
        callback: {
            onClick: onClick,
            onCheck: onCheck
        }
    };
    //树的节点数据
    /* var zNodes = [
            {"id":1, "pId":0, "name":"系统管理",open:true},
            {"id":11, "pId":1, "name":"用户管理",open:true},
            {"id":12, "pId":1, "name":"角色管理",open:true},
            {"id":111, "pId":11, "name":"新增",open:true,checked:true }
        ];*/
    $(function(){
        $.ajax({
            url:'${ctx}/module/listModuleOfTreeBean',
            type:'post',
            success:initzTree
        });
    });
    function onClick(e, treeId, treeNode) {
        zTreeObj.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    function onCheck(e, treeId, treeNode) {
        var nodes = zTreeObj.getCheckedNodes(true);
        //选中的节点的名字显示到父级框
        $("#moduleSel").val(nodes[0].name);
        //选中的节点的id赋值到隐藏框
        $("#parentId").val(nodes[0].id);
        //选中的节点的layerNum赋值到层级
        $("#layerNum").val(nodes[0].layerNum);
    }
    function showMenu() {
        var moduleObj = $("#moduleSel");
        var moduleOffset = $("#moduleSel").offset();
        //设置zTree显示的位置
        $("#menuContent").css({left:moduleOffset.left + "px", top:moduleOffset.top + moduleObj.outerHeight() + 
                                                                                             "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }
    function onBodyDown(event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "moduleSel" || event.target.id == "menuContent" ||
                                                                $(event.target).parents("#menuContent").length>0)) {
            hideMenu();
        }
    }
    function hideMenu() {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", onBodyDown);
    }
    function initzTree(zNodes){
        /**
         obj：显示数的heml元素
         setting：树的配置信息
         zNodes：树的节点数据
         */
        zTreeObj = $.fn.zTree.init($("#jTree"), setting, zNodes);
    }
</script>
... ...
<td class="columnTitle">父级：</td>
<td class="tableContent" colspan="3">
    <input id="moduleSel" type="text" style="width:150px" readonly="readonly" onclick="showMenu();" />
    <input id="parentId" name="parentId" type="hidden">
    &nbsp;<a id="menuBtn" href="#" onclick="showMenu(); return false;">选择父级菜单</a>
</td>
... ...
<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
    <ul id="jTree" class="ztree" style="margin-top:0; width:180px; height: 300px;"></ul>
</div>
     
```

 

## 3.3   修改

### 3.3.1   mapper

修改ModuleMapper.xml：修改权限时回显上级权限

```xml
<!--通过parentId查询所有的权限，并把查询结果装到TreeBean里,并支持回显-->
<select id="listModuleOfTreeBeanByParentId" resultType="cn.yunhe.pojo.TreeNode">
  select m.module_id id,m.parent_id pId,m.name,'false' checked,layer_num+1 layerNum from module_p m where m.MODULE_ID!=#{parentId}
  union
  select m.module_id id,m.parent_id pId,m.name,'true' checked,layer_num+1 layerNum from module_p m where m.MODULE_ID=#{parentId}
</select>

```

 

 

修改ModuleMapper

```java
//通过parentId查询所有的权限，并把查询结果装到TreeBean里,并支持回显
List<TreeNode> listModuleOfTreeBeanByParentId(String parentId);
  
```

### 3.3.2   service

### 3.3.3   controller

## 3.4   明细

作业

## 3.5   删除

作业
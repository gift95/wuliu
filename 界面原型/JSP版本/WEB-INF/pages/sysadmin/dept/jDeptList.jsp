<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../baselist.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<script type="text/javascript" src="${ctx }/js/jquery-1.4.4.js"></script>
	<script>
	     function isOnlyChecked(){
	    	 var checkBoxArray = document.getElementsByName('id');
				var count=0;
				for(var index=0; index<checkBoxArray.length; index++) {
					if (checkBoxArray[index].checked) {
						count++;
					}
				}
			//jquery
			//var count = $("[input name='id']:checked").size();
			if(count==1)
				return true;
			else
				return false;
	     }
	     function toView(){
	    	 if(isOnlyChecked()){
	    		 formSubmit('deptAction_toview','_self');
	    	 }else{
	    		 alert("请先选择一项并且只能选择一项，再进行操作！");
	    	 }
	     }
	     //实现更新
	     function toUpdate(){
	    	 if(isOnlyChecked()){
	    		 formSubmit('deptAction_toupdate','_self');
	    	 }else{
	    		 alert("请先选择一项并且只能选择一项，再进行操作！");
	    	 }
	     }
	</script>
</head>

<body>
<form name="icform" method="post">

<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
  <div id="navMenubar">
<ul>
<li id="view"><a href="#" onclick="javascript:toView()">查看</a></li>
<li id="new"><a href="#" onclick="formSubmit('deptAction_tocreate','_self');this.blur();">新增</a></li>
<li id="update"><a href="#" onclick="javascript:toUpdate()">修改</a></li>
<li id="delete"><a href="#" onclick="formSubmit('deptAction_delete','_self');this.blur();">删除</a></li>
	<li id="search"><a href="#" onclick="formSubmit('deptAction_list','_self');this.blur();">查询</a></li>
</ul>
  </div>
</div>
</div>
</div>

<div class="textbox" id="centerTextbox">
  <div class="textbox-header">
  <div class="textbox-inner-header">
  <div class="textbox-title">
    部门列表
  </div>
  </div>
  </div>
</div>
<div>


<div class="eXtremeTable" >
<table id="ec_table" class="tableRegion" width="98%" >
	<thead>
	<tr>
		<td class="tableHeader"><input type="checkbox" name="selid" onclick="checkAll('id',this)"></td>
		<td class="tableHeader">序号</td>
		<td class="tableHeader">编号</td>
		<td class="tableHeader">上级</td>
		<td class="tableHeader">名称</td>
		<td class="tableHeader">状态</td>
	</tr>
	</thead>
	<tbody class="tableBody" >
    <jsp:include page="../../page.jsp"></jsp:include>

	<c:forEach items="${pb.datas}" var="dept"  varStatus="st">
		<tr class="odd" onmouseover="this.className='highlight'" onmouseout="this.className='odd'" >
			<td><input type="checkbox" name="id" value="${dept.deptId }"/></td>
			<td>${st.count }</td>
			<td>${dept.deptNo }</td>
			<td>${dept.parentDeptName }</td>
			<td><a href="deptAction_toview?id=${dept.deptId }">${dept.deptName }</a></td>
			<td>${dept.state==1?'启用':'停用'}</td>
		</tr>
   </c:forEach>
	</tbody>
</table>
</div>

</div>

</form>
</body>
</html>


<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../base.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
</head>

<body>
<form name="icform" method="post">
      <input type="hidden" name="userId" value="${u.userId}"/>
	  <input type="hidden" name="userInfoId" value="${uf.userInfoId}"/>
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
  <div id="navMenubar">
<ul>
<li id="save"><a href="#" onclick="formSubmit('userAction_update','_self');this.blur();">保存</a></li>
<li id="back"><a href="#" onclick="history.go(-1);">返回</a></li>
</ul>
  </div>
</div>
</div>
</div>
   
  <div class="textbox-title">
	<img src="${ctx }/skin/default/images/icon/currency_yen.png"/>
   查看用户
  </div> 
  

 
    <div>
		<table class="commonTable" cellspacing="1">
	        <tr>
	            <td class="columnTitle">所在部门：</td>
	             <td class="tableContent">
					 <select name="deptId">
						 <option value="">--请选择--</option>
						 <c:forEach items="${ds}" var="d">
							 <option ${u.deptId==d.deptId?'selected':''} value="${d.deptId}">${d.deptName}</option>
						 </c:forEach>
					 </select>
	            </td>
	        </tr>		
	        <tr>
	            <td class="columnTitle">用户名：</td>
	            <td class="tableContent"><input type="text" name="userName" value="${u.userName }"/></td>
	        </tr>	
	         <tr>
	            <td class="columnTitle">状态：</td>
	            <td class="tableContentAuto">
	              <input type="radio" name="state" class="input" ${u.state==0?'checked':'' } value="0">停用
	              <input type="radio" name="state" class="input"  ${u.state==1?'checked':'' } value="1">启用
	            </td>
	        </tr>
			<tr>
				<td class="columnTitle">姓名：</td>
				<td class="tableContent"><input type="text" name="name" value="${uf.name}"/></td>
				<td class="columnTitle">直属领导：</td>
				<td class="tableContent">
					<select name="managerId">
						<option value="">--请选择--</option>
						<c:forEach items="${uis}" var="ui">
							<option ${uf.managerId==ui.userInfoId?'selected':''} value="${ui.userInfoId}">${ui.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="columnTitle">入职时间：</td>
				<td class="tableContent">
					<input type="date"  name="joinDate"
						   value="<fmt:formatDate value='${uf.joinDate}' pattern='yyyy-MM-dd' />" />
				</td>
				<td class="columnTitle">薪水：</td>
				<td class="tableContent"><input type="text" name="salary" value="${uf.salary}"/></td>
			</tr>
			<tr>
				<td class="columnTitle">等级：</td>
				<td class="tableContentAuto">
					<input type="radio" name="degree" ${uf.degree==0?"checked":""} value="0" class="input"/>超级管理员
					<input type="radio" name="degree" ${uf.degree==1?"checked":""}  value="1" class="input"/>跨部门跨人员
					<input type="radio" name="degree" ${uf.degree==2?"checked":""}  value="2" class="input"/>管理所有下属部门和人员
					<input type="radio" name="degree" ${uf.degree==3?"checked":""}  value="3" class="input"/>管理本部门
					<input type="radio" name="degree" ${uf.degree==4?"checked":""}  value="4" class="input"/>普通员工
				</td>
				<td class="columnTitle">性别：</td>
				<td class="tableContentAuto">
					<input type="radio" name="gender"  ${uf.gender==1?"checked":""}  value="1" class="input"/>男
					<input type="radio" name="gender" ${uf.gender==0?"checked":""}  value="0" class="input"/>女
				</td>
			</tr>
			<tr>
				<td class="columnTitle">岗位：</td>
				<td class="tableContent"><input type="text" name="station" value="${uf.station}"/></td>
				<td class="columnTitle">电话：</td>
				<td class="tableContent"><input type="text" name="telephone" value="${uf.telephone}"/></td>
			</tr>
			<tr>
				<td class="columnTitle">邮箱：</td>
				<td class="tableContent"><input type="text" name="email" /></td>
				<td class="columnTitle">出生年月：</td>
				<td class="tableContent">
					<input type="date"  name="birthday"
						   value="<fmt:formatDate value='${uf.birthday}' pattern='yyyy-MM-dd' />"
					/>
				</td>
			</tr>
			<tr>
				<td class="columnTitle">排序号：</td>
				<td class="tableContent"><input type="text" name="orderNo" value="${uf.orderNo}"/></td>
				<td class="columnTitle">说明：</td>
				<td class="tableContent">
					<textarea name="remark" style="height:120px;">${uf.remark}</textarea>
				</td>
			</tr>
		</table>
	</div>
 </form>
</body>
</html>
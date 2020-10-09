<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../baselist.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>

<body>
<form name="icform" method="post">

    <div id="menubar">
        <div id="middleMenubar">
            <div id="innerMenubar">
                <div id="navMenubar">
                    <ul>
                        <li id="view"><a href="#" onclick="formSubmit('../contractAction_toview','_self');this.blur();">查看</a></li>
                        <li id="new"><a href="#"
                                        onclick="formSubmit('contractAction_print','_self');this.blur();">打印</a></li>
                        <li id="new"><a href="#"
                                        onclick="formSubmit('${ctx}/cargo/exportAction_tocreate','_self');this.blur();">报运</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="textbox-title">
        <img src="${ctx }/skin/default/images/icon/currency_yen.png"/>
        购销合同列表
        <span class="noprint">
<div id="find_div" style="width:98%;">
<fieldset>
<legend><font color="000">查询条件&nbsp;</font></legend>
<div style="width:98%;padding-top:7px;text-align:left;">

类型：
<select name="f_type" style="width:130px;heigh:30px;" dataType="下拉列表" dispName="查询条件">
<option value='' selected>--请选择--</option><option ${f_type=='hth'?'selected':''} value='hth'>合同号</option><option ${f_type=='hh'?'selected':''}
        value='hh'>货号</option><option ${f_type=='zdr'?'selected':''} value='zdr'>制单人</option><option ${f_type=='sdr'?'selected':''}
        value='sdr'>审单人</option><option ${f_type=='yhy'?'selected':''} value='yhy'>验货员</option>
</select>

内容：
<input type="text" name="f_conditionStr" value="${f_conditionStr}" size="30"
       onFocus="this.select();"
       onKeyDown="javascript:if(event.keyCode==13){ document.getElementById('btnFind').onclick(); }"
/>

<input id="btnFind" type="button" name="查询" value="查询" onclick="formSubmit('exportAction_contractList','_self');this.blur();">
<input type="button" name="清空" value="清空" onclick="findReset();this.blur();">

</div>
</fieldset>
</div>
</span>
    </div>


    <div class="eXtremeTable">
        <table id="ec_table" class="tableRegion" width="98%">
            <thead>
            <tr>
                <td class="tableHeader"><input type="checkbox" name="selid" onclick="checkAll('id',this)"></td>
                <td class="tableHeader">序号</td>
                <td class="tableHeader">客户名称</td>
                <td class="tableHeader">合同号</td>
                <td class="tableHeader">货物数/附件数</td>
                <td class="tableHeader">制单人</td>
                <td class="tableHeader">审单人</td>
                <td class="tableHeader">验货员</td>
                <td class="tableHeader">签单日期</td>
                <td class="tableHeader">交货期限</td>
                <td class="tableHeader">船期</td>
                <td class="tableHeader">贸易条款</td>
                <td class="tableHeader">总金额</td>
                <td class="tableHeader">状态</td>
            </tr>
            </thead>
            <tbody class="tableBody">
            <jsp:include page="../../page.jsp"></jsp:include>
            <c:forEach items="${pb.datas}" var="o" varStatus="status">
                <tr class="odd" onmouseover="this.className='highlight'" onmouseout="this.className='odd'">
                    <td><input type="checkbox" name="id" value="${o.contractId}"/></td>
                    <td>${status.index+1}</td>
                    <td>${o.customName}</td>
                    <td><a href="contractAction_toview?id=${o.contractId}">${o.contractNo}</a></td>
                    <td>
                            ${o.productNum}/${o.enclosureNum}
                    </td>
                    <td>${o.inputBy}</td>
                    <td>${o.checkBy}</td>
                    <td>${o.inspector}</td>
                    <td><fmt:formatDate value="${o.signingDate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${o.deliveryPeriod}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${o.shipTime}" pattern="yyyy-MM-dd"/></td>
                    <td>${o.tradeTerms}</td>
                    <td>${o.totalAmount}</td>
                    <td><c:if test="${o.state==0}">草稿</c:if>
                        <c:if test="${o.state==1}"><font color="green">已上报</font></c:if></td>

                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>


    </div>


</form>
</body>
</html>


<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../base.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script type="text/javascript" src="${ctx }/js/datepicker/WdatePicker.js"></script>
</head>
<%
    SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");

%>
<body>
<form name="icform" method="post">

    <div id="menubar">
        <div id="middleMenubar">
            <div id="innerMenubar">
                <div id="navMenubar">
                    <ul>
                        <li id="save"><a href="#"
                                         onclick="formSubmit('contractAction_insert','_self');this.blur();">保存</a></li>
                        <li id="back"><a href="#" onclick="history.go(-1);">返回</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="textbox" id="centerTextbox">
        <div class="textbox-header">
            <div class="textbox-inner-header">
                <div class="textbox-title">
                    新增购销合同
                </div>
            </div>
        </div>


        <div>
            <table class="commonTable" cellspacing="1">
                <tr>
                    <td class="columnTitle">客户名称：</td>
                    <td class="tableContent"><input type="text" name="customName" value=""/></td>
                    <td class="columnTitle">打印版式：</td>
                    <td class="tableContentAuto">
                        <input type="radio" name="printStyle" value="2" checked class="input">两款
                        <input type="radio" name="printStyle" value="1" class="input">一款
                    </td>
                </tr>
                <tr>
                    <td class="columnTitle">合同号：</td>
                    <td class="tableContent"><input type="text" name="contractNo" value=""/></td>
                    <td class="columnTitle">收购方：</td>
                    <td class="tableContent"><input type="text" name="offeror" value="杰信商贸有限公司"/></td>
                </tr>
                <tr>
                    <td class="columnTitle">制单人：</td>
                    <td class="tableContent"><input type="text" name="inputBy" value=""/></td>
                    <td class="columnTitle">审单人：</td>
                    <td class="tableContent"><input type="text" name="checkBy" value=""/></td>
                </tr>
                <tr>
                    <td class="columnTitle">验货员：</td>
                    <td class="tableContent"><input type="text" name="inspector" value=""/></td>
                    <td class="columnTitle">签单日期：</td>
                    <td class="tableContent">
                        <input type="text" style="width:90px;" name="signingDate"
                               value="<%=sdf.format(new Date())%>"
                               onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/>
                    </td>
                </tr>
                <tr>
                    <td class="columnTitle">重要程度：</td>
                    <td class="tableContentAuto">
                        <input type="radio" name="importNum" value="3" checked class="input">★★★
                        <input type="radio" name="importNum" value="2" class="input">★★
                        <input type="radio" name="importNum" value="1" class="input">★
                    </td>
                    <td class="columnTitle">船期：</td>
                    <td class="tableContent">
                        <input type="text" style="width:90px;" name="shipTime"
                               value="<%=sdf.format(new Date())%>"
                               onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/>
                    </td>
                </tr>
                <tr>
                    <td class="columnTitle">贸易条款：</td>
                    <td class="tableContent"><input type="text" name="tradeTerms" value=""/></td>
                    <td class="columnTitle">交货期限：</td>
                    <td class="tableContent">
                        <input type="text" style="width:90px;" name="deliveryPeriod"
                               value="<%=sdf.format(new Date())%>"
                               onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/>
                    </td>
                </tr>
                <tr>
                    <td class="columnTitle">要求：</td>
                    <td class="tableContent"><textarea name="crequest" style="height:150px;">★   产品与封样无明显差异，唛头、标签及包装质量务必符合公司要求。
 ★★  产品生产前期、中期、后期抽验率不得少于10%，质量和封样一致，
       并将验货照片传回公司。
★★★ 重点客人的质量标准检验，产品抽验率不得少于50%，务必做到入箱前检查。
 交期：2019年2月15日/工厂。
       没有经过我司同意无故延期交货造成严重后果的，按照客人的相关要求处理。
 开票：出货后请将增值税发票、验货报告、合同复印件及出库单一并寄至我司，以便我司安排付款。</textarea>
                    <td class="columnTitle">说明：</td>
                    <td class="tableContent"><textarea name="remark" style="height:150px;"></textarea>
                </tr>
            </table>
        </div>

    </div>
</form>
</body>
</html>


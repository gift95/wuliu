<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../baselist.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;" charset="utf-8">
    <title></title>
    <link rel="stylesheet" rev="stylesheet" type="text/css" href="${ctx }/skin/default/css/default.css" media="all"/>
    <script type="text/javascript" src="${ctx }/js/datepicker/WdatePicker.js"></script>

    <script language="JavaScript">
        function preSubmit(serviceName) {
            if (serviceName == "确定") {
                if (lineTextMaxLen(document.all.shipper.value) > 41) {
                    showError("货主中最宽行超过了40个字符，会造成打印错乱!请修改.");
                    return false;
                }
                if (lineTextMaxLen(document.all.consignee.value) > 41) {
                    showError("提单抬头中最宽行超过了40个字符，会造成打印错乱!请修改.");
                    return false;
                }
            }
            if (serviceName == "返回") {
                return true;
            } else if (serviceName == "确定") {
                return _CheckAll(true, serviceName);
            }
        }


        //返回多行文本中最大的一行的字符数 by tony 20111219
        function lineTextMaxLen(s) {
            var lenValue = 0;
            var a = s.split("\n");
            for (var i = 0; i < a.length; i++) {
                if (a[i].length > lenValue) {
                    lenValue = a[i].length;
                }
            }
            return lenValue;
        }
    </script>
</head>

<body>
<form method="post">
    <input type="hidden" name="shippingOrderId" value="${c.shippingOrderId}"/>
    <input type="hidden" name="subid" value="${subid}"/>

    <div id="menubar">
        <div id="middleMenubar">
            <div id="innerMenubar">
                <div id="navMenubar">
                    <ul>
                        <li id="save"><a href="#" onclick="formSubmit('shippingOrderAction_update','_self')">确定</a></li>
                        <li id="print"><a href="#">打印</a></li>

                        <li id="back">
                            <a href="#" onclick="history.go(-1);">返回</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="textbox" id="centerTextbox">

        <div class="textbox-header">
            <div class="textbox-inner-header">
                <div class="textbox-title">
                    修改委托书
                    <span class="textbox-note">
		<input type="radio" name="orderType" value="0" ${c.orderType==0?'checked':''} class="input">海运
		<input type="radio" name="orderType" value="1" ${c.orderType==1?'checked':''} class="input">空运
		</span>
                </div>
            </div>
        </div>
        <div>

            <div>
                <table class="commonTable" cellspacing="1">
                    <tr>
                        <td class="columnTitle">货主：</td>
                        <td colspan="5">
	            	<textarea id="textarea_shipper" name="shipper" dataType="字符串" dispName="货主" maxLength="200"
                              onkeyup="getMaxlength('textarea_shipper');textareasize(this);"
                              onmousemove="getMaxlength('textarea_shipper');"
                              onmouseout="getMaxlength('textarea_shipper');" class="textarea" rows="5">${c.shipper}</textarea>
                            <div class="textarea_count">
                                <span>字符：<a id="num_textarea_shipper"><font color=#009900><script>getNownum('textarea_shipper')</script> / <script>getMaxnum('textarea_shipper')</script></font></a></span>
                                |
                                <a style="cursor:pointer;" onclick="clearcontent('textarea_shipper')">清空内容</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="columnTitle">提单抬头：</td>
                        <td colspan="5">
	            	<textarea id="textarea_consignee" name="consignee" dataType="字符串" dispName="提单抬头" maxLength="200"
                              rows="5" onkeyup="getMaxlength('textarea_consignee');textareasize(this);"
                              onmousemove="getMaxlength('textarea_consignee');"
                              onmouseout="getMaxlength('textarea_consignee');" class="textarea" type="_moz">${c.consignee}</textarea>
                            <div class="textarea_count">
                                <span>字符：<a id="num_textarea_consignee"><font color=#009900><script>getNownum('textarea_consignee')</script> / <script>getMaxnum('textarea_consignee')</script></font></a></span>
                                |
                                <a style="cursor:pointer;" onclick="clearcontent('textarea_consignee')">清空内容</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="columnTitle" nowrap>正本通知人：</td>
                        <td colspan="5">
	            	<textarea id="textarea_notifyParty" name="notifyParty" dataType="字符串" dispName="正本通知人"
                              maxLength="200" rows="5"
                              onkeyup="getMaxlength('textarea_notifyParty');textareasize(this);"
                              onmousemove="getMaxlength('textarea_notifyParty');"
                              onmouseout="getMaxlength('textarea_notifyParty');" class="textarea" type="_moz">${c.notifyParty}</textarea>
                            <div class="textarea_count">
                                <span>字符：<a id="num_textarea_notifyParty"><font color=#009900><script>getNownum('textarea_notifyParty')</script> / <script>getMaxnum('textarea_notifyParty')</script></font></a></span>
                                |
                                <a style="cursor:pointer;" onclick="clearcontent('textarea_notifyParty')">清空内容</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="columnTitle">信用证：</td>
                        <td class="tableContent"><input type="text" name="lcNo" value="${c.lcNo}" dataType="字符串"
                                                        dispName="信用证"
                                                        maxLength="30"></td>
                        <td class="columnTitle"><span style="white-space:nowrap">转船港：</span></td>
                        <td class="tableContent"><input type="text" name="portOfTrans" value="${c.portOfTrans}"
                                                        dataType="字符串"
                                                        dispName="转船港" maxLength="30"></td>
                        <td class="columnTitle"><span style="white-space:nowrap">卸货港：</span></td>
                        <td class="tableContent"><input type="text" name="portOfDischarge" value="${c.portOfDischarge}"
                                                        dataType="字符串"
                                                        dispName="卸货港" maxLength="30"></td>
                    </tr>
                    <tr>
                        <td class="columnTitle"><span style="white-space:nowrap">装船港：</span></td>
                        <td class="tableContent"><input type="text" name="portOfLoading" value="${c.portOfLoading}"
                                                        dataType="字符串"
                                                        dispName="装船港" maxLength="30"></td>
                        <td class="columnTitle">装期：</td>
                        <td class="tableContent">
                            <input type="text" style="width:90px;" name="loadingDate" dataType="日期" dispName="装期"
                                   value="<fmt:formatDate value='${c.loadingDate}' pattern='yyyy-MM-dd'></fmt:formatDate>"
                                   onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/>
                        </td>
                        <td class="columnTitle">效期：</td>
                        <td class="tableContent">
                            <input type="text" style="width:90px;" name="limitDate" dataType="日期" dispName="效期"
                                   value="<fmt:formatDate value='${c.limitDate}' pattern='yyyy-MM-dd'></fmt:formatDate>"
                                   onclick="WdatePicker({el:this,isShowOthers:true,dateFmt:'yyyy-MM-dd'});"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="columnTitle"><span style="white-space:nowrap">运费：</span></td>
                        <td class="tableContent"><input type="text" name="freight" value="${c.freight}" dataType="字符串"
                                                        dispName="运费"
                                                        maxLength="200"></td>
                        <td class="tableContent" colspan="4">
                            &nbsp;
                            <input type="checkbox" name="isBatch" value="1" ${c.isBatch==1?'checked':''} class="input"
                                   style="width:20px;"/>分批
                            <input type="checkbox" name="isTrans" value="1" ${c.isTrans==1?'checked':''} class="input"
                                   style="width:20px;"/>转船
                            &nbsp;&nbsp;份数：<input type="text" name="copyNum" value="${c.copyNum}" dataType="字符串"
                                                  dispName="份数"
                                                  maxLength="20" style="width:60px;">
                        </td>
                    </tr>
                    <tr>
                        <td class="columnTitle">运输要求：</td>
                        <td colspan="5">
                            <textarea id="specialCondition" name="specialCondition" rows="1" dataType="字符串"
                                      dispName="运输要求" maxLength="200"
                                      onkeyup="getMaxlength('specialCondition');textareasize(this);"
                                      onmousemove="getMaxlength('specialCondition');"
                                      onmouseout="getMaxlength('specialCondition');" class="textarea"
                                      type="_moz">${c.specialCondition}</textarea>
                            <div class="textarea_count">
                                <span>字符：<a id="num_specialCondition"><font color=#009900><script>getNownum('specialCondition')</script> / <script>getMaxnum('specialCondition')</script></font></a></span>
                                |
                                <a style="cursor:pointer;" onclick="clearcontent('specialCondition')">清空内容</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="columnTitle">复核：</td>
                        <td class="tableContent"><input type="text" name="checkBy" value="${c.checkBy}" dataType="字符串"
                                                        dispName="复核"
                                                        maxLength="30"></td>
                    </tr>
                </table>
            </div>
        </div>

    </div>
</form>
</body>
</html>


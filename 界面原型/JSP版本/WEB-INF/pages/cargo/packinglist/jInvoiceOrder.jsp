<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../baselist.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;" charset="utf-8">
    <title></title>
    <link rel="stylesheet" rev="stylesheet" type="text/css" href="${ctx}/skin/default/css/default.css" media="all"/>
    <script type="text/javascript" src="${ctx}/js/datepicker/WdatePicker.js"></script>

    <script language="JavaScript">
        function preSubmit(serviceName) {
            if (serviceName == "返回") {
                return true;
            } else if (serviceName == "确定") {
                return _CheckAll(true, serviceName);
            }
        }
    </script>
</head>

<body>
<form method="post">
    <input type="hidden" name="invoiceId" value="${c.invoiceId}"/>
    <input type="hidden" name="subid" value="${subid}"/>

    <div id="menubar">
        <div id="middleMenubar">
            <div id="innerMenubar">
                <div id="navMenubar">
                    <ul>
                        <li id="save"><a href="#" onclick="formSubmit('invoiceAction_update','_self')">确定</a></li>
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
                    修改发票
                    &nbsp;&nbsp;&nbsp;

                </div>
            </div>
        </div>
        <div>

            <div>
                <table class="commonTable" cellspacing="1">
                    <tr>
                        <td class="columnTitle">B/L No.：</td>
                        <td class="tableContent"><input type="text" name="blNo" value="${c.blNo}" dataType="字符串"
                                                        dispName="B/L No." maxLength="30"></td>
                    </tr>
                    <tr>
                        <td class="columnTitle" nowrap>贸易条款：</td>
                        <td class="tableContent"><input type="text" name="tradeTerms" value="${c.tradeTerms}" dataType="字符串"
                                                        dispName="贸易条款" maxLength="30"></td>
                    </tr>
                </table>
            </div>
        </div>

    </div>
</form>
</body>
</html>


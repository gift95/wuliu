<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="../../baselist.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script type="text/javascript" src="../../components/jquery-ui/jquery-1.2.6.js"></script>
    <script type="text/javascript" src="../../js/datepicker/WdatePicker.js"></script>
    <script type="text/javascript">
        //动态设置生产厂家的名称
        function setFactoryName(val) {
            document.getElementById("factoryName").value = val;
        }

        function changePage(curPage) {
            var ps = document.getElementById("ps").value;
            location.href = "/${pb.url}?curPage=" + curPage + "&pageSize=" + ps + "&id=${contractId}";
        }

        function changeSize() {
            var cp = document.getElementById("cp").value;
            var ps = document.getElementById("ps").value;
            location.href = "/${pb.url}?curPage=" + cp + "&pageSize=" + ps + "&id=${contractId}";
        }
    </script>
</head>

<body>
<form name="icform" method="post">
    <input type="hidden" name="contractId" value="${contractId}"/>
    <input type="hidden" name="id" value="${contractId}"/>
    <div id="menubar">
        <div id="middleMenubar">
            <div id="innerMenubar">
                <div id="navMenubar">
                    <ul>
                        <li id="save"><a href="#"
                                         onclick="formSubmit('contractProductAction_insert','_self');this.blur();">保存</a>
                        </li>
                        <li id="back"><a href="#" onclick="history.go(-1);">返回</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="textbox-title">
        <img src="${ctx }/skin/default/images/icon/currency_yen.png"/>
        新增货物
    </div>


    <div>
        <table class="commonTable" cellspacing="1">
            <tr>
                <td class="columnTitle">生产厂家：</td>
                <td class="tableContent">
                    <select id="factoryId" name="factoryId"
                            onchange="$('#factoryName').val($(this).find('option:selected').text())">
                        <option value="">--请选择--</option>
                        <c:if test="${! empty fs}">
                            <c:forEach items="${fs}" var="f">
                                <option value="${f.factoryId}">${f.factoryName}</option>
                            </c:forEach>
                        </c:if>
                    </select>

                    <input type="hidden" id="factoryName" name="factoryName" value=""/>
                </td>
                <td class="columnTitle">货号：</td>
                <td class="tableContentAuto"><input type="text" name="productNo" value=""/></td>
            </tr>
            <tr>
                <td class="columnTitle">货物照片：</td>
                <td class="tableContent"><input type="text" name="productImage" value=""/></td>
            </tr>
            <tr>
                <td class="columnTitle">数量：</td>
                <td class="tableContent"><input type="text" name="cnumber" value=""/></td>
                <td class="columnTitle">包装单位：</td>
                <td class="tableContentAuto">
                    <input type="radio" name="packingUnit" value="PCS" class="input">只
                    <input type="radio" name="packingUnit" value="SETS" class="input">套
                </td>
            </tr>
            <tr>
                <td class="columnTitle">装率：</td>
                <td class="tableContent"><input type="text" name="loadingRate" value=""/></td>
                <td class="columnTitle">箱数：</td>
                <td class="tableContent"><input type="text" name="boxNum" value=""/></td>
            </tr>
            <tr>
                <td class="columnTitle">单价：</td>
                <td class="tableContent"><input type="text" name="price" value=""/></td>
                <td class="columnTitle">排序号：</td>
                <td class="tableContent"><input type="text" name="orderNo" value=""/></td>
            </tr>
            <tr>
                <td class="columnTitle">货物描述：</td>
                <td class="tableContent"><textarea name="productDesc" style="height:150px;"></textarea>
                <td class="columnTitle">要求：</td>
                <td class="tableContent"><textarea name="productRequest" style="height:150px;"></textarea>
            </tr>
        </table>
    </div>


    <div class="textbox-title">
        <img src="${ctx }/skin/default/images/icon/currency_yen.png"/>
        货物列表
    </div>


    <div class="eXtremeTable">
        <table id="ec_table" class="tableRegion" width="98%">
            <thead>
            <tr>
                <td class="tableHeader"><input type="checkbox" name="selid" onclick="checkAll('id',this)"></td>
                <td class="tableHeader">序号</td>
                <td class="tableHeader">厂家</td>
                <td class="tableHeader">货号</td>
                <td class="tableHeader">装率</td>
                <td class="tableHeader">箱数</td>
                <td class="tableHeader">包装单位</td>
                <td class="tableHeader">数量</td>
                <td class="tableHeader">单价</td>
                <td class="tableHeader">总金额</td>
                <td class="tableHeader">操作</td>
            </tr>
            </thead>
            <tbody class="tableBody">

            <input id="cp" name="curPage" type="hidden" value="${pb.curPage}">
            <tr style="padding: 0px;">
                <td colspan="15">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td class="statusBar">找到${pb.totalRows}条记录, 显示 ${(pb.curPage-1)*pb.pageSize+1}
                                到 ${pb.curPage*pb.pageSize>pb.totalRows?pb.totalRows:pb.curPage*pb.pageSize}</td>
                            <td class="compactToolbar" align="right">
                                <table border="0" cellpadding="1" cellspacing="2">
                                    <tr>
                                        <td><a href="javascript:changePage(1)">[第一页]</a></td>
                                        <td><a href="javascript:changePage(${pb.curPage-1<=0?1:pb.curPage-1})">[上一页]</a>
                                        </td>
                                        <td>
                                            <a href="javascript:changePage(${pb.curPage+1>=pb.totalPages?pb.totalPages:pb.curPage+1})">[下一页]</a>
                                        </td>
                                        <td><a href="javascript:changePage(${pb.totalPages})">[最后一页]</a></td>
                                        <td><img src="/images/table/separator.gif" style="border:0" alt="Separator"/>
                                        </td>
                                        <td><select id="ps" name="pageSize" onchange="changeSize()">
                                            <option value="10" ${pb.pageSize==10?'selected':''}>10</option>
                                            <option value="50"  ${pb.pageSize==50?'selected':''}>50</option>
                                            <option value="100"  ${pb.pageSize==100?'selected':''}>100</option>
                                        </select></td>
                                        <td><img src="/images/table/separator.gif" style="border:0" alt="Separator"/>
                                        </td>
                                        <td>
                                            <a href="javascript:document.forms.form2.ec_eti.value='ec';document.forms.form2.ec_ev.value='xls';document.forms.form2.ec_efn.value='deptList.xls';document.forms.form2.setAttribute('action', 'deptListAction.do');document.forms.form2.setAttribute('method', 'post');document.forms.form2.submit()"><img
                                                    src="/images/table/xls.gif" style="border:0" title="Export Excel"
                                                    alt="Excel"/></a></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <c:forEach items="${pb.datas}" var="o" varStatus="status">
                <tr class="odd" onmouseover="this.className='highlight'" onmouseout="this.className='odd'">
                    <td><input type="checkbox" name="id" value="${o.contractProductId}"/></td>
                    <td>${status.index+1}</td>
                    <td>${o.factoryName}</td>
                    <td>${o.productNo}</td>
                    <td>${o.loadingRate}</td>
                    <td>${o.boxNum}</td>
                    <td>${o.packingUnit}</td>
                    <td>${o.cnumber}</td>
                    <td>${o.price}</td>
                    <td>${o.amount}</td>
                    <td>
                        <a href="contractProductAction_toupdate?id=${o.contractProductId}">[修改]</a>
                        <a href="contractProductAction_delete?id=${o.contractProductId}&cid=${o.contractId}">[删除]</a>
                        <a href="extCproductAction_tocreate?cid=${o.contractId}&cpid=${o.contractProductId}">[附件]</a>
                    </td>
                </tr>

                <c:forEach items="${o.extCproductCs}" var="ext" varStatus="status">
                    <tr height="40" class="odd" onmouseover="this.className='highlight'"
                        onmouseout="this.className='odd'">
                        <td>&nbsp;</td>
                        <td align="right"><font color="blue">附件：${status.index+1}&nbsp;</font></td>
                        <td>${ext.factoryName}</td>
                        <td>${ext.productNo}</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>${ext.packingUnit}</td>
                        <td>${ext.cnumber}</td>
                        <td>${ext.price}</td>
                        <td>${ext.amount}</td>
                    </tr>
                </c:forEach>

            </c:forEach>

            </tbody>
        </table>
    </div>

</form>
</body>
</html>


<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<script>
    function changePage(curPage){
        var ps = document.getElementById("ps").value;
        location.href="/dept/list?curPage="+curPage+"&pageSize="+ps;
    }
    function changeSize(){
        var cp = document.getElementById("cp").value;
        var ps = document.getElementById("ps").value;
        location.href="/dept/list?curPage="+cp+"&pageSize="+ps;
    }
</script>
<input id="cp" name="curPage" type="hidden" value="${pb.curPage}">
<tr style="padding: 0px;">
    <td colspan="15">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="statusBar">找到${pb.totalRows}条记录, 显示 ${(pb.curPage-1)*pb.pageSize+1} 到 ${pb.curPage*pb.pageSize>pb.totalRows?pb.totalRows:pb.curPage*pb.pageSize}</td>
                <td class="compactToolbar" align="right">
                    <table border="0" cellpadding="1" cellspacing="2">
                        <tr>
                            <td><a href="javascript:changePage(1)">[第一页]</a></td>
                            <td><a href="javascript:changePage(${pb.curPage-1<=0?1:pb.curPage-1})">[上一页]</a></td>
                            <td><a  href="javascript:changePage(${pb.curPage+1>=pb.totalPages?pb.totalPages:pb.curPage+1})">[下一页]</a></td>
                            <td><a  href="javascript:changePage(${pb.totalPages})">[最后一页]</a></td>
                            <td><img src="/images/table/separator.gif" style="border:0" alt="Separator"/></td>
                            <td><select id="ps" name="pageSize" onchange="changeSize()">
                                <option value="10" ${pb.pageSize==10?'selected':''}>10</option>
                                <option value="50"  ${pb.pageSize==50?'selected':''}>50</option>
                                <option value="100"  ${pb.pageSize==100?'selected':''}>100</option>
                            </select></td>
                            <td><img src="/images/table/separator.gif" style="border:0" alt="Separator"/></td>
                            <td>
                                <a href="/dept/export"><img
                                        src="/images/table/xls.gif" style="border:0" title="Export Excel"
                                        alt="Excel"/></a></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </td>
</tr>
package cn.yunhe.pojo;

import java.util.List;

/**
 * 封装查询分页的信息
 */
public class PageBean {
    //展示的数据
    private List<?> datas;

    //总共多少条
    private Long totalRows;

    //当前页
    private Integer curPage=1;

    //每页多少条数据(分页单位)
    private Integer pageSize=10;

    //总共多少页(总页数)
    private Integer totalPages;

    public List<?> getDatas() {
        return datas;
    }

    public void setDatas(List<?> datas) {
        this.datas = datas;
    }

    public Long getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(Long totalRows) {
        this.totalRows = totalRows;
    }

    public Integer getCurPage() {
        return curPage;
    }

    public void setCurPage(Integer curPage) {
        this.curPage = curPage;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }
}

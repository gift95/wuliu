package cn.yunhe.controller;

import cn.yunhe.pojo.DeptP;
import cn.yunhe.pojo.DeptPVo;
import cn.yunhe.pojo.PageBean;
import cn.yunhe.service.DeptService;
import cn.yunhe.uitls.ExportExcelUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping("/dept")
public class DeptController {
    @Autowired
    private DeptService deptService;
    /**
     * 查询并分页展示
     * @param model
     * @param pageBean
     * @return
     */
    @RequestMapping("/list")
    public String list(Model model, PageBean pageBean){
        PageBean pb = deptService.listDeptOfPage(pageBean);
        model.addAttribute("pb",pb);
        return "sysadmin/dept/jDeptList";
    }

    /**
     * 跳转新增页面
     * @param model
     * @return
     */
    @RequestMapping("/tocreate")
    public String tocreate(Model model) throws Exception {
       List<DeptP> ds =    deptService.listDept();
       model.addAttribute("ds",ds);
       return "sysadmin/dept/jDeptCreate";
    }

    @RequestMapping("/insert")
    public String insert(DeptP deptP)  throws Exception {
        deptService.createDept(deptP);
        return "redirect:/dept/list";
    }

    /**
     * 导出excel
     * @param pageBean
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/export")
    public void export(PageBean pageBean, HttpServletRequest request, HttpServletResponse response)  throws Exception {
        //查询需要导出的数据
        PageBean pb = deptService.listDeptOfPage(pageBean);
        List<DeptPVo> datas = (List<DeptPVo>)pb.getDatas();//获取分页的数据
        //获取模板存放的位置
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String filePath = "/tpl/dept_export.xlsx";
        //构建工作薄(WorkBook)，工作表(Sheet),单元格(Cell)
        ExportExcelUtil  excelUtil = new ExportExcelUtil();
        File file = excelUtil.getExcelTplFile(realPath,filePath);
        Workbook workbook = excelUtil.getWorkbook(file);//获取工作薄
        Sheet sheet = excelUtil.getSheet(workbook,"部门信息");//获取工作表(Sheet)
        //遍历数据
        for(DeptPVo d:datas){
           Row row = excelUtil.createRow(sheet);//在工作表中创建行
           Cell cell0 =excelUtil.createCell(row,0);
           cell0.setCellValue(d.getDeptNo());
           Cell cell1 =excelUtil.createCell(row,1);
            cell1.setCellValue(d.getParentName());
            Cell cell2 =excelUtil.createCell(row,2);
            cell2.setCellValue(d.getDeptName());
            Cell cell3 =excelUtil.createCell(row,3);
            String state = d.getState()==1?"启用":"禁用";
            cell3.setCellValue(state);
        }
        //把写好的excel发送到客户端
        String fileName="dept_list.xlsx";
        response.setContentType("application/ms-excel");
        response.setHeader("Content-disposition", "attachment;filename="+fileName);
        ServletOutputStream ouputStream = response.getOutputStream();
        workbook.write(ouputStream);
        ouputStream.flush();
        ouputStream.close();

    }


}

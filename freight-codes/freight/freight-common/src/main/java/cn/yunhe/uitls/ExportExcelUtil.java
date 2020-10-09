package cn.yunhe.uitls;
import org.apache.poi.ss.usermodel.*;
import java.io.File;
import java.io.FileInputStream;

public class ExportExcelUtil {
	private CellStyle cs;
	/**
	 * 描述：根据文件路径获取项目中的文件
	 * @return
	 * @throws Exception
	 */
	public File getExcelTplFile(String filePath, String fileName) throws Exception {
		String classDir = null;
		String fileBaseDir = null;
		File file = null;
		/*classDir = Thread.currentThread().getContextClassLoader()
				.getResource("").getPath();
		System.out.println(classDir);
		fileBaseDir = classDir.substring(1, classDir.lastIndexOf("classes")).replaceAll("%20", " ");*/
		file = new File(filePath+fileName);
		if (!file.exists()) {
			throw new Exception("模板文件不存在！");
		}
		return file;
	}
	/**
	 * 创建工作簿
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public Workbook getWorkbook(File file) throws Exception {
		FileInputStream fis = new FileInputStream(file);
		Workbook wb = new ImportExcelUtil().getWorkbook(fis, file.getName()); // 获取工作薄
		return wb;
	}

	/**
	 * 创建Sheet
	 * @param wb
	 * @param sheetName
	 * @return
	 * @throws Exception
	 */
	public Sheet getSheet(Workbook wb, String sheetName) throws Exception {
		cs = setSimpleCellStyle(wb); // Excel单元格样式
		Sheet sheet = wb.getSheet(sheetName);
		return sheet;
	}

	/**
	 * 创建Row
	 * @param sheet
	 * @return
	 * @throws Exception
	 */
	public Row createRow(Sheet sheet) throws Exception {
		// 循环插入数据
		int lastRow = sheet.getLastRowNum() + 1; // 插入数据的数据ROW
		Row row = sheet.createRow(lastRow);
		return row;
	}
	/**
	 * 创建Cell
	 * @param row
	 * @param CellNum
	 * @return
	 * @throws Exception
	 */
	public Cell createCell(Row row, int CellNum) throws Exception {
		Cell cell = row.createCell(CellNum);
		cell.setCellStyle(cs);
		return cell;
	}

	/**
	 * 描述：设置简单的Cell样式
	 * 
	 * @return
	 */
	public CellStyle setSimpleCellStyle(Workbook wb) {
		CellStyle cs = wb.createCellStyle();

		cs.setBorderBottom(CellStyle.BORDER_THIN); // 下边框
		cs.setBorderLeft(CellStyle.BORDER_THIN);// 左边框
		cs.setBorderTop(CellStyle.BORDER_THIN);// 上边框
		cs.setBorderRight(CellStyle.BORDER_THIN);// 右边框

		cs.setAlignment(CellStyle.ALIGN_CENTER); // 居中

		return cs;
	}

}

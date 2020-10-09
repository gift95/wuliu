# 1.  购销合同管理

## 1.1   新增

### 1.1.1  mapper

逆向工程

### 1.1.2  service

```java
@Service
public class ContractServiceImpl implements ContractService {
    @Autowired
    private ContractCMapper contractCMapper;
    ....
 	public void createContract(CurrentUser currentUser, ContractC contractC) {
        //获取用户信息和部门信息
        UserP userP =  currentUser.getUserP();//获取用户信息
        DeptP deptP = currentUser.getDeptP(); //获取部门信息
        //补全合同信息
        contractC.setContractId(UUID.randomUUID().toString());
        contractC.setCreateBy(userP.getUserId());
        contractC.setCreateDept(deptP.getDeptId());
        Date now = new Date();
        contractC.setCreateTime(now);
        contractC.setUpdateBy(userP.getUserId());
        contractC.setUpdateTime(now);
        contractC.setState(0);//0:代表草稿 1:已上报
        contractCMapper.insertSelective(contractC);
    }
}

```

### 1.1.3  controller

```java
 /**
     * 跳转新增页面
     * @return
     */
    @RequestMapping("/tocreate")
    public String  tocreate(){
        return "cargo/contract/jContractCreate";
    }

    /**
     * 完成用户新增
     * @return
     */
    @RequestMapping("/create")
    public String  create(ContractC contractC){
        //获取认证的信息
        Subject subject = SecurityUtils.getSubject();
        CurrentUser currentUser = (CurrentUser)subject.getPrincipal();
        contractService.createContract(currentUser,contractC);
        return "redirect:/contract/list";
    }

```

## 1.2   上报

修改合同状态为1

### 1.2.1  service

```java
public void submitContractCByContractId(CurrentUser currentUser,String contractId) {
        UserP userP =  currentUser.getUserP();
        ContractC contractC =  new ContractC();//封装需要修改的数据
        contractC.setContractId(contractId);
        contractC.setState(1);//0:草稿  1:已上报
        contractC.setUpdateBy(userP.getUserId());
        contractC.setUpdateTime(new Date());
        contractCMapper.updateByPrimaryKeySelective(contractC);
    }

```

 

### 1.2.2  controller

```java
  @RequestMapping("/submit")
    public String submit(String contractId)  {
        //获取认证的信息
        Subject subject = SecurityUtils.getSubject();
        CurrentUser currentUser = (CurrentUser)subject.getPrincipal();
        contractService.submitContractCByContractId(currentUser,contractId);
        return "redirect:/contract/list";
    }

```

 

### 1.2.3  jsp

修改jContractList.jsp

```java


 <jsp:include page="../../page.jsp"></jsp:include>
                    <c:forEach items="${pb.datas}" var="o" varStatus="status">
                        <tr class="odd" onmouseover="this.className='highlight'" onmouseout="this.className='odd'">
                            <td><input type="checkbox" name="contractId" value="${o.contractId}"/></td>

```

## 1.3   取消

注意：只能取消状态是1的合同

## 1.4   删除

作业

## 1.5   修改

作业

## 1.6   查看

购销合同明细要展示的内容：

n 合同信息

u 合同的货物列表

Ø 货物的附件列表

### 1.6.1  pojo

```java
public class ContractCVo extends ContractC{
    private Integer contractProductNum;
    private Integer extCproductNum;

    private List<ContractProductCVo> extCproductCList;
    ... ...
}

```

 

```java
public class ContractProductCVo extends ContractProductC{
    //附件
    private List<ExtCproductC> extCproductCList;
    ... ...
}

```

 

### 1.6.2  mapper

修改ContractCMapper.xml

```xml
<!--查看合同明细-->
<resultMap id="viewContractCByContractIdResultMap" type="cn.yunhe.pojo.ContractCVo" >
  <id column="CONTRACT_ID" property="contractId" jdbcType="VARCHAR" />
  <result column="OFFEROR" property="offeror" jdbcType="VARCHAR" />
  <result column="CONTRACT_NO" property="contractNo" jdbcType="VARCHAR" />
  <result column="SIGNING_DATE" property="signingDate" jdbcType="TIMESTAMP" />
  <result column="INPUT_BY" property="inputBy" jdbcType="VARCHAR" />
  <result column="CHECK_BY" property="checkBy" jdbcType="VARCHAR" />
  <result column="INSPECTOR" property="inspector" jdbcType="VARCHAR" />
  <result column="TOTAL_AMOUNT" property="totalAmount" jdbcType="DECIMAL" />
  <result column="CREQUEST" property="crequest" jdbcType="VARCHAR" />
  <result column="CUSTOM_NAME" property="customName" jdbcType="VARCHAR" />
  <result column="SHIP_TIME" property="shipTime" jdbcType="TIMESTAMP" />
  <result column="IMPORT_NUM" property="importNum" jdbcType="INTEGER" />
  <result column="DELIVERY_PERIOD" property="deliveryPeriod" jdbcType="TIMESTAMP" />
  <result column="OLD_STATE" property="oldState" jdbcType="INTEGER" />
  <result column="OUT_STATE" property="outState" jdbcType="INTEGER" />
  <result column="TRADE_TERMS" property="tradeTerms" jdbcType="VARCHAR" />
  <result column="PRINT_STYLE" property="printStyle" jdbcType="CHAR" />
  <result column="REMARK" property="remark" jdbcType="VARCHAR" />
  <result column="STATE" property="state" jdbcType="INTEGER" />
  <result column="CREATE_BY" property="createBy" jdbcType="VARCHAR" />
  <result column="CREATE_DEPT" property="createDept" jdbcType="VARCHAR" />
  <result column="CREATE_TIME" property="createTime" jdbcType="TIMESTAMP" />
  <result column="UPDATE_BY" property="updateBy" jdbcType="VARCHAR" />
  <result column="UPDATE_TIME" property="updateTime" jdbcType="TIMESTAMP" />
  <collection property="extCproductCList" ofType="cn.yunhe.pojo.ContractProductCVo">
    <id column="CONTRACT_PRODUCT_ID" property="contractProductId" jdbcType="VARCHAR" />
    <result column="CONTRACT_ID" property="contractId" jdbcType="VARCHAR" />
    <result column="FACTORY_ID" property="factoryId" jdbcType="VARCHAR" />
    <result column="FACTORY_NAME" property="factoryName" jdbcType="VARCHAR" />
    <result column="PRODUCT_NO" property="productNo" jdbcType="VARCHAR" />
    <result column="PRODUCT_IMAGE" property="productImage" jdbcType="VARCHAR" />
    <result column="PRODUCT_DESC" property="productDesc" jdbcType="VARCHAR" />
    <result column="LOADING_RATE" property="loadingRate" jdbcType="VARCHAR" />
    <result column="BOX_NUM" property="boxNum" jdbcType="INTEGER" />
    <result column="PACKING_UNIT" property="packingUnit" jdbcType="VARCHAR" />
    <result column="CNUMBER" property="cnumber" jdbcType="INTEGER" />
    <result column="OUT_NUMBER" property="outNumber" jdbcType="INTEGER" />
    <result column="FINISHED" property="finished" jdbcType="INTEGER" />
    <result column="PRODUCT_REQUEST" property="productRequest" jdbcType="VARCHAR" />
    <result column="PRICE" property="price" jdbcType="DECIMAL" />
    <result column="AMOUNT" property="amount" jdbcType="DECIMAL" />
    <result column="ORDER_NO" property="orderNo" jdbcType="INTEGER" />
    <collection property="extCproductCList" ofType="cn.yunhe.pojo.ExtCproductC">
      <id column="extCproductId" property="extCproductId" jdbcType="VARCHAR" />
      <result column="factoryName" property="factoryName" jdbcType="VARCHAR" />
      <result column="productNo" property="productNo" jdbcType="VARCHAR" />
      <result column="packingUnit" property="packingUnit" jdbcType="VARCHAR" />
      <result column="ecnumber" property="cnumber" jdbcType="INTEGER" />
      <result column="eprice" property="price" jdbcType="DECIMAL" />
      <result column="eamount" property="amount" jdbcType="DECIMAL" />
    </collection>
  </collection>
</resultMap>
<select id="viewContractCByContractId" parameterType="String" resultMap="viewContractCByContractIdResultMap">
    SELECT
        cc.*, cpc.*,
        ecc.EXT_CPRODUCT_ID extCproductId,
        ecc.FACTORY_NAME factoryName,
        ecc.PRODUCT_NO productNo,
        ecc.PACKING_UNIT packingUnit,
        ecc.CNUMBER ecnumber,
        ecc.PRICE eprice,
        ecc.AMOUNT eamount
    FROM
        contract_c cc
    LEFT JOIN contract_product_c cpc ON cc.contract_id = cpc.contract_id
    LEFT JOIN ext_cproduct_c ecc ON cpc.CONTRACT_PRODUCT_ID = ecc.CONTRACT_PRODUCT_ID
    WHERE
        cpc.CONTRACT_ID = #{contractId}
</select>

```

修改ContractCMapper

```
ContractCVo viewContractCByContractId(String contractId);
```

### 1.6.3  service

```java
//查看合同明细
@Override
public ContractCVo viewContractCByContractId(String contractId) throws Exception {
    return contractCMapper.viewContractCByContractId(contractId);
}

```

### 1.6.4  controller

```java
@RequestMapping("/toview")
public String toview(String contractId,Model model) throws Exception {
    ContractCVo contractCVo = contractService.viewContractCByContractId(contractId);
    model.addAttribute("contractCVo",contractCVo);
    return "cargo/contract/jContractView";
}

```

### 1.6.5  jsp

修改jContractList.jsp

```java
function toview(){
    if(isOnlyChecked()){
        formSubmit('${ctx}/contract/toview','_self');
    }else{
        alert("请先选择一项并且只能选择一项，再进行操作！");
    }
}
... ...
<li id="view"><a href="#" onclick="toview();this.blur();">查看</a></li>

```

# 2. 货物管理

## 2.1   跳转添加货物页面

跳转添加货物页面时要查询当前合同所拥有的货物，以及货物所拥有的附件

### 2.1.1  pojo

```
public class ContractProductCVo extends ContractProductC{

    private List<ExtCproductC> extCproductCList;
    ... ...
}

```

 

### 2.1.2  mapper

修改ContractProductCMapper.xml

```xml
<resultMap id="listContractProductCOfPageResultMap" type="cn.yunhe.pojo.ContractProductCVo" >
  <id column="CONTRACT_PRODUCT_ID" property="contractProductId" jdbcType="VARCHAR" />
  <result column="CONTRACT_ID" property="contractId" jdbcType="VARCHAR" />
  <result column="FACTORY_ID" property="factoryId" jdbcType="VARCHAR" />
  <result column="FACTORY_NAME" property="factoryName" jdbcType="VARCHAR" />
  <result column="PRODUCT_NO" property="productNo" jdbcType="VARCHAR" />
  <result column="PRODUCT_IMAGE" property="productImage" jdbcType="VARCHAR" />
  <result column="PRODUCT_DESC" property="productDesc" jdbcType="VARCHAR" />
  <result column="LOADING_RATE" property="loadingRate" jdbcType="VARCHAR" />
  <result column="BOX_NUM" property="boxNum" jdbcType="INTEGER" />
  <result column="PACKING_UNIT" property="packingUnit" jdbcType="VARCHAR" />
  <result column="CNUMBER" property="cnumber" jdbcType="INTEGER" />
  <result column="OUT_NUMBER" property="outNumber" jdbcType="INTEGER" />
  <result column="FINISHED" property="finished" jdbcType="INTEGER" />
  <result column="PRODUCT_REQUEST" property="productRequest" jdbcType="VARCHAR" />
  <result column="PRICE" property="price" jdbcType="DECIMAL" />
  <result column="AMOUNT" property="amount" jdbcType="DECIMAL" />
  <result column="ORDER_NO" property="orderNo" jdbcType="INTEGER" />
  <collection property="extCproductCList" ofType="cn.yunhe.pojo.ExtCproductC">
    <id column="extCproductId" property="extCproductId" jdbcType="VARCHAR" />
    <result column="factoryName" property="factoryName" jdbcType="VARCHAR" />
    <result column="productNo" property="productNo" jdbcType="VARCHAR" />
    <result column="packingUnit" property="packingUnit" jdbcType="VARCHAR" />
    <result column="ecnumber" property="cnumber" jdbcType="INTEGER" />
    <result column="eprice" property="price" jdbcType="DECIMAL" />
    <result column="eamount" property="amount" jdbcType="DECIMAL" />
  </collection>
</resultMap>
<select id="listContractProductCOfPage" parameterType="String" resultMap="listContractProductCOfPageResultMap">
    SELECT
        cpc.*,
        ecc.EXT_CPRODUCT_ID extCproductId,
        ecc.FACTORY_NAME factoryName,
        ecc.PRODUCT_NO productNo,
        ecc.PACKING_UNIT packingUnit,
        ecc.CNUMBER ecnumber,
        ecc.PRICE eprice,
        ecc.AMOUNT eamount
    FROM
        contract_product_c cpc
    LEFT JOIN ext_cproduct_c ecc on cpc.CONTRACT_PRODUCT_ID=ecc.CONTRACT_PRODUCT_ID
    where cpc.CONTRACT_ID=#{contractId}
</select>

```

 

修改ContractProductCMapper

```
List<ContractProductCVo> listContractProductCOfPage(String contractId);
```

 

### 2.1.3  service

创建ContractProductServiceImpl

```java
@Service("contractProductServiceImpl")
public class ContractProductServiceImpl implements ContractProductService{

    @Autowired
    private ContractProductCMapper contractProductCMapper;

    @Override
    public PageBean listContractProductOfPage(PageBean pageBean, String contractId) throws Exception {
        //设置查询条件
        PageHelper.startPage(pageBean.getCurPage(),pageBean.getPageSize());
        List<ContractProductCVo> contractProductCVoList = 
                                                    contractProductCMapper.listContractProductCOfPage(contractId);

        //获取分页信息
        PageInfo<ContractProductCVo> pageInfo = new PageInfo<ContractProductCVo>(contractProductCVoList);

        pageBean.setTotalPages(pageInfo.getPages());
        pageBean.setDatas(pageInfo.getList());
        pageBean.setTotalRows(pageInfo.getTotal());
        return pageBean;
    }

}

```

 

创建FactoryServiceImpl

```java
@Service
public class FactoryServiceImpl implements FactoryService{

    @Autowired
    private FactoryCMapper factoryCMapper;

    @Override
    public List<FactoryC> listFactoryByType(String type) throws Exception {
        FactoryCExample factoryCExample = new FactoryCExample();
        FactoryCExample.Criteria criteria = factoryCExample.createCriteria();
        criteria.andCtypeEqualTo(type);
        return factoryCMapper.selectByExample(factoryCExample);
    }
}

```

 

### 2.1.4  controller

```java
@Controller
@RequestMapping("/contractProduct")
public class ContractProductController {

    @Autowired
    private ContractProductService contractProductService;

   @RequestMapping("/tocreate")
public String tocreate(PageBean pageBean,String contractId, Model model) throws Exception {
    //查询当前合同的货物列表
    PageBean pb = contractProductService.listContractProductOfPage(pageBean,contractId);
    model.addAttribute("pb",pb);

    //按类别查询厂家下拉数据
    List<FactoryC> factoryCList = factoryService.listFactoryByType("货物");
    model.addAttribute("factoryCList",factoryCList);

    //回显合同主键
    model.addAttribute("contractId",contractId);
    return "cargo/contract/jContractProductCreate";
}

}

```

 

### 2.1.5  jsp

参考jContractProductCreate.jsp

#### 1.1.5.1 货物分页查询问题

![img](../../../ADMINI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image002.jpg)

![img](../../../ADMINI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image004.jpg)

 

## 2.2   添加货物

 

注意：

-  保存货物信息的时候要同时修改合同的总金额

- 合同总金额=所有货物的总价+所有附件的总价

### 2.2.1  mapper

#### 2.2.1.1 计算货物总金额

修改ContractProductCMapper.xml

```xml
<!--计算货物总金额-->
<select id="getTotalAmountByContractId" parameterType="String" resultType="Double">
  select sum(AMOUNT) from CONTRACT_PRODUCT_C where CONTRACT_ID=#{contractId}
</select>

```

 

修改ContractProductCMapper

```java
Double getTotalAmountByContractId(String contractId);
```

#### 2.2.1.2 计算附件总金额

修改ExtCproductCMapper.xml

```xml
<!--计算附件总金额-->
<select id="getTotalAmountByContractId" parameterType="String" resultType="Double">
  select sum(amount) from ext_cproduct_c where contract_product_id in(
   select contract_product_id from contract_product_c where contract_id=#{contractId}
  )
</select>

```

 

修改ExtCproductCMapper

```java
  Double getTotalAmountByContractId(String contractId);  
```



 

### 2.2.2  ArithUtil

ArithUtil：金额计算工具类

```java
package cn.yunhe.utils;

import java.math.BigDecimal;

public class ArithUtil {

    // 不能实例化
    private ArithUtil() {
    }

    /**
     * 加法
     * @param v1
     * @param v2
     * @return
     */
    public static double add(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));// 建议写string类型的参数，下同
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.add(b2).doubleValue();
    }

    /**
     * 减法
     * @param v1
     * @param v2
     * @return
     */
    public static double sub(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.subtract(b2).doubleValue();
    }

    /**
     * 乘法
     * @param v1
     * @param v2
     * @return
     */
    public static double mul(double v1, double v2) {
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.multiply(b2).doubleValue();
    }

    /**
     * 除法
     * @param v1
     * @param v2
     * @param scale
     * @return
     */
    private static double div(double v1, double v2, int scale) {
        if (scale <= 0) {
            throw new IllegalArgumentException(" the scale must be a positive integer or zero");
        }
        BigDecimal b1 = new BigDecimal(Double.toString(v1));
        BigDecimal b2 = new BigDecimal(Double.toString(v2));
        return b1.divide(b2, scale, BigDecimal.ROUND_HALF_UP).doubleValue();// scale 后的四舍五入
    }

}

```

 

### 2.2.3  service

修改ContractProductServiceImpl

```java
@Override
public void createContractProduct(ContractProductC contractProductC) throws Exception {
    contractProductC.setContractProductId(UUID.randomUUID().toString());
    //1、计算货物的总金额
    Double amount = ArithUtil.mul(contractProductC.getCnumber().doubleValue(), 
                                                          contractProductC.getPrice().doubleValue());
    contractProductC.setAmount(new BigDecimal(amount.toString()));
    //2、保存货物信息
    contractProductCMapper.insertSelective(contractProductC);

    //3、修改合同的总金额
    //获取当前登录用户的信息
    Subject subject = SecurityUtils.getSubject();
    CurrentUser currentUser = (CurrentUser) subject.getPrincipal();
    UserP user = currentUser.getUserP();
    //a、查询货物的总金额金额
    Double totalAmount_contractProduct = 
                         contractProductCMapper.getTotalAmountByContractId(contractProductC.getContractId());
    //b、查询附件的总金额金额
    Double totalAmount_extCproduct = 
                              extCproductCMapper.getTotalAmountByContractId(contractProductC.getContractId());
    //c、合同总金额=货物的总金额+附件的总金额
    Double totalAmount = ArithUtil.add(totalAmount_contractProduct, totalAmount_extCproduct);
    
    //d、修改合同的金额
    ContractC contractC = new ContractC();
    contractC.setContractId(contractProductC.getContractId());
    contractC.setTotalAmount(new BigDecimal(totalAmount.toString()));
    contractC.setUpdateBy(user.getUserId());
    contractC.setUpdateTime(new Date());
    contractCMapper.updateByPrimaryKeySelective(contractC);
}

```

 

### 2.2.4  controller

```
@RequestMapping("/create")
public String createContractProduct(ContractProductC contractProductC, Model model) throws Exception {
    contractProductService.createContractProduct(contractProductC);
    return "redirect:/contractProduct/tocreate?contractId="+contractProductC.getContractId();
}

```



## 2.3   修改货物

在货物查询列表中点击修改链接跳转到jContractProductUpdate.jsp页面

![img](../../../ADMINI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image006.jpg)

作业

## 2.4   删除货物

在货物查询列表中点击删除链接删除当前货物

![img](../../../ADMINI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image008.jpg)

作业

# 3.  附件管理

在货物查询列表中点击附件链接跳转到附件管理

![img](../../../ADMINI~1/AppData/Local/Temp/msohtmlclip1/01/clip_image010.jpg)

## 3.1   跳转添加附件页面

参考跳转添加货物页面

## 3.2   添加附件

参考添加货物

注意：

Ø 保存附件信息的时候要同时修改合同的总金额

Ø 合同总金额=所有货物的总价+所有附件的总价

## 3.3   修改附件

作业

## 3.4   删除附件

作业

 
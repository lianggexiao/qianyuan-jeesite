/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.qing.jeesite.modules.im.web;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.DateUtils;
import com.qing.jeesite.common.utils.excel.ImportExcel;
import com.qing.jeesite.common.web.BaseController;
import com.qing.jeesite.modules.im.entity.Keyword;
import com.qing.jeesite.modules.im.service.KeywordService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 搜索关键词统计Controller
 * @author 柳青
 * @version 2019-2-15
 */
@Controller
@RequestMapping(value = "${adminPath}/im/keyword")
public class KeywordController extends BaseController {

	@Autowired
	private KeywordService keywordService;
	
	@ModelAttribute
	public Keyword get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return keywordService.getKeyword(id);
		}else{
			return new Keyword();
		}

	}

	@RequestMapping(value = {"listQuery", ""})
	public String listQuery(Keyword keyword, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Keyword> page = keywordService.findKeywordList(new Page<Keyword>(request, response), keyword);
		model.addAttribute("page", page);
		return "modules/im/keyword/keywordList2";
	}

	@ResponseBody
	@RequestMapping(value = {"listQueryData"})
	public Page<Keyword> listQueryData(Keyword keyword, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Keyword> page = keywordService.findKeywordList(new Page<Keyword>(request, response), keyword);
		return page;
	}


	//正常增删改查的
	@RequestMapping(value = {"list", ""})
	public String list(Keyword keyword, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isAnyBlank(keyword.getGoodsName(),keyword.getShopName())){
			keyword.setShopName(keyword.getShopNameStr());
			keyword.setGoodsName(keyword.getGoodsNameStr());
		}
		Page<Keyword> page = keywordService.findKeywordList2(new Page<Keyword>(request, response), keyword);
        model.addAttribute("page", page);
		return "modules/im/keyword/keywordList";
	}

	//正常增删改查的
	@ResponseBody
	@RequestMapping(value = {"listData"})
	public Page<Keyword> listData(Keyword keyword, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Keyword> page = keywordService.findKeywordList2(new Page<Keyword>(request, response), keyword);
		return page;
	}

	@RequestMapping(value = "form")
	public String form(Keyword keyword, Model model) {
		model.addAttribute("keyword", keyword);
		return "modules/im/keyword/keywordForm";
	}

	@RequestMapping(value = "save")
	public String save(Keyword keyword, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		if(StringUtils.isAnyBlank(keyword.getGoodsName(),keyword.getShopName())){
			addMessage(redirectAttributes, "店铺或者产品不能为空");
			return "redirect:" + adminPath + "/im/keyword/list?repage";
		}
		if (!beanValidator(model, keyword)){
			return form(keyword, model);
		}
		keywordService.saveKeyword(keyword);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + adminPath + "/im/keyword/list?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(Keyword keyword, RedirectAttributes redirectAttributes) {
		keywordService.deleteKeyword(keyword);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + adminPath + "/im/keyword/list?repage";
	}

	/**
	 * 下载商品关键词效果分析模板
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "import/template")
	public String importFileTemplate(HttpServletRequest request,HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String filePath = "D:\\SVN潜渊科技\\系统\\商品关键词效果分析模板.xls";
			String fileName = "商品关键词效果分析模板.xls";
			//支持中文
			fileName = URLEncoder.encode(fileName,"UTF-8");
			response.reset();
			response.setContentType(request.getServletContext().getMimeType(fileName));
			response.setHeader("Content-Disposition", "attachment;filename="+fileName);
			InputStream in = new FileInputStream(filePath);
			OutputStream out = response.getOutputStream();
			byte[] b = new byte[1024];
			int length = 0;
			while((length = in.read(b)) != -1)  {
				out.write(b,0,length);
			}
			in.close();
			out.close();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/im/keyword/list?repage";
	}

	@RequestMapping(value = "import", method= RequestMethod.POST)
	public String importFile(MultipartFile file,Keyword keyword,RedirectAttributes redirectAttributes) {
		try {
			if(StringUtils.isAnyBlank(keyword.getGoodsName(),keyword.getShopName())){
				addMessage(redirectAttributes, "店铺或者产品不能为空");
				return "redirect:" + adminPath + "/im/keyword/list?repage";
			}
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Keyword> keywordList = new ArrayList<>();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			for (int i = ei.getDataRowNum()-1; i < ei.getLastDataRowNum(); i++) {
				Row row = ei.getRow(i);
				Keyword keyword1 = new Keyword();
				Date date0 = row.getCell(0).getDateCellValue();
				String str1 = row.getCell(1).getStringCellValue();
				String str2 = row.getCell(2).getStringCellValue();
				String str3 = row.getCell(3).getStringCellValue();
				if(date0 == null || StringUtils.isAnyBlank(str1,str2,str3)){
					failureMsg.append("<br/>第"+ i + "行数据为空; ");
					failureNum++;
					continue;
				}
				try{
					keyword1.setKeyDate(sdf.parse(sdf.format(date0)));
					keyword1.setKeyword(str1);
					keyword1.setAppearNumber(Integer.valueOf(str2));
					keyword1.setPayNumber(Integer.valueOf(str3));
					keyword1.setGoodsName(keyword.getGoodsName());
					keyword1.setShopName(keyword.getShopName());
					keywordList.add(keyword1);
					successNum++;
				}catch (Exception e){
					failureMsg.append("<br/>第"+ i + "行数据格式错误; ");
					failureNum++;
				}
			}
			if(keywordList.size() > 0){
				keywordService.saveKeywordByBatch(keywordList);
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条关键词，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条关键词"+failureMsg);
		} catch (Exception e) {
			e.printStackTrace();
			addMessage(redirectAttributes, "导入关键词失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/im/keyword/list?repage";
	}

	//关键词统计
	@RequestMapping(value = {"statis", ""})
	public String statis(Keyword keyword, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String startTime = "";
		String statisStatus = keyword.getStatisStatus();
		if(!StringUtils.equals("1",statisStatus)){
			statisStatus = "0";
		}
		String endTime = keyword.getEndKeyTime();
		String keywordStr = keyword.getKeyword();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		List<String> dateList = new ArrayList<>();
		if(StringUtils.isEmpty(endTime)){
			startTime = DateUtils.getNowDay(-10,null);
			endTime = DateUtils.getNowDay(-1,null);
		}else{
			startTime = DateUtils.getNowDay(-10,format.parse(endTime));
		}
		Date startDate = format.parse(startTime);
		for(int i=0;i<10;i++){
			dateList.add(DateUtils.getNowDay(i,startDate));
		}
		String shopName = keyword.getShopName();
		String goodsName = keyword.getGoodsName();
		keyword.setStartKeyTime(startTime + " 00:00:01");
		keyword.setEndKeyTime(endTime + " 23:59:59");

        List<Keyword> keywordList = keywordService.getKeywordList(keyword);
        //统计的关键字
		List<String> keywordStrList = new ArrayList<>();
		List<Map> mapList = new ArrayList<>();
        for (Keyword kword : keywordList){
			keywordStrList.add(kword.getKeyword());
			Map map = new HashMap();
			map.put("name",kword.getKeyword());
			map.put("type","line");
			keyword.setKeyword(kword.getKeyword());
			List<Keyword> keywordList2 = keywordService.getListByKeyword(keyword);
			if(StringUtils.equals("1",statisStatus)){
				List<Integer> payNumberList = new ArrayList<>();
				for(String dateStr : dateList){
					for(Keyword kword2 : keywordList2) {
						String keydate = format.format(kword2.getKeyDate());
						if(StringUtils.equals(dateStr,keydate)){
							payNumberList.add(kword2.getPayNumber());
							break;
						}
					}
					payNumberList.add(0);
				}
				map.put("data",payNumberList);
			}else{
				List<Integer> appearNumberList = new ArrayList<>();
				for(String dateStr : dateList){
					for(Keyword kword2 : keywordList2) {
						String keydate = format.format(kword2.getKeyDate());
						if(StringUtils.equals(dateStr,keydate)){
							appearNumberList.add(kword2.getAppearNumber());
							break;
						}
					}
					appearNumberList.add(0);
				}
				map.put("data",appearNumberList);
			}
			mapList.add(map);
		}
		model.addAttribute("keywordStrList",JSONArray.fromObject(keywordStrList).toString());
		model.addAttribute("dateList",JSONArray.fromObject(dateList).toString());
		model.addAttribute("keywordMap",JSONArray.fromObject(mapList).toString());
		keyword = new Keyword();
		keyword.setShopName(shopName);
		keyword.setGoodsName(goodsName);
		keyword.setEndKeyTime(endTime);
		keyword.setKeyword(keywordStr);
		keyword.setStatisStatus(statisStatus);
		model.addAttribute("keyword",keyword);
		return "modules/im/keyword/statisList";
	}
}

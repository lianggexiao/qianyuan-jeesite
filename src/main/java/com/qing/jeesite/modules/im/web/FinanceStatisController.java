/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.qing.jeesite.modules.im.web;

import com.qing.jeesite.common.utils.DateUtils;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.common.web.BaseController;
import com.qing.jeesite.modules.im.entity.FinanceBill;
import com.qing.jeesite.modules.im.service.FinanceStatisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import net.sf.json.JSONArray;

/**
 * 财务统计Controller
 * @author 柳青
 * @version 2017-3-25
 */
@Controller
@RequestMapping(value = "${adminPath}/im/finance/statis")
public class FinanceStatisController extends BaseController {

	@Autowired
	private FinanceStatisService financeStatisService;

	@ModelAttribute
	public FinanceBill get(@RequestParam(required=false) String id) {
		return new FinanceBill();
	}

	@RequestMapping(value = {"list", ""})
	public String list(FinanceBill financeBill,HttpServletRequest request, HttpServletResponse response, Model model) {
		String startTime = financeBill.getStartBillTime();
		String endTime = financeBill.getEndBillTime();

		if(StringUtils.isEmpty(startTime) || StringUtils.isEmpty(endTime)){
			startTime = DateUtils.getFirstDayMonth();
			endTime = DateUtils.getEndDayMonth();
		}
		financeBill.setStartBillTime(startTime);
		financeBill.setEndBillTime(endTime);
		List<FinanceBill> listFinanceBill = financeStatisService.getStatisByTime(financeBill);
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		if(listFinanceBill != null && listFinanceBill.size() > 0){
			for(FinanceBill fb:listFinanceBill){
				Map<String,String> map = new HashMap<String,String>();
				map.put("name",fb.getMatter());
				map.put("value",fb.getAmount());
				list.add(map);
			}
		}else{

		}
		String json = JSONArray.fromObject(list).toString();
		model.addAttribute("statisData",json);
		return "modules/im/finance/statisList";
	}
	
}

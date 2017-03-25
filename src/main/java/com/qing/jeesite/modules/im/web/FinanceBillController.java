/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.qing.jeesite.modules.im.web;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.common.web.BaseController;
import com.qing.jeesite.modules.im.entity.FinanceBill;
import com.qing.jeesite.modules.im.entity.FinanceDetailBill;
import com.qing.jeesite.modules.im.service.FinanceBillService;
import com.qing.jeesite.modules.im.service.FinanceDetailBillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 财务报销单Controller
 * @author 柳青
 * @version 2017-3-25
 */
@Controller
@RequestMapping(value = "${adminPath}/im/finance/bill")
public class FinanceBillController extends BaseController {

	@Autowired
	private FinanceBillService financeBillService;
	@Autowired
	private FinanceDetailBillService financeDetailBillService;
	
	@ModelAttribute
	public FinanceBill get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return financeBillService.getFinanceBill(id);
		}else{
			return new FinanceBill();
		}

	}

	@RequestMapping(value = {"list", ""})
	public String list(FinanceBill financeBill, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FinanceBill> page = financeBillService.findFinanceBillList(new Page<FinanceBill>(request, response), financeBill);
        model.addAttribute("page", page);
		return "modules/im/finance/financeBillList";
	}
	
	@ResponseBody
	@RequestMapping(value = {"listData"})
	public Page<FinanceBill> listData(FinanceBill financeBill, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FinanceBill> page = financeBillService.findFinanceBillList(new Page<FinanceBill>(request, response), financeBill);
		return page;
	}

	@RequestMapping(value = "form")
	public String form(FinanceBill financeBill, Model model) {
		FinanceDetailBill financeDetailBill = new FinanceDetailBill();
		String billId = financeBill.getId();
		if(StringUtils.isEmpty(billId)){
			billId = "###"; //定义出这样就是为了不让查出数据
		}
		financeDetailBill.setBillId(billId);
		List<FinanceDetailBill> financeDetailBillList = financeDetailBillService.findFinanceBillList(financeDetailBill);
		model.addAttribute("financeBill", financeBill);
		model.addAttribute("financeDetailBillList", financeDetailBillList);
		return "modules/im/finance/financeBillForm";
	}

	@RequestMapping(value = "save")
	public String save(FinanceBill financeBill, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {

		if (!beanValidator(model, financeBill)){
			return form(financeBill, model);
		}
		financeBillService.saveFinanceBill(financeBill);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + adminPath + "/im/finance/bill/list?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(FinanceBill financeBill, RedirectAttributes redirectAttributes) {
		financeBillService.deleteFinanceBill(financeBill);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + adminPath + "/im/finance/bill/list?repage";
	}


}

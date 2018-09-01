package com.qing.jeesite.modules.im.web;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.common.web.BaseController;
import com.qing.jeesite.modules.im.entity.Cashback;
import com.qing.jeesite.modules.im.service.CashbackService;
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

/**
 * 返现信息Controller
 * @author 柳青
 * @version 2018-7-28
 */
@Controller
@RequestMapping(value = "${adminPath}/im/cashback")
public class CashbackController extends BaseController {

	@Autowired
	private CashbackService cashbackService;
	
	@ModelAttribute
	public Cashback get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return cashbackService.getCashback(id);
		}else{
			return new Cashback();
		}

	}

	@RequestMapping(value = {"list", ""})
	public String list(Cashback cashback, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Cashback> page = cashbackService.findCashbackList(new Page<Cashback>(request, response), cashback);
        model.addAttribute("page", page);
		return "modules/im/cashback/cashbackList";
	}
	
	@ResponseBody
	@RequestMapping(value = {"listData"})
	public Page<Cashback> listData(Cashback cashback, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Cashback> page = cashbackService.findCashbackList(new Page<Cashback>(request, response), cashback);
		return page;
	}

	@RequestMapping(value = "form")
	public String form(Cashback cashback, Model model) {
		model.addAttribute("cashback", cashback);
		return "modules/im/cashback/cashbackForm";
	}

	@RequestMapping(value = "save")
	public String save(Cashback cashback, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {

		if (!beanValidator(model, cashback)){
			return form(cashback, model);
		}
		cashbackService.saveCashback(cashback);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + adminPath + "/im/cashback/list?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(Cashback cashback, RedirectAttributes redirectAttributes) {
		cashbackService.deleteCashback(cashback);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + adminPath + "/im/cashback/list?repage";
	}

	/**
	 * 用户信息选择弹框
	 * @param cashback
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toSelectCashback")
	public String toSelectCashback(Cashback cashback, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Cashback> page = cashbackService.findCashbackList(new Page<Cashback>(request, response), cashback);
		model.addAttribute("page", page);
		return "modules/im/cashback/toSelectCashback";
	}
}

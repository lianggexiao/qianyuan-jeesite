package com.qing.jeesite.modules.im.web;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.common.web.BaseController;
import com.qing.jeesite.modules.im.entity.BrushOrder;
import com.qing.jeesite.modules.im.service.BrushOrderService;
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
 * 刷单信息Controller
 * @author 柳青
 * @version 2018-7-28
 */
@Controller
@RequestMapping(value = "${adminPath}/im/brushOrder")
public class BrushOrderController extends BaseController {

	@Autowired
	private BrushOrderService brushOrderService;
	
	@ModelAttribute
	public BrushOrder get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return brushOrderService.getBrushOrder(id);
		}else{
			return new BrushOrder();
		}

	}

	@RequestMapping(value = {"list", ""})
	public String list(BrushOrder brushOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BrushOrder> page = brushOrderService.findBrushOrderList(new Page<BrushOrder>(request, response), brushOrder);
        model.addAttribute("page", page);
		return "modules/im/brushOrder/brushOrderList";
	}
	
	@ResponseBody
	@RequestMapping(value = {"listData"})
	public Page<BrushOrder> listData(BrushOrder brushOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BrushOrder> page = brushOrderService.findBrushOrderList(new Page<BrushOrder>(request, response), brushOrder);
		return page;
	}

	@RequestMapping(value = "form")
	public String form(BrushOrder brushOrder, Model model) {
		model.addAttribute("brushOrder", brushOrder);
		return "modules/im/brushOrder/brushOrderForm";
	}

	@RequestMapping(value = "save")
	public String save(BrushOrder brushOrder, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {

		if (!beanValidator(model, brushOrder)){
			return form(brushOrder, model);
		}
		brushOrderService.saveBrushOrder(brushOrder);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + adminPath + "/im/brushOrder/list?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(BrushOrder brushOrder, RedirectAttributes redirectAttributes) {
		brushOrderService.deleteBrushOrder(brushOrder);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + adminPath + "/im/brushOrder/list?repage";
	}

	/**
	 * 用户信息选择弹框
	 * @param brushOrder
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toSelectBrushOrder")
	public String toSelectBrushOrder(BrushOrder brushOrder, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BrushOrder> page = brushOrderService.findBrushOrderList(new Page<BrushOrder>(request, response), brushOrder);
		model.addAttribute("page", page);
		return "modules/im/brushOrder/toSelectBrushOrder";
	}
}

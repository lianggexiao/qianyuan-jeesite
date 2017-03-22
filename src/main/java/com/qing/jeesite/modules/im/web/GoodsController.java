/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.qing.jeesite.modules.im.web;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.common.web.BaseController;
import com.qing.jeesite.modules.im.entity.Goods;
import com.qing.jeesite.modules.im.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 商品Controller
 * @author 柳青
 * @version 2017-3-19
 */
@Controller
@RequestMapping(value = "${adminPath}/im/goods")
public class GoodsController extends BaseController {

	@Autowired
	private GoodsService goodsService;
	
	@ModelAttribute
	public Goods get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return goodsService.getGoods(id);
		}else{
			return new Goods();
		}

	}

	@RequestMapping(value = {"list", ""})
	public String list(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Goods> page = goodsService.findGoodsList(new Page<Goods>(request, response), goods);
        model.addAttribute("page", page);
		return "modules/im/goods/goodsList";
	}
	
	@ResponseBody
	@RequestMapping(value = {"listData"})
	public Page<Goods> listData(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Goods> page = goodsService.findGoodsList(new Page<Goods>(request, response), goods);
		return page;
	}

	@RequestMapping(value = "form")
	public String form(Goods goods, Model model) {
		model.addAttribute("goods", goods);
		return "modules/im/goods/goodsForm";
	}

	@RequestMapping(value = "save")
	public String save(Goods goods, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {

		if (!beanValidator(model, goods)){
			return form(goods, model);
		}
		goodsService.saveGoods(goods);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + adminPath + "/im/goods/list?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(Goods goods, RedirectAttributes redirectAttributes) {
		goodsService.deleteGoods(goods);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + adminPath + "/im/goods/list?repage";
	}


}

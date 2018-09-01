package com.qing.jeesite.modules.im.web;

import com.qing.jeesite.common.persistence.Page;
import com.qing.jeesite.common.utils.StringUtils;
import com.qing.jeesite.common.web.BaseController;
import com.qing.jeesite.modules.im.entity.BrushOrder;
import com.qing.jeesite.modules.im.entity.Cashback;
import com.qing.jeesite.modules.im.entity.UserInfo;
import com.qing.jeesite.modules.im.service.BrushOrderService;
import com.qing.jeesite.modules.im.service.CashbackService;
import com.qing.jeesite.modules.im.service.UserInfoService;
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
import java.util.ArrayList;
import java.util.List;

/**
 * 用户信息Controller
 * @author 柳青
 * @version 2018-7-28
 */
@Controller
@RequestMapping(value = "${adminPath}/im/userInfo")
public class UserInfoController extends BaseController {

	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private BrushOrderService brushOrderService;
	@Autowired
	private CashbackService cashbackService;
	
	@ModelAttribute
	public UserInfo get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return userInfoService.getUserInfo(id);
		}else{
			return new UserInfo();
		}

	}

	@RequestMapping(value = {"list", ""})
	public String list(UserInfo userInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserInfo> page = userInfoService.findUserInfoList(new Page<UserInfo>(request, response), userInfo);
        model.addAttribute("page", page);
		return "modules/im/userInfo/userInfoList";
	}
	
	@ResponseBody
	@RequestMapping(value = {"listData"})
	public Page<UserInfo> listData(UserInfo userInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserInfo> page = userInfoService.findUserInfoList(new Page<UserInfo>(request, response), userInfo);
		return page;
	}

	@RequestMapping(value = "form")
	public String form(UserInfo userInfo, Model model) {
		model.addAttribute("userInfo", userInfo);
		return "modules/im/userInfo/userInfoForm";
	}

	@RequestMapping(value = "save")
	public String save(UserInfo userInfo, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {

		if (!beanValidator(model, userInfo)){
			return form(userInfo, model);
		}

		List<String> list = new ArrayList<>();

		if(StringUtils.isEmpty(userInfo.getWangId()) && StringUtils.isEmpty(userInfo.getJdId())){
			list.add("旺旺名或者京东账号至少有一个不能为空");
			addMessage(model, list.toArray(new String[]{}));
			return form(userInfo, model);
		}

		if(!userInfoService.saveUserInfo(userInfo)){
			list.add("旺旺名称或京东账号已存在，请重新输入");
			addMessage(model, list.toArray(new String[]{}));
			return form(userInfo, model);
		}

		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + adminPath + "/im/userInfo/list?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(UserInfo userInfo, RedirectAttributes redirectAttributes) {
		userInfoService.deleteUserInfo(userInfo);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + adminPath + "/im/userInfo/list?repage";
	}

	/**
	 * 用户信息选择弹框
	 * @param userInfo
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toSelectUserInfo")
	public String toSelectUserInfo(UserInfo userInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserInfo> page = userInfoService.findUserInfoList(new Page<UserInfo>(request, response), userInfo);
		model.addAttribute("page", page);
		return "modules/im/userInfo/toSelectUserInfo";
	}

	/**
	 * 查看详情
	 */
	@RequestMapping(value = "toShow")
	public String toShow(UserInfo userInfo, Model model) {
		if(userInfo == null){
			model.addAttribute("userInfo", new UserInfo());
			model.addAttribute("brushOrderList", new ArrayList<BrushOrder>());
			model.addAttribute("cashbackList", new ArrayList<Cashback>());
			return "modules/im/userInfo/show";
		}
		String id = userInfo.getId();
		if(StringUtils.isEmpty(id)){
			id = "###"; //定义出这样就是为了不让查出数据
		}
		userInfo = userInfoService.getUserInfo(id);
		List<BrushOrder> brushOrderList = brushOrderService.findByUserId(id);
		List<Cashback> cashbackList = cashbackService.findByUserId(id);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("brushOrderList", brushOrderList);
		model.addAttribute("cashbackList", cashbackList);
		return "modules/im/userInfo/show";
	}
}

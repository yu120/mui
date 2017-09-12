package cn.ms.mui.ctrl;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.ms.mui.service.LimiterService;
import cn.ms.neural.limiter.RuleData;

@Controller
@RequestMapping("web")
public class WebCtrl {

	@Resource
	private LimiterService limiterService;

	@RequestMapping(value = "index")
	public String index(HttpServletRequest request) {
		return "index";
	}

	/**
	 * 首页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "main")
	public String main(HttpServletRequest request) {
		return "main";
	}

	/**
	 * 限流规则列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "limiterRules")
	public String limiterRules(String keywords, HttpServletRequest request) {
		if(keywords == null){
			keywords = "";
		}
		RuleData limiterData = limiterService.search(keywords);
		request.setAttribute("limiterData", limiterData);
		return "limiter_rules";
	}

}

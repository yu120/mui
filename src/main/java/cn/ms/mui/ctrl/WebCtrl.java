package cn.ms.mui.ctrl;

import io.neural.limiter.RuleData;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.ms.mui.service.LimiterService;

@Controller
@RequestMapping("web")
public class WebCtrl {

	@Resource
	private LimiterService limiterService;

	@RequestMapping("navigation")
	public String navigation(HttpServletRequest request) {
		return "navigation";
	}

	@RequestMapping(value = "main")
	public String main(HttpServletRequest request) {
		return "main";
	}

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

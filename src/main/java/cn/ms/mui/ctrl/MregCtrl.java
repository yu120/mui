package cn.ms.mui.ctrl;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.ms.mui.service.MregService;

@Controller
@RequestMapping("mreg")
public class MregCtrl {

	@Resource
	private MregService mregService;

	@RequestMapping("services")
	public String main(HttpServletRequest request) {
		request.setAttribute("services", mregService.getServices());
		return "services";
	}

}

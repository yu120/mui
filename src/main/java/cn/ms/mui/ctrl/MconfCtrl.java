package cn.ms.mui.ctrl;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.ms.mui.service.MconfService;

@Controller
@RequestMapping("mconf")
public class MconfCtrl {

	@Resource
	private MconfService mconfService;

	@RequestMapping(value = "confs")
	public String confs(HttpServletRequest request) {
		request.setAttribute("confs", mconfService.getConfs());
		return "confs";
	}

}

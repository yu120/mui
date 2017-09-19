package cn.ms.mui.ctrl;

import io.coon.support.mreg.MregGovernor.ServiceUnit;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.ms.mui.service.MregService;

@Controller
@RequestMapping("mreg")
public class MregCtrl {

	@Resource
	private MregService mregService;

	@RequestMapping("applications")
	public String applications(HttpServletRequest request) {
		request.setAttribute("applications", mregService.getApplications());
		return "applications";
	}
	
	@RequestMapping("services")
	public String services(HttpServletRequest request) {
		request.setAttribute("services", mregService.getServices());
		return "services";
	}
	
	@RequestMapping("service")
	public String service(@RequestParam("serviceName") String serviceName, HttpServletRequest request) {
		request.setAttribute("serviceName", serviceName);
		Map<String, ServiceUnit> serviceUnitMap = mregService.getServices().get(serviceName);
		if(serviceUnitMap != null){
			request.setAttribute("service", serviceUnitMap);
		}
		
		return "service";
	}

}

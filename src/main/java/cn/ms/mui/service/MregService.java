package cn.ms.mui.service;

import java.util.Map;

import cn.ms.coon.support.mreg.MregGovernor.Application;
import cn.ms.coon.support.mreg.MregGovernor.ServiceUnit;

public interface MregService {
	
	Map<String, Application> getApplications();

	Map<String, Map<String, ServiceUnit>> getServices();
	
}

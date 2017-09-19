package cn.ms.mui.service;

import io.coon.support.mreg.MregGovernor.Application;
import io.coon.support.mreg.MregGovernor.ServiceUnit;

import java.util.Map;

public interface MregService {
	
	Map<String, Application> getApplications();

	Map<String, Map<String, ServiceUnit>> getServices();
	
}

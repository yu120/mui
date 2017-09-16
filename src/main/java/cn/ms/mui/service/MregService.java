package cn.ms.mui.service;

import java.util.Map;

import cn.ms.coon.support.mreg.monitor.MregGovernor.ServiceUnit;

public interface MregService {

	Map<String, Map<String, ServiceUnit>> getServices();
	
}

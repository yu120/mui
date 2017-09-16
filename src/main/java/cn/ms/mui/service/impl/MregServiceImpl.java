package cn.ms.mui.service.impl;

import java.util.Map;

import org.springframework.stereotype.Service;

import cn.ms.coon.CoonFactory;
import cn.ms.coon.service.Mreg;
import cn.ms.coon.support.mreg.MregGovernor;
import cn.ms.coon.support.mreg.MregGovernor.Application;
import cn.ms.coon.support.mreg.MregGovernor.ServiceUnit;
import cn.ms.mui.service.MregService;
import cn.ms.neural.NURL;

@Service
public class MregServiceImpl implements MregService {

	MregGovernor governor;
	
	public MregServiceImpl() {
		NURL nurl = NURL.valueOf("zookeeper://127.0.0.1:2181/mconf?timeout=15000&session=60000&node=node01");
		Mreg mreg = CoonFactory.CF.getCoon(nurl, Mreg.class);
		governor = new MregGovernor(mreg);
	}
	
	@Override
	public Map<String, Application> getApplications() {
		return governor.getApplications();
	}
	
	@Override
	public Map<String, Map<String, ServiceUnit>> getServices() {
		return governor.getServices();
	}
	
}

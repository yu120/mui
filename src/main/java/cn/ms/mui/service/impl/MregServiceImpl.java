package cn.ms.mui.service.impl;

import io.coon.Coon;
import io.coon.api.Mreg;
import io.coon.support.mreg.MregGovernor;
import io.coon.support.mreg.MregGovernor.Application;
import io.coon.support.mreg.MregGovernor.ServiceUnit;
import io.neural.NURL;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import cn.ms.mui.service.MregService;

@Service
public class MregServiceImpl implements MregService {

	MregGovernor governor;
	
	public MregServiceImpl() {
//		NURL nurl = NURL.valueOf("zookeeper://127.0.0.1:2181/mconf?timeout=15000&session=60000&node=node01");
//		Mreg mreg = Coon.CF.getCoon(nurl, Mreg.class);
//		governor = new MregGovernor(mreg);
	}
	
	@Override
	public Map<String, Application> getApplications() {
		if(null==governor){
			return new HashMap<>();
		}

		return governor.getApplications();
	}
	
	@Override
	public Map<String, Map<String, ServiceUnit>> getServices() {
		if(null==governor){
			return new HashMap<>();
		}

		return governor.getServices();
	}
	
}

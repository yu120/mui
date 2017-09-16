package cn.ms.mui.service.impl;

import java.util.Map;

import org.springframework.stereotype.Service;

import cn.ms.coon.CoonFactory;
import cn.ms.coon.service.Mconf;
import cn.ms.mui.service.MconfService;
import cn.ms.neural.NURL;

@Service
public class MconfServiceImpl implements MconfService {

	Mconf mconf;
	
	public MconfServiceImpl() {
		NURL nurl = NURL.valueOf("zookeeper://127.0.0.1:2181/mconf?timeout=15000&session=60000&node=node01");
		mconf = CoonFactory.CF.getCoon(nurl, Mconf.class);
	}
	
	@Override
	public Map<String, Map<String, String>> getApps() {
		return mconf.apps();
	}

	@Override
	public Map<String, Map<String, String>> getConfs() {
		System.out.println(mconf.confs());
		return mconf.confs();
	}

}

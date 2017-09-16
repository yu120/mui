package cn.ms.mui.service.impl;

import org.springframework.stereotype.Service;

import cn.ms.mui.service.LimiterService;
import cn.ms.neural.limiter.Limiter;
import cn.ms.neural.limiter.RuleData;

@Service
public class LimiterServiceImpl implements LimiterService {

	Limiter limiter;

	public LimiterServiceImpl() {
		//limiter = new RedisLimiter();
		//limiter.start(NURL.valueOf("redis://127.0.0.1:6379/ms"));
	}

	@Override
	public RuleData search(String keywords) {
		return limiter.search(keywords);
	}

}

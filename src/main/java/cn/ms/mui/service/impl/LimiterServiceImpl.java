package cn.ms.mui.service.impl;

import io.neural.limiter.Limiter;
import io.neural.limiter.RuleData;

import org.springframework.stereotype.Service;

import cn.ms.mui.service.LimiterService;

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

package cn.ms.mui.service;

import io.neural.limiter.RuleData;

public interface LimiterService {

	RuleData search(String keywords);

}

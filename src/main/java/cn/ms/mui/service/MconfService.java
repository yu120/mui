package cn.ms.mui.service;

import java.util.Map;

public interface MconfService {

	Map<String, Map<String, String>> getApps();

	Map<String, Map<String, String>> getConfs();

}

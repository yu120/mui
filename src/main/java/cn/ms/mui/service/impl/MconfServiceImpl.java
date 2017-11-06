package cn.ms.mui.service.impl;

import io.coon.Coon;
import io.coon.api.Mconf;
import io.neural.NURL;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import cn.ms.mui.service.MconfService;

@Service
public class MconfServiceImpl implements MconfService {

    Mconf mconf;

    public MconfServiceImpl() {
//        NURL nurl = NURL.valueOf("zookeeper://127.0.0.1:2181/mconf?timeout=15000&session=60000&node=node01");
//        mconf = Coon.CF.getCoon(nurl, Mconf.class);
    }

    @Override
    public Map<String, Map<String, String>> getApps() {
        if (null == mconf) {
            return new HashMap<>();
        }
        return mconf.apps();
    }

    @Override
    public Map<String, Map<String, String>> getConfs() {
        if (null == mconf) {
            return new HashMap<>();
        }
        return mconf.confs();
    }

}

package cn.ms.mui.ctrl;

import java.util.*;
import javax.servlet.http.HttpServletRequest;

import io.neural.common.Identity;
import io.neural.limiter.support.LimiterConfigCenter;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import io.neural.limiter.Limiter;
import io.neural.limiter.model.LimiterConfig;
import io.neural.limiter.model.LimiterConfig.GlobalConfig;

/**
 * @author lry
 **/
@Controller
@RequestMapping("limiter")
public class LimiterCtrl {

    @RequestMapping(value = "limiter-configs")
    public String limiterConfigs(HttpServletRequest request) {
        request.setAttribute("globalConfig", Limiter.LIMITER.getGlobalConfig());
        Map<Identity, LimiterConfig.Config> map = Limiter.LIMITER.getConfigCenter().queryConfigs();
        final Set<LimiterConfig> limiterConfigSet = new HashSet<>();
        for (Map.Entry<Identity, LimiterConfig.Config> entry : map.entrySet()) {
            limiterConfigSet.add(new LimiterConfig(entry.getKey(), entry.getValue()));
        }
        request.setAttribute("limiterConfigs", limiterConfigSet);
        return "limiter-configs";
    }

    @RequestMapping(value = "limiter-monitor")
    public String limiterMonitor(HttpServletRequest request) {
        return "limiter-monitor";
    }

    @RequestMapping(value = "update-global-config", method = RequestMethod.POST)
    public String updateGlobalConfig(HttpServletRequest request) throws Exception {
        Map<String, String> map = new HashMap<>();
        Enumeration<String> keys = request.getParameterNames();
        while (keys.hasMoreElements()) {
            String key = keys.nextElement();
            map.put(key, request.getParameter(key));
        }

        if (!map.isEmpty()) {
            LimiterConfigCenter configCenter = Limiter.LIMITER.getConfigCenter();
            GlobalConfig globalConfig = configCenter.getGlobalConfig();
            BeanUtils.copyProperties(globalConfig, map);
            configCenter.addGlobalConfig(globalConfig);
        }

        return "redirect:limiter-configs";
    }
}

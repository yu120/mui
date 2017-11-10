package cn.ms.mui.ctrl;

import java.util.*;
import javax.servlet.http.HttpServletRequest;

import io.neural.common.Identity;
import io.neural.limiter.support.LimiterConfigCenter;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import io.neural.limiter.Limiter;
import io.neural.limiter.support.LimiterConfig;
import io.neural.limiter.support.LimiterConfig.GlobalConfig;

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

    @RequestMapping(value = "limiter-monitor/{application}/{group}/{resource}")
    public String limiterMonitor(HttpServletRequest request,
                                 @PathVariable("application") String application,
                                 @PathVariable("group") String group,
                                 @PathVariable("resource") String resource) {
        Identity identity = new Identity(application, group, resource);
        LimiterConfig.Config config = Limiter.LIMITER.getConfigCenter().queryConfig(identity);
        request.setAttribute("limiterConfig", new LimiterConfig(identity, config));
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

    @RequestMapping(value = "limiter-config/{application}/{group}/{resource}")
    public String limiterConfig(HttpServletRequest request,
                                @PathVariable("application") String application,
                                @PathVariable("group") String group,
                                @PathVariable("resource") String resource) {
        Identity identity = new Identity(application, group, resource);
        LimiterConfig.Config config = Limiter.LIMITER.getConfigCenter().queryConfig(identity);
        request.setAttribute("limiterConfig", new LimiterConfig(identity, config));
        return "limiter-config";
    }

    @RequestMapping(value = "update-config", method = RequestMethod.POST)
    public String updateConfig(HttpServletRequest request) throws Exception {
        Map<String, String> map = new HashMap<>();
        Enumeration<String> keys = request.getParameterNames();
        while (keys.hasMoreElements()) {
            String key = keys.nextElement();
            map.put(key, request.getParameter(key));
        }

        if (!map.isEmpty()) {
            LimiterConfigCenter configCenter = Limiter.LIMITER.getConfigCenter();
            Identity identity = Identity.parseIdentity(map);
            LimiterConfig.Config config = LimiterConfig.parseConfig(map);
            if (!StringUtils.isEmpty(identity.getApplication()) && !StringUtils.isEmpty(identity.getGroup()) && !StringUtils.isEmpty(identity.getResource())) {
                configCenter.addConfig(identity, config);
            }
        }

        return "redirect:limiter-configs";
    }

}

package cn.ms.mui.ctrl;

import java.util.*;
import javax.servlet.http.HttpServletRequest;

import io.neural.common.Identity;
import io.neural.limiter.support.LimiterConfigCenter;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


import io.neural.limiter.Limiter;
import io.neural.limiter.support.LimiterConfig;
import io.neural.limiter.support.LimiterConfig.GlobalConfig;

/**
 * 限流控制器
 *
 * @author lry
 */
@Controller
@RequestMapping("limiter")
public class LimiterCtrl {

    @RequestMapping(value = "limiter-configs", method = RequestMethod.GET)
    public String limiterConfigs(HttpServletRequest request) {
        request.setAttribute("globalConfig", Limiter.LIMITER.getConfigCenter().queryGlobalConfig());
        Map<Identity, LimiterConfig.Config> map = Limiter.LIMITER.getConfigCenter().queryConfigs();
        final Set<LimiterConfig> limiterConfigSet = new HashSet<>();
        for (Map.Entry<Identity, LimiterConfig.Config> entry : map.entrySet()) {
            limiterConfigSet.add(new LimiterConfig(entry.getKey(), entry.getValue()));
        }
        request.setAttribute("limiterConfigs", limiterConfigSet);
        return "limiter-configs";
    }

    @RequestMapping(value = "limiter-monitor/{application}/{group}/{resource}", method = RequestMethod.GET)
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
            GlobalConfig globalConfig = LimiterConfig.parseGlobalConfig(map);
            LimiterConfigCenter configCenter = Limiter.LIMITER.getConfigCenter();
            configCenter.addGlobalConfig(globalConfig);
        }

        return "redirect:limiter-configs";
    }

    @RequestMapping(value = "limiter-config/{application}/{group}/{resource}", method = RequestMethod.GET)
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
            if (!StringUtils.isEmpty(identity.getApplication())) {
                if (!StringUtils.isEmpty(identity.getGroup())) {
                    if (!StringUtils.isEmpty(identity.getResource())) {
                        configCenter.addConfig(identity, config);
                    }
                }
            }
        }

        return "redirect:limiter-configs";
    }

}

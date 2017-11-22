package cn.ms.mui.ctrl;

import io.neural.common.Identity;
import io.neural.degrade.Degrade;
import io.neural.degrade.support.DegradeConfig;
import io.neural.degrade.support.DegradeConfig.Config;
import io.neural.degrade.support.DegradeConfigCenter;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 服务降级控制器
 *
 * @author lry
 */
@Controller
@RequestMapping("degrade")
public class DegradeCtrl {

    @RequestMapping(value = "degrade-configs")
    public String degradeConfigs(HttpServletRequest request) {
        request.setAttribute("globalConfig", Degrade.DEGRADE.getConfigCenter().queryGlobalConfig());
        Map<Identity, Config> map = Degrade.DEGRADE.getConfigCenter().queryConfigs();
        final Set<DegradeConfig> degradeConfigSet = new HashSet<>();
        for (Map.Entry<Identity, Config> entry : map.entrySet()) {
            degradeConfigSet.add(new DegradeConfig(entry.getKey(), entry.getValue()));
        }
        request.setAttribute("degradeConfigs", degradeConfigSet);
        return "degrade-configs";
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
            DegradeConfig.GlobalConfig globalConfig = DegradeConfig.parseGlobalConfig(map);
            DegradeConfigCenter configCenter = Degrade.DEGRADE.getConfigCenter();
            configCenter.addGlobalConfig(globalConfig);
        }

        return "redirect:degrade-configs";
    }

    @RequestMapping(value = "degrade-config/{application}/{group}/{resource}", method = RequestMethod.GET)
    public String limiterConfig(HttpServletRequest request,
                                @PathVariable("application") String application,
                                @PathVariable("group") String group,
                                @PathVariable("resource") String resource) {
        Identity identity = new Identity(application, group, resource);
        DegradeConfig.Config config = Degrade.DEGRADE.getConfigCenter().queryConfig(identity);
        request.setAttribute("degradeConfig", new DegradeConfig(identity, config));
        return "degrade-config";
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
            DegradeConfigCenter configCenter = Degrade.DEGRADE.getConfigCenter();
            Identity identity = Identity.parseIdentity(map);
            DegradeConfig.Config config = DegradeConfig.parseConfig(map);
            if (!StringUtils.isEmpty(identity.getApplication())) {
                if (!StringUtils.isEmpty(identity.getGroup())) {
                    if (!StringUtils.isEmpty(identity.getResource())) {
                        configCenter.addConfig(identity, config);
                    }
                }
            }
        }

        return "redirect:degrade-configs";
    }

}

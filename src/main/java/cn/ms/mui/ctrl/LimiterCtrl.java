package cn.ms.mui.ctrl;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import io.neural.limiter.Limiter;
import io.neural.limiter.support.model.LimiterConfig;
import io.neural.limiter.support.model.LimiterGlobalConfig;
import io.neural.limiter.support.store.ILimiterStore;

/**
 * @author lry
 **/
@Controller
@RequestMapping("limiter")
public class LimiterCtrl
{

    @RequestMapping(value = "limiter-configs")
    public String limiterConfigs(HttpServletRequest request)
    {
        request.setAttribute("globalConfig", Limiter.LIMITER.getGlobalConfig());
        Set<LimiterConfig> limiterConfigSet = Limiter.LIMITER.getLimiterStore().queryLimiterConfigs();
        request.setAttribute("limiterConfigs", limiterConfigSet);
        return "limiter-configs";
    }

    @RequestMapping(value = "limiter-monitor")
    public String limiterMonitor(HttpServletRequest request)
    {
        return "limiter-monitor";
    }

    @RequestMapping(value = "update-global-config", method = RequestMethod.POST)
    public String updateGlobalConfig(HttpServletRequest request)
    {
        Map<String, String> map = new HashMap<>();
        Enumeration<String> keys = request.getParameterNames();
        while (keys.hasMoreElements())
        {
            String key = keys.nextElement();
            map.put(key, request.getParameter(key));
        }

        if (!map.isEmpty())
        {
            ILimiterStore limiterStore = Limiter.LIMITER.getLimiterStore();
            LimiterGlobalConfig globalConfig = limiterStore.getGlobalConfig();
            BeanUtils.copyProperties(map, globalConfig);
            limiterStore.addOrUpdateLimiterGlobalConfig(globalConfig);
        }

        return "redirect:limiter-configs";
    }
}

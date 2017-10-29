package cn.ms.mui.ctrl;

import java.util.Set;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import io.neural.limiter.Limiter;
import io.neural.limiter.support.model.LimiterConfig;
import io.neural.limiter.support.model.LimiterGlobalConfig;

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

}

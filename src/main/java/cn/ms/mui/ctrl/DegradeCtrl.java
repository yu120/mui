package cn.ms.mui.ctrl;

import io.neural.common.Identity;
import io.neural.degrade.Degrade;
import io.neural.degrade.support.DegradeConfig;
import io.neural.degrade.support.DegradeConfig.Config;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * The Degrade
 *
 * @author lry
 */
@Controller
@RequestMapping("degrade")
public class DegradeCtrl {

    @RequestMapping(value = "degrade-configs")
    public String degradeConfigs(HttpServletRequest request) {
        request.setAttribute("globalConfig", Degrade.DEGRADE.getGlobalConfig());
        Map<Identity, Config> map = Degrade.DEGRADE.getConfigCenter().queryConfigs();
        final Set<DegradeConfig> degradeConfigSet = new HashSet<>();
        for (Map.Entry<Identity, Config> entry : map.entrySet()) {
            degradeConfigSet.add(new DegradeConfig(entry.getKey(), entry.getValue()));
        }
        request.setAttribute("degradeConfigs", degradeConfigSet);
        return "degrade-configs";
    }

}

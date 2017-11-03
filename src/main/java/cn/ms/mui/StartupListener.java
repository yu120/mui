package cn.ms.mui;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import io.coon.Coon;
import io.coon.api.Mconf;
import io.neural.NURL;
import io.neural.limiter.Limiter;
import io.neural.limiter.common.LimiterUtils;

/**
 * 应用启动监听器
 *
 * @author lry
 */
public class StartupListener implements ServletContextListener
{

    /**
     * 连接服务
     */
    @Override
    public void contextInitialized(ServletContextEvent sce)
    {
        System.setProperty(LimiterUtils.APP_NAME_KEY, "gateway");
        Limiter.LIMITER.start();
    }

    /**
     * 关闭服务
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce)
    {
        Limiter.LIMITER.destroy();
    }

}
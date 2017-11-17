package cn.ms.mui;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import io.neural.common.AbstractConfigCenter;
import io.neural.degrade.Degrade;
import io.neural.limiter.Limiter;

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
        System.setProperty(AbstractConfigCenter.APP_NAME_KEY, "gateway");
        Limiter.LIMITER.start();
        Degrade.DEGRADE.start();
    }

    /**
     * 关闭服务
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce)
    {
        Limiter.LIMITER.destroy();
        Degrade.DEGRADE.destroy();
    }

}
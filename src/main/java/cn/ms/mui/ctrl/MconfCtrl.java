package cn.ms.mui.ctrl;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.ms.mui.service.MconfService;

@Controller
@RequestMapping("mconf")
public class MconfCtrl {

	@Resource
	private MconfService mconfService;

	@RequestMapping(value = "index")
	public String index(HttpServletRequest request) {
		return "index";
	}

	/**
	 * 首页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "main")
	public String main(HttpServletRequest request) {
		return "main";
	}

	/**
	 * 应用列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "apps")
	public String apps(HttpServletRequest request) {
		return "apps";
	}

	/**
	 * 配置分析
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "confs")
	public String confs(HttpServletRequest request) {
		return "confs";
	}

	/**
	 * 数据中心
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "datas")
	public String datas(String keywords, HttpServletRequest request) {
		return "datas";
	}

	/**
	 * 数据ID列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "dataids")
	public String dataids(HttpServletRequest request) {
		return "dataids";
	}
	
}

package com.hyjk.common.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

//防 XSS 攻击的过滤器
public class XSSFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }
    @Override
    public void destroy() {
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        //再实现 ServletRequest 的包装类
        chain.doFilter(new XSSRequestWrapper((HttpServletRequest) request), response);
    }
}

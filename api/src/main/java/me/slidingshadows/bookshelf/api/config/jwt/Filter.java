package me.slidingshadows.bookshelf.api.config.jwt;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import me.slidingshadows.bookshelf.api.config.BookshelfUserDetailsService;

@Component
public class Filter extends GenericFilterBean {
    public static final String HEADER = "Authorization";
    public static final String BEARER = "Bearer ";

    @Autowired
    private Provider provider;

    @Autowired
    BookshelfUserDetailsService userDetailsService;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        String token = getToken((HttpServletRequest)request);

        if (token !=null && provider.valdateToken(token)) {
            String username = provider.getUsernameFromToken(token);

            try {
                UserDetails userDetails = userDetailsService.loadUserByUsername(username);
                UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
                    userDetails, null, userDetails.getAuthorities()
                );
                SecurityContextHolder.getContext().setAuthentication(auth);
            } catch (UsernameNotFoundException e) {
                // Do nothing
            }
        }

        chain.doFilter(request, response);
    }

    private String getToken(HttpServletRequest request) {
        String header = request.getHeader(HEADER);
        return StringUtils.hasText(header) && header.startsWith(BEARER) ?
               header.substring(BEARER.length()) :
               null;
    }
}
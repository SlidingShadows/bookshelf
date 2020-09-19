package me.slidingshadows.bookshelf.api.config.jwt;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Component
public class Provider {

    @Value("$(bookshelf.jwt.secret)")
    private String secret;

    @Value("#{new Integer('${bookshelf.jwt.period}')}")
    private Integer period;

    public String generateToken(String username) {
        Date date = Date.from(LocalDate.now().plusDays(period).atStartOfDay(ZoneId.systemDefault()).toInstant());
        return Jwts.builder()
                .setSubject(username)
                .setExpiration(date)
                .signWith(SignatureAlgorithm.HS512, secret)
                .compact();
    }

    public boolean valdateToken(String token) {
        try {
            Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token);
            return true;
        } catch (Exception e) {

        }

        return false;
    }

    public String getUsernameFromToken(String token) {
        Claims claims = Jwts.parser()
            .setSigningKey(secret)
            .parseClaimsJws(token)
            .getBody();

        return claims.getSubject();
    }
}
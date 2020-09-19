package me.slidingshadows.bookshelf.api.config;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import me.slidingshadows.bookshelf.api.domain.User;

public class BookshelfUserDetails implements UserDetails {
    private static final long serialVersionUID = 5628048113928961524L;

    private String username;
    private String password;
    private Collection<? extends GrantedAuthority> grantedAuthorities;

    public static BookshelfUserDetails fromUser(User user) {
        BookshelfUserDetails userDetails = new BookshelfUserDetails();

        userDetails.username = user.getUsername();
        userDetails.password = user.getPassword();
        userDetails.grantedAuthorities = Collections.singletonList(
            new SimpleGrantedAuthority(user.getRole().getName())
        );

        return userDetails;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return grantedAuthorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
    
}

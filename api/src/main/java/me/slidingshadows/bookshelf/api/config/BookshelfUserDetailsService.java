package me.slidingshadows.bookshelf.api.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import me.slidingshadows.bookshelf.api.domain.User;
import me.slidingshadows.bookshelf.api.services.UserService;

@Component
public class BookshelfUserDetailsService implements UserDetailsService {

    @Autowired
    UserService userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userService.findByUsername(username);
        return BookshelfUserDetails.fromUser(user);
    }

}

package me.slidingshadows.bookshelf.api.services;

import me.slidingshadows.bookshelf.api.repositories.UserRepository;
import me.slidingshadows.bookshelf.api.repositories.RoleRepository;
import me.slidingshadows.bookshelf.api.domain.User;
import me.slidingshadows.bookshelf.api.domain.Role;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;
    
    @Autowired
    PasswordEncoder passwordEncoder;

    public User saveUser(User user, String password, String roleName) {
        Role role = roleRepository.findByName(roleName);
        user.setRole(role);
        user.setPassword(passwordEncoder.encode(password));
        return userRepository.save(user);
    }

    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public User findByCredentials(String username, String password) {
        User user = findByUsername(username);

        if ((user != null) && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }

        return null;
    }
}

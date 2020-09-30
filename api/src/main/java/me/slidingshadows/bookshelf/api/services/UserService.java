package me.slidingshadows.bookshelf.api.services;

import me.slidingshadows.bookshelf.api.repositories.UserRepository;
import me.slidingshadows.bookshelf.api.requests.LoginRequest;
import me.slidingshadows.bookshelf.api.responses.LoginResponse;
import me.slidingshadows.bookshelf.api.repositories.RoleRepository;
import me.slidingshadows.bookshelf.api.domain.User;
import me.slidingshadows.bookshelf.api.config.jwt.Provider;
import me.slidingshadows.bookshelf.api.domain.Role;

import org.springframework.stereotype.Service;

import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validator;

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

    @Autowired
    Provider provider;

    @Autowired
    Validator validator;

    public User saveUser(User user, String password, String roleName) {
        Role role = roleRepository.findByName(roleName);
        user.setRole(role);
        user.setPassword(passwordEncoder.encode(password));
        return userRepository.save(user);
    }

    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public LoginResponse login(LoginRequest request) {
        LoginResponse response = new LoginResponse();
        Set<ConstraintViolation<LoginRequest>> violations = validator.validate(request);

        if (!violations.isEmpty()) {
            for (ConstraintViolation<LoginRequest> violation : violations) {
                response.addError(violation.getPropertyPath().toString(), violation.getMessage());
            }
            
            return response;
        }

        response.setToken(provider.generateToken(request.getUsername()));
        return response;
    }
}

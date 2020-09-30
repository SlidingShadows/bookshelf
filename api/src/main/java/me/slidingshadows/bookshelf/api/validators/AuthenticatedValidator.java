package me.slidingshadows.bookshelf.api.validators;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import me.slidingshadows.bookshelf.api.domain.User;
import me.slidingshadows.bookshelf.api.repositories.UserRepository;
import me.slidingshadows.bookshelf.api.requests.LoginRequest;

public class AuthenticatedValidator implements ConstraintValidator<Authenticated, LoginRequest> {

    @Autowired
    UserRepository userRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public void initialize(Authenticated constraintAnnotation) {
    }

    @Override
    public boolean isValid(LoginRequest request, ConstraintValidatorContext context) {
        User user = userRepository.findByUsername(request.getUsername());

        if (user == null) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("{bookshelf.authenticated.username}")
                .addPropertyNode("username")
                .addConstraintViolation();
            return false;
        }

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("{bookshelf.authenticated.password}")
                .addPropertyNode("username")
                .addConstraintViolation();
            return false;
        }

        return true;
    }
}

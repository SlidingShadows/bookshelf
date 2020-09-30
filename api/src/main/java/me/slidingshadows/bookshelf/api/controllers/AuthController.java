package me.slidingshadows.bookshelf.api.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import me.slidingshadows.bookshelf.api.requests.LoginRequest;
import me.slidingshadows.bookshelf.api.responses.LoginResponse;
import me.slidingshadows.bookshelf.api.services.UserService;

@RestController
public class AuthController {
    
    @Autowired
    UserService userService;

    @PostMapping("/login")
    public LoginResponse login(@RequestBody LoginRequest request) {
        return userService.login(request);
    }
}

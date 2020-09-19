package me.slidingshadows.bookshelf.api.home;

import org.springframework.web.bind.annotation.RestController;

import me.slidingshadows.bookshelf.api.config.jwt.Provider;
import me.slidingshadows.bookshelf.api.domain.User;
import me.slidingshadows.bookshelf.api.services.UserService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

@RestController
@PropertySource("classpath:application.properties")
public class Controller {

    @Autowired
    private Environment env;

    @Autowired
    UserService userService;

    @Autowired
    Provider provider;

	@GetMapping("/")
	public VersionResponse getVersion() {
		return new VersionResponse(
            env.getProperty("bookshelf.build.product"),
            env.getProperty("bookshelf.build.version")
        );
    }
    
    @PostMapping("/login")
    public LoginResponse login(@RequestBody LoginRequest request) {
        User user = userService.findByCredentials(request.getUsername(), request.getPassword());
        String token = provider.generateToken(user.getUsername());
        return new LoginResponse(token);
    }
}
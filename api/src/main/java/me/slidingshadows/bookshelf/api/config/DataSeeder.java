package me.slidingshadows.bookshelf.api.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import me.slidingshadows.bookshelf.api.domain.Role;
import me.slidingshadows.bookshelf.api.domain.User;
import me.slidingshadows.bookshelf.api.repositories.RoleRepository;
import me.slidingshadows.bookshelf.api.services.UserService;

@Component
public class DataSeeder {
    
    @Autowired
    private RoleRepository roleRepository;
    
    @Autowired
    private UserService userService;

    @EventListener
    public void appReady(ApplicationReadyEvent event) {

        // seed admin role
        Role role = roleRepository.findByName("ADMIN");

        if (role == null) {
            role = new Role();
            role.setName("ADMIN");
            roleRepository.save(role);
        }

        // seed admin

        User admin = userService.findByUsername("admin");

        if (admin == null) {
            admin = new User();
            admin.setUsername("admin");
            userService.saveUser(admin, "12345qwerty@", "ADMIN");
        }
    }
}

package me.slidingshadows.bookshelf.api.repositories;

import me.slidingshadows.bookshelf.api.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);
}

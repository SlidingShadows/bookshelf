package me.slidingshadows.bookshelf.api.repositories;

import me.slidingshadows.bookshelf.api.domain.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Integer> {
    Role findByName(String name);
}

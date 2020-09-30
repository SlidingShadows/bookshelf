package me.slidingshadows.bookshelf.api.requests;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import me.slidingshadows.bookshelf.api.validators.Authenticated;

@Authenticated
public class LoginRequest extends BaseRequest {
    @NotNull(message = "{bookshelf.login.username.null}")
    @Size(min = 2, message = "{bookshelf.login.username.size}")
    private String username;

    @NotNull(message = "{bookshelf.login.password.null}")
    @Size(min = 2, message = "{bookshelf.login.password.size}")
    private String password;

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}

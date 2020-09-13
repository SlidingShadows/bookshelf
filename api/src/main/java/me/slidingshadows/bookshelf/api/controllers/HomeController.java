package me.slidingshadows.bookshelf.api.controllers;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

@RestController
@PropertySource("classpath:application.properties")
public class HomeController {

    @Autowired
    private Environment env;

	@RequestMapping("/")
	public Version index() {
		return new Version(
            env.getProperty("bookshelf.build.product"),
            env.getProperty("bookshelf.build.version")
        );
	}

    public class Version {
        private String product;
        private String version;

        public Version(String product, String version) {
            this.product = product;
            this.version = version;
        }

        public String getProduct () {
            return product;
        }

        public String getVersion() {
            return version;
        }
    }
}
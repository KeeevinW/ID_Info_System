package com.example.ID_Info_System.AES;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

@Configuration
public class AESKeyConfig {

    @Value("${spring.aes.secret_key}")
    private String secretKeyBase64;


    @Bean
    public SecretKey secretKey() throws Exception{
        byte[] keyBytes = Base64.getDecoder().decode(secretKeyBase64);
        return new SecretKeySpec(keyBytes, 0, keyBytes.length, "AES");
    }

}

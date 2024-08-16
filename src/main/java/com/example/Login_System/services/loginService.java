package com.example.Login_System.services;

import com.example.Login_System.mappers.LoginMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@Service
public class loginService {

    private final SecretKey secretKey;

    @Autowired
    private LoginMapper loginMapper;

    @Autowired
    public loginService(SecretKey secretKey) {
        this.secretKey = secretKey;
    }

    public String registerNewUser(String username, String password){
        password = encrypt(password);
        try {
            loginMapper.RegisterNewUser(username, password); //TODO: when the username already exists
        }catch (DuplicateKeyException e){
            return "Failed to register: duplicate username";
        }
        return "Register Successfully";
    }

    public Boolean LoginToAccount(String username, String password){
        String correct_password = loginMapper.getPassword(username);
        try {
            correct_password = decrypt(correct_password);
        }catch (NullPointerException e){
            return false;
        }
        return password.equals(correct_password);
    }

    public Boolean isAdmin(String username){
        return loginMapper.isAdmin(username);
    }


    //Encrypt the text (id)
    public String encrypt(String secretMessage){
        try{
            Cipher encryptCipher = Cipher.getInstance("AES");
            encryptCipher.init(Cipher.ENCRYPT_MODE, secretKey);
            byte[] secretMessageBytes = secretMessage.getBytes(StandardCharsets.UTF_8);
            byte[] encryptedMessageBytes = encryptCipher.doFinal(secretMessageBytes);
            return Base64.getEncoder().encodeToString(encryptedMessageBytes);

        }catch (Exception e){
            throw new RuntimeException("Error encrypting data", e);
        }

    }

    //decrypt the text (id)
    public String decrypt(String encryptedMessage){
        byte[] encryptedMessageBytes = Base64.getDecoder().decode(encryptedMessage);
        try{
            Cipher decryptCipher = Cipher.getInstance("AES");
            decryptCipher.init(Cipher.DECRYPT_MODE, secretKey);
            byte[] decryptedMessageBytes = decryptCipher.doFinal(encryptedMessageBytes);
            return new String(decryptedMessageBytes, StandardCharsets.UTF_8);
        }catch (Exception e){
            throw new RuntimeException("Error decrypting data", e);
        }
    }

}

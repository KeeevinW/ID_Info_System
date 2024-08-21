package com.example.ID_Info_System.services;

import com.example.ID_Info_System.mappers.LoginMapper;
import com.example.ID_Info_System.model.User;
import com.example.ID_Info_System.model.User_Info;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Map;

@Service
public class loginService {

    private final SecretKey secretKey;

    @Autowired
    private LoginMapper loginMapper;

    @Autowired
    private apiService apiService;

    @Autowired
    public loginService(SecretKey secretKey) {
        this.secretKey = secretKey;
    }


    public String registerNewUser(String phoneNum, String username, String password, String ID){
        password = encrypt(password);
        try {
            String apiUrl = "http://localhost:8080/api/addNew/"+username+"/"+ID;
            String result = apiService.addNewUser(apiUrl);
            if(!result.equals("success")){
                return "failed to register the User";
            }
            loginMapper.RegisterNewUser(phoneNum, username, password);
        }catch (DuplicateKeyException e){
            return "Failed to register: the User already exists";
        }
        return "Register Successfully";
    }

    public Boolean LoginToAccount(String username, String password){
        String correct_password = loginMapper.getPassword(username);
        try {
            correct_password = decrypt(correct_password);
        }catch (NullPointerException e){ //when no such User
            return false;
        }
        return password.equals(correct_password);
    }

    public Boolean isAdmin(String username){
        return loginMapper.isAdmin(username);
    }

    public String getUsername(String usernameOrPhoneNum){
        return loginMapper.getUsername(usernameOrPhoneNum);
    }

    public Map<String, String> getInfoByName(String username){
        String apiUrl = "http://localhost:8080/api/getInfo/"+username;
        return apiService.getInfoByName(apiUrl);
    }

    public void makeAdmin(String username){
        loginMapper.makeAdmin(username);
    }

    public ArrayList<User> getAll(){ //get all login info (username, password, phone number...)
        ArrayList<User> response = loginMapper.getAll();
        for(User user : response){
            user.setPassword(decrypt(user.getPassword()));
        }
        return response;
    }

    public ArrayList<User_Info> getAllInfo() {//get all user info (ID number, address, date of birth...)
        String apiUrl = "http://localhost:8080/api/getAllInfo";
        return apiService.getAllInfo(apiUrl);

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

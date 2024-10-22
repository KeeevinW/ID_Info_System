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
            String apiUrl = "http://localhost:8080/api/addNew/"+username+"/"+ID+"/"+phoneNum;
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

    public String LoginToAccount(String username, String password){

        ArrayList<String> allPassword = loginMapper.getPassword(username);
        if(allPassword.size()!=1){
            return "There are more than one password";
        }

        String correct_password = allPassword.get(0);
        try {
            correct_password = decrypt(correct_password);
        }catch (NullPointerException e){ //when no such User
            return "There is no such user";
        }
        if(password.equals(correct_password)){
            return "Successfully logged in";
        }else{
            return "Incorrect password";
        }
    }

    public Boolean isAdmin(String username){
        return loginMapper.isAdmin(username);
    }

    public String getUsername(String usernameOrPhoneNum){
        return loginMapper.getUsername(usernameOrPhoneNum);
    }

    public Map<String, String> getInfoByName(String nameOrPhoneNum){
        String apiUrl = "http://localhost:8080/api/getInfo/"+nameOrPhoneNum;
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

    public void resetPassword(String phoneNum){
        String password = encrypt("12345678");
        loginMapper.setPassword(phoneNum, password);
    }

    public void setPassword(String nameOrPhone, String password){
        password = encrypt(password);
        loginMapper.setPassword(nameOrPhone, password);
    }

    public String deleteUser(String phoneNum){
        String apiUrl = "http://localhost:8080/api/deleteUser/"+phoneNum;
        String result = apiService.deleteUser(apiUrl);
        if(!result.equals("User deleted")){
            return "failed to delete User";
        }else{
            loginMapper.deleteUser(phoneNum);
        }
        return result;
    }

    public String updateUser(String phoneNum, String username, String password, String ID, Boolean isAdmin){
        String apiUrl = "http://localhost:8080/api/updateUser?username=" + username + "&phoneNum=" + phoneNum + "&ID=" + ID;
        String result = apiService.updateUser(apiUrl);

        password = encrypt(password);
        if(result.equals("User updated")){
            loginMapper.updateUser(phoneNum, username, password, isAdmin);
            return "User updated";
        }else{
            return result;
        }
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

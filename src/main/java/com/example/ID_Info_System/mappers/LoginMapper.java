package com.example.ID_Info_System.mappers;

import com.example.ID_Info_System.model.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface LoginMapper {

    void RegisterNewUser(String phoneNum, String username, String password);

    ArrayList<String> getPassword(String username);

    String getUsername(String str); //str could be username or phone number

    Boolean isAdmin(String username);

    void makeAdmin(String username);

    ArrayList<User> getAll();

    void setPassword(String nameOrPhone, String password);

    void deleteUser(String phoneNum);

    void updateUser(String phoneNum, String username, String password, Boolean isAdmin);
}

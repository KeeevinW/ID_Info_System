package com.example.ID_Info_System.mappers;

import com.example.ID_Info_System.model.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface LoginMapper {

    void RegisterNewUser(String phoneNum, String username, String password);

    String getPassword(String username);

    String getUsername(String str);

    Boolean isAdmin(String username);

    void makeAdmin(String username);

    ArrayList<User> getAll();

    void setPassword(String username, String password);

    void deleteUser(String phoneNum);
}

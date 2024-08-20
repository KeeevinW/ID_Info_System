package com.example.Login_System.mappers;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMapper {

    void RegisterNewUser(String phoneNum, String username, String password);

    String getPassword(String username);

    String getUsername(String str);

    Boolean isAdmin(String username);

}

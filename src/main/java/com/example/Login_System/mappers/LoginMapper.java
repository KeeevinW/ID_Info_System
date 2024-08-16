package com.example.Login_System.mappers;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMapper {

    public void RegisterNewUser(String phoneNum, String username, String password);

    public String getPassword(String username);

    public String getUsername(String str);

    public Boolean isAdmin(String username);

}

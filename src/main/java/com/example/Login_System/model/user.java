package com.example.Login_System.model;

//serves as a DTO
public class user {
    private String username;
    private String password;
    private String phoneNum;

    public user(String username, String password, String phoneNum) {
        this.username = username;
        this.password = password;
        this.phoneNum = phoneNum;
    }

    public user(String username, String password) { // can't distinguish between phone number or username, I'll just treat it as a username
        this.username = username;
        this.password = password;
        this.phoneNum = null;
    }

    public user() {}

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }
}

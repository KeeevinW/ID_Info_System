package com.example.Login_System.model;

//serves as a DTO
public class User {
    private String username;
    private String password;
    private String phoneNum;
    private String id;

    public User(String username, String password, String phoneNum, String id) {
        this.username = username;
        this.password = password;
        this.phoneNum = phoneNum;
        this.id = id;
    }

    public User(String username, String password) { // can't distinguish between phone number or username, I'll just treat it as a username
        this.username = username;
        this.password = password;
        this.phoneNum = null;
        this.id = null;
    }

    public User() {}

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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}

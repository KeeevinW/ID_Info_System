package com.example.ID_Info_System.model;

public class User_Info {
    private String User_ID;
    private String username;
    private String User_Birthday;
    private String User_Address;

    public User_Info(String User_ID, String username, String User_Birthday, String User_Address) {
        this.User_ID = User_ID;
        this.username = username;
        this.User_Birthday = User_Birthday;
        this.User_Address = User_Address;
    }

    public String getUser_ID() {
        return User_ID;
    }

    public void setUser_ID(String User_ID) {
        this.User_ID = User_ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUser_Birthday() {
        return User_Birthday;
    }

    public void setUser_Birthday(String User_Birthday) {
        this.User_Birthday = User_Birthday;
    }

    public String getUser_Address() {
        return User_Address;
    }

    public void setUser_Address(String User_Address) {
        this.User_Address = User_Address;
    }
}

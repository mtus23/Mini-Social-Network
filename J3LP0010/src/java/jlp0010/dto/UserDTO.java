/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0010.dto;

import java.io.Serializable;

/**
 *
 * @author DELL
 */
public class UserDTO implements Serializable{
    private String mail;
    private String name;
    private String password;
    private String role;
    private int statusId;

    public UserDTO() {
    }

    public UserDTO(String mail, String name, String password, String role, int statusId) {
        this.mail = mail;
        this.name = name;
        this.password = password;
        this.role = role;
        this.statusId = statusId;
    }

    public UserDTO(String mail, String name, String password) {
        this.mail = mail;
        this.name = name;
        this.password = password;
    }

    public UserDTO(String mail, String name, String role, int statusId) {
        this.mail = mail;
        this.name = name;
        this.role = role;
        this.statusId = statusId;
    }

    
    
    

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }
    
    
}

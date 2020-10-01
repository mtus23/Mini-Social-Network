/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0010.dto;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author DELL
 */
public class ArticleDTO implements Serializable {

    private int postId;
    private String image;
    private String title;
    private String description;
    private String mail;
    private int status;
    private Date date;

    public ArticleDTO() {
    }

    public ArticleDTO(int postId, String image, String title, String description, String mail, int status, Date date) {
        this.postId = postId;
        this.image = image;
        this.title = title;
        this.description = description;
        this.mail = mail;
        this.status = status;
        this.date = date;
    }

    public ArticleDTO(int postId, String image, String title, String description, String mail, Date date) {
        this.postId = postId;
        this.image = image;
        this.title = title;
        this.description = description;
        this.mail = mail;
        this.date = date;
    }

    public ArticleDTO(int postId, String image, String title, String description) {
        this.postId = postId;
        this.image = image;
        this.title = title;
        this.description = description;
    }

    public ArticleDTO(String image, String title, String description, String mail, Date date) {
        this.image = image;
        this.title = title;
        this.description = description;
        this.mail = mail;
        this.date = date;
    }

    public ArticleDTO(int postId, String image, String title, String description, String mail) {
        this.postId = postId;
        this.image = image;
        this.title = title;
        this.description = description;
        this.mail = mail;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

}

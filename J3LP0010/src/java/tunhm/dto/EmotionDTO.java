/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.dto;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author DELL
 */
public class EmotionDTO implements Serializable{
    private int id;
    private int postId;
    private String mail;
    private boolean likes;
    private boolean dislikes;
    private Date date;

    public EmotionDTO(int id, int postId, String mail, boolean likes, boolean dislikes, Date date) {
        this.id = id;
        this.postId = postId;
        this.mail = mail;
        this.likes = likes;
        this.dislikes = dislikes;
        this.date = date;
    }

    public EmotionDTO(int postId, String mail, boolean likes, boolean dislikes) {
        this.postId = postId;
        this.mail = mail;
        this.likes = likes;
        this.dislikes = dislikes;
    }

    public EmotionDTO(int postId, String mail, boolean likes, boolean dislikes, Date date) {
        this.postId = postId;
        this.mail = mail;
        this.likes = likes;
        this.dislikes = dislikes;
        this.date = date;
    }
    

    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public boolean isLikes() {
        return likes;
    }

    public void setLikes(boolean likes) {
        this.likes = likes;
    }

    public boolean isDislikes() {
        return dislikes;
    }

    public void setDislikes(boolean dislikes) {
        this.dislikes = dislikes;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
    
    
}

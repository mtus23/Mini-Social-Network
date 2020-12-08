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
public class CommentDTO implements Serializable{
    private int cmtId;
    private int postId;
    private String mail;
    private String cmtContent;
    private Date date;
    private int status;

    public CommentDTO(int cmtId, int postId, String mail, String cmtContent, Date date, int status) {
        this.cmtId = cmtId;
        this.postId = postId;
        this.mail = mail;
        this.cmtContent = cmtContent;
        this.date = date;
        this.status = status;
    }

    public CommentDTO(int postId, String mail, String cmtContent, Date date) {
        this.postId = postId;
        this.mail = mail;
        this.cmtContent = cmtContent;
        this.date = date;
    }

    public CommentDTO(int cmtId, int postId, String mail, String cmtContent, Date date) {
        this.cmtId = cmtId;
        this.postId = postId;
        this.mail = mail;
        this.cmtContent = cmtContent;
        this.date = date;
    }

    public CommentDTO(int cmtId, int postId, String mail) {
        this.cmtId = cmtId;
        this.postId = postId;
        this.mail = mail;
    }
    
    

    public int getCmtId() {
        return cmtId;
    }

    public void setCmtId(int cmtId) {
        this.cmtId = cmtId;
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

    public String getCmtContent() {
        return cmtContent;
    }

    public void setCmtContent(String cmtContent) {
        this.cmtContent = cmtContent;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}

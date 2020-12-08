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
public class NotiDTO implements Serializable{
    private int notiId;
    private int postId;
    private String mail;
    private Date date;
    private String type;
    private int status;
    private int cmtId;

    public NotiDTO(int notiId, int postId, String mail, Date date, String type, int status) {
        this.notiId = notiId;
        this.postId = postId;
        this.mail = mail;
        this.date = date;
        this.type = type;
        this.status = status;
    }

    public NotiDTO(int postId, String mail, Date date, String type) {
        this.postId = postId;
        this.mail = mail;
        this.date = date;
        this.type = type;
    }

    public NotiDTO(int notiId, int postId, String mail, Date date, String type) {
        this.notiId = notiId;
        this.postId = postId;
        this.mail = mail;
        this.date = date;
        this.type = type;
    }

    public NotiDTO(int notiId, int postId, String mail, Date date, String type, int status, int cmtId) {
        this.notiId = notiId;
        this.postId = postId;
        this.mail = mail;
        this.date = date;
        this.type = type;
        this.status = status;
        this.cmtId = cmtId;
    }

    public NotiDTO(int postId, String mail, Date date, String type, int cmtId) {
        this.postId = postId;
        this.mail = mail;
        this.date = date;
        this.type = type;
        this.cmtId = cmtId;
    }

    public NotiDTO(int notiId, int cmtId) {
        this.notiId = notiId;
        this.cmtId = cmtId;
    }

    public int getNotiId() {
        return notiId;
    }

    public void setNotiId(int notiId) {
        this.notiId = notiId;
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCmtId() {
        return cmtId;
    }

    public void setCmtId(int cmtId) {
        this.cmtId = cmtId;
    }

}

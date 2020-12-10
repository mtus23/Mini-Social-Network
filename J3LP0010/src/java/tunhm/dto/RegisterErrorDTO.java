/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.dto;

import java.io.Serializable;

/**
 *
 * @author DELL
 */
public class RegisterErrorDTO implements Serializable{
   private String errorMail, errorName, errorPassword, errorConfirmPassword;

    public RegisterErrorDTO() {
        this.errorMail = "";
        this.errorName = "";
        this.errorPassword = "";
        this.errorConfirmPassword = "";
    }

    public RegisterErrorDTO(String errorMail, String errorName, String errorPassword, String errorConfirmPassword) {
        this.errorMail = errorMail;
        this.errorName = errorName;
        this.errorPassword = errorPassword;
        this.errorConfirmPassword = errorConfirmPassword;
    }

    public String getErrorMail() {
        return errorMail;
    }

    public void setErrorMail(String errorMail) {
        this.errorMail = errorMail;
    }

    public String getErrorName() {
        return errorName;
    }

    public void setErrorName(String errorName) {
        this.errorName = errorName;
    }

    public String getErrorPassword() {
        return errorPassword;
    }

    public void setErrorPassword(String errorPassword) {
        this.errorPassword = errorPassword;
    }

    public String getErrorConfirmPassword() {
        return errorConfirmPassword;
    }

    public void setErrorConfirmPassword(String errorConfirmPassword) {
        this.errorConfirmPassword = errorConfirmPassword;
    }
 
}

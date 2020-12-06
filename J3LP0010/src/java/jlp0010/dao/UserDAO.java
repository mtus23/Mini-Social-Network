/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0010.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import jlp0010.dto.UserDTO;
import jlp0010.util.DBUtil;
import jlp0010.util.PasswordEncrypter;

/**
 *
 * @author DELL
 */
public class UserDAO implements Serializable {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;
    PasswordEncrypter pe = new PasswordEncrypter();

    public UserDAO() {
    }

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public UserDTO checkLogin(String mail, String password) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO dto = null;
        try {
            String sql = "SELECT name, role, status FROM tblUser WHERE mail = ? AND password = ? AND (status = 1 OR status = 2)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, mail);
            stm.setString(2, pe.getEncryptedPassword(password));
            rs = stm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String role = rs.getString("role");
                int status = rs.getInt("status");
                dto = new UserDTO(mail, name, role, status);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public boolean register(UserDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblUser(mail, name, password, role, status) VALUES (?,?,?,?,?)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, dto.getMail());
            stm.setString(2, dto.getName());
            stm.setString(3, pe.getEncryptedPassword(dto.getPassword()));
            stm.setString(4, "member");
            stm.setInt(5, 1);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkDuplicated(String mail) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "SELECT mail FROM tblUser WHERE mail = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, mail);
            rs = stm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public UserDTO getUser(String mail) throws SQLException, ClassNotFoundException, NamingException {
        UserDTO result = null;
        try {
            String sql = "SELECT name FROM tblUser WHERE mail = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, mail);
            rs = stm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                result = new UserDTO(mail, name);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

}

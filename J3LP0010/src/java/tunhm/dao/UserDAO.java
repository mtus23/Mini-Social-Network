/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import tunhm.dto.UserDTO;
import tunhm.util.DBUtil;
import tunhm.util.PasswordEncrypter;

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
            String sql = "SELECT name, role, statusId FROM tblUser WHERE mail = ? AND password = ? AND (statusId = 1 OR statusId = 2)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, mail);
            stm.setString(2, pe.getEncryptedPassword(password));
            rs = stm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String role = rs.getString("role");
                int status = rs.getInt("statusId");
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
            String sql = "INSERT INTO tblUser(mail, name, password, role, statusId, activeKey) VALUES (?,?,?,?,?,?)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, dto.getMail());
            stm.setString(2, dto.getName());
            stm.setString(3, pe.getEncryptedPassword(dto.getPassword()));
            stm.setString(4, "member");
            stm.setInt(5, 1);
            stm.setString(6, dto.getActiveKey());
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

    public boolean updateActivationCode(String code, String email) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblUser SET activeKey = ? WHERE mail = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, code);
            stm.setString(2, email);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkActiveCode(String code, String email) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "SELECT mail FROM tblUser WHERE activeKey = ? AND mail = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, code);
            stm.setString(2, email);
            rs = stm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean activeAccount(String email) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblUser SET statusId = 2 WHERE mail = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, email);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
}

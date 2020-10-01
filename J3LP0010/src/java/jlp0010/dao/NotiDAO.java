/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0010.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import jlp0010.dto.NotiDTO;
import jlp0010.dto.UserDTO;
import jlp0010.util.DBUtil;

/**
 *
 * @author DELL
 */
public class NotiDAO implements Serializable {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

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

    public boolean addNoti(NotiDTO noti) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblNoti(postId, mail, date, type, cmtId, status) "
                    + "VALUES(?,?,?,?,?,5)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, noti.getPostId());
            stm.setString(2, noti.getMail());
            stm.setDate(3, noti.getDate());
            stm.setString(4, noti.getType());
            stm.setInt(5, noti.getCmtId());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<NotiDTO> getNotiByUser(UserDTO user) throws SQLException, ClassNotFoundException, NamingException {
        List<NotiDTO> result = null;
        try {
            String sql = "SELECT notiId, tblArticle.postId, tblNoti.date, type, tblNoti.mail , tblNoti.status , cmtId "
                    + "FROM tblNoti JOIN tblArticle on tblArticle.postId = tblNoti.postId "
                    + "WHERE tblNoti.status != 3 AND tblArticle.mail = ? ORDER BY date DESC";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, user.getMail());
            rs = stm.executeQuery();
            while (rs.next()) {
                if (result == null) {
                    result = new ArrayList<>();
                }
                int notiId = rs.getInt("notiId");
                int postId = rs.getInt("postId");
                Date date = rs.getDate("date");
                String type = rs.getString("type");
                String mail = rs.getString("mail");
                int status = rs.getInt("status");
                int cmtId = rs.getInt("cmtId");
                result.add(new NotiDTO(notiId, postId, mail, date, type, status, cmtId));
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public NotiDTO findNoti(int postId, String mail, String type) throws SQLException, ClassNotFoundException, NamingException {
        NotiDTO result = null;
        try {
            String sql = "SELECT notiId, date FROM tblNoti "
                    + "WHERE postId = ? AND mail = ? AND type = ? AND status != 3";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, postId);
            stm.setString(2, mail);
            stm.setString(3, type);
            rs = stm.executeQuery();
            if (rs.next()) {
                int notiId = rs.getInt("notiId");
                Date date = rs.getDate("date");
                result = new NotiDTO(notiId, postId, mail, date, type);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean deleteNoti(NotiDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblNoti SET status = 3 WHERE notiId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, dto.getNotiId());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public NotiDTO getNotiCmtId(int notiId) throws SQLException, ClassNotFoundException, NamingException {
        NotiDTO result = null;
        try {
            String sql = "SELECT cmtId FROM tblNoti WHERE notiId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, notiId);
            rs = stm.executeQuery();
            if (rs.next()) {
                int cmtId = rs.getInt("cmtId");
                result = new NotiDTO(notiId, cmtId);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean editNotiAsRead(int notiId) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblNoti SET status = 4 WHERE notiId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, notiId);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import tunhm.dto.NotiDTO;
import tunhm.dto.UserDTO;
import tunhm.util.DBUtil;

/**
 *
 * @author DELL
 */
public class NotiDAO implements Serializable {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public NotiDAO() {
        con = null;
        stm = null;
        rs = null;
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

    public boolean addNoti(NotiDTO noti) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblNoti(postId, mail, date, type, cmtId, status) "
                    + "VALUES(?,?,?,?,?,?)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, noti.getPostId());
            stm.setString(2, noti.getMail());
            stm.setDate(3, noti.getDate());
            stm.setString(4, noti.getType());
            stm.setInt(5, noti.getCmtId());
            stm.setString(6, "unread");
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<NotiDTO> getNotiByUser(UserDTO user, int currentPage, int rowsPerPage) throws SQLException, ClassNotFoundException, NamingException {
        List<NotiDTO> result = null;
        try {
            String sql = "SELECT notiId, tblArticle.postId, tblNoti.date, type, tblNoti.mail , tblNoti.status , cmtId "
                    + "FROM tblNoti JOIN tblArticle on tblArticle.postId = tblNoti.postId "
                    + "WHERE tblNoti.status != 'delete' AND tblArticle.mail = ? ORDER BY date DESC "
                    + "OFFSET ? * ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, user.getMail());
            stm.setInt(2, currentPage - 1);
            stm.setInt(3, rowsPerPage);
            stm.setInt(4, rowsPerPage);
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
                String status = rs.getString("status");
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
                    + "WHERE postId = ? AND mail = ? AND type = ? AND status != 'delete'";
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
            String sql = "UPDATE tblNoti SET status = 'delete' WHERE notiId = ?";
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
            String sql = "UPDATE tblNoti SET status = 'read' WHERE notiId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, notiId);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean deleteNotiInPost(int postId) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblNoti SET status = 'delete' WHERE postId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, postId);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean deleteNotiCmt(int cmtId) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblNoti SET status = 'delete' WHERE cmtId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, cmtId);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public int countNoti(String mail) throws SQLException, ClassNotFoundException, NamingException {
        int result = 0;
        try {
            String sql = "SELECT COUNT(notiId) AS NumberOfNoti "
                    + "FROM tblNoti JOIN tblArticle on tblArticle.postId = tblNoti.postId "
                    + "WHERE tblNoti.status != 'delete' AND tblArticle.mail = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, mail);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("NumberOfNoti");
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}

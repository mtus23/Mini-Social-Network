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
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;
import tunhm.dto.CommentDTO;
import tunhm.util.DBUtil;

/**
 *
 * @author DELL
 */
public class CommentDAO implements Serializable{
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

    public List<CommentDTO> getCommentInPost(int postId) throws SQLException, ClassNotFoundException, NamingException {
        List<CommentDTO> result = null;
        try {
            String sql = "SELECT mail, cmtContent, date, cmtId"
                    + " FROM tblComment WHERE postId = ? "
                    + "AND status = 2"
                    + " ORDER BY date ASC";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, postId);
            rs = stm.executeQuery();
            while (rs.next()) {
                if (result == null) {
                    result = new ArrayList<>();
                }
                String mail = rs.getString("mail");
                String cmt = rs.getNString("cmtContent");
                Date date = rs.getDate("date");
                int cmtId = rs.getInt("cmtId");
                CommentDTO cmtDTO = new CommentDTO(cmtId, postId, mail, cmt, date);
                result.add(cmtDTO);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean addComment(CommentDTO cmt) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblComment(postId, mail, cmtContent, date, status) VALUES(?,?,?,?,2)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, cmt.getPostId());
            stm.setString(2, cmt.getMail());
            stm.setNString(3, cmt.getCmtContent());
            stm.setDate(4, cmt.getDate());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean deleteComment(int cmtId) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblComment SET status = 3 WHERE cmtId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, cmtId);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
    
    public CommentDTO getCommentById(int cmtId, int postId) throws SQLException, ClassNotFoundException, NamingException{
        CommentDTO result = null;
        try{
            String sql = "SELECT mail FROM tblComment WHERE cmtId = ? AND status = 2 AND postId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, cmtId);
            stm.setInt(2, postId);
            rs = stm.executeQuery();
            if(rs.next()){
                String mail = rs.getString("mail");
                result = new CommentDTO(cmtId, postId, mail);
            }
        } finally{
            closeConnection();
        }
        return result;
    }

    public int getLastCommentId() throws SQLException, ClassNotFoundException, NamingException {
        int result = 0;
        try {
            String sql = "SELECT TOP 1 cmtId FROM tblComment ORDER BY cmtId DESC";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("cmtId");
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public HashMap<Integer, String> getCmtContentByNotiUserMail(String mail) throws SQLException, ClassNotFoundException, NamingException {
        HashMap<Integer, String> result = null;
        try {
            String sql = "SELECT cmtContent, notiId "
                    + "FROM tblComment JOIN tblNoti ON tblNoti.cmtId = tblComment.cmtId "
                    + "JOIN tblArticle ON tblArticle.postId = tblNoti.postId "
                    + "WHERE tblArticle.mail = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, mail);
            rs = stm.executeQuery();
            while (rs.next()) {
                if (result == null) {
                    result = new HashMap<>();
                }
                String cmtContent = rs.getString("cmtContent");
                int notiId = rs.getInt("notiId");
                result.put(notiId, cmtContent);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

}

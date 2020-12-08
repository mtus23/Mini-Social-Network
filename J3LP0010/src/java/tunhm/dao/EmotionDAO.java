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
import java.util.HashMap;
import javax.naming.NamingException;
import tunhm.dto.EmotionDTO;
import tunhm.util.DBUtil;

/**
 *
 * @author DELL
 */
public class EmotionDAO implements Serializable{
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

    public boolean createEmotion(EmotionDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblEmotion(postId, mail, likes, dislikes, date) "
                    + "VALUES(?,?,?,?,?)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, dto.getPostId());
            stm.setString(2, dto.getMail());
            stm.setBoolean(3, dto.isLikes());
            stm.setBoolean(4, dto.isDislikes());
            stm.setDate(5, dto.getDate());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean editEmotion(EmotionDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblEmotion "
                    + "SET likes = ? , dislikes =? , date=? "
                    + "WHERE postId=? AND mail =?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setBoolean(1, dto.isLikes());
            stm.setBoolean(2, dto.isDislikes());
            stm.setDate(3, dto.getDate());
            stm.setInt(4, dto.getPostId());
            stm.setString(5, dto.getMail());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public EmotionDTO findEmo(int postId, String mail) throws SQLException, ClassNotFoundException, NamingException {
        EmotionDTO result = null;
        try {
            String sql = "SELECT likes, dislikes "
                    + " FROM tblEmotion"
                    + " WHERE postId= ? AND mail = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, postId);
            stm.setString(2, mail);
            rs = stm.executeQuery();
            if (rs.next()) {
                boolean like = rs.getBoolean("likes");
                boolean dislike = rs.getBoolean("dislikes");
                result = new EmotionDTO(postId, mail, like, dislike);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public HashMap<String, Integer> countEmotion(int postId) throws SQLException, ClassNotFoundException, NamingException {
        HashMap<String, Integer> result = null;
        try {
            String sql = "SELECT (SELECT COUNT(likes) FROM tblEmotion WHERE likes = 1 AND postId = ?) AS Likes,\n"
                    + "	(SELECT COUNT(dislikes) FROM tblEmotion WHERE dislikes = 1 AND postId = ?) AS Dislikes";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, postId);
            stm.setInt(2, postId);
            rs = stm.executeQuery();
            if (rs.next()) {
                int likes = rs.getInt("Likes");
                int dislikes = rs.getInt("Dislikes");
                result = new HashMap<>();
                result.put("Likes", likes);
                result.put("Dislikes", dislikes);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}

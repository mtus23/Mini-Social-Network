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
import jlp0010.dto.ArticleDTO;
import jlp0010.dto.UserDTO;
import jlp0010.util.DBUtil;

/**
 *
 * @author DELL
 */
public class ArticleDAO implements Serializable {

    private Connection con;
    private PreparedStatement stm;
    private ResultSet rs;

    public ArticleDAO() {
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

    public List<ArticleDTO> searchArcticle(String search, int currentPage, int rowsPerPage) throws SQLException, ClassNotFoundException, NamingException {
        List<ArticleDTO> result = null;
        try {
            String sql = "SELECT postId , image , title , description , mail "
                    + "FROM tblArticle "
                    + "WHERE description LIKE ? AND status = 2 "
                    + "ORDER BY date DESC "
                    + "OFFSET ( ? - 1) * ? ROWS "
                    + "FETCH NEXT ? ROWS ONLY";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            stm.setInt(2, currentPage);
            stm.setInt(3, rowsPerPage);
            stm.setInt(4, rowsPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {
                if (result == null) {
                    result = new ArrayList<>();
                }
                int postId = rs.getInt("postId");
                String image = rs.getString("image");
                String title = rs.getNString("title");
                String des = rs.getNString("description");
                String mail = rs.getString("mail");
                ArticleDTO article = new ArticleDTO(postId, image, title, des, mail);
                result.add(article);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean createArticle(ArticleDTO dto) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO tblArticle(title, image, mail, date, description, status)"
                    + " VALUES(?,?,?,?,?,2)";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setNString(1, dto.getTitle());
            stm.setString(2, dto.getImage());
            stm.setString(3, dto.getMail());
            stm.setDate(4, dto.getDate());
            stm.setString(5, dto.getDescription());
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public ArticleDTO getArticleById(int id) throws SQLException, ClassNotFoundException, NamingException {
        ArticleDTO result = null;
        try {
            String sql = "SELECT title, image, mail, date, description "
                    + "FROM tblArticle "
                    + "WHERE postId = ? AND status = 2";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                String title = rs.getNString("title");
                String image = rs.getString("image");
                String mail = rs.getString("mail");
                Date date = rs.getDate("date");
                String des = rs.getNString("description");
                result = new ArticleDTO(id, image, title, des, mail, date);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean checkImage(String image) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "SELECT postId FROM tblArticle WHERE image = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, image);
            rs = stm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public int countArticle(String search) throws SQLException, ClassNotFoundException, NamingException {
        int result = 0;
        try {
            String sql = "SELECT COUNT(postId) AS NumberOfArticle "
                    + "FROM tblArticle "
                    + "WHERE description LIKE ? AND status = 2";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            rs = stm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("NumberOfArticle");
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean deleteArticle(int postId) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE tblArticle SET status = 3 WHERE postId = ?";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, postId);
            check = stm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

}

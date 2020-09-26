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

    public List<ArticleDTO> getAll() throws NamingException, SQLException, ClassNotFoundException {
        List<ArticleDTO> result = null;
        try {
            String sql = "SELECT postId, image, title, mail, status, date, description"
                    + " FROM tblArticle";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
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
                Date date = rs.getDate("date");
                ArticleDTO article = new ArticleDTO(postId, image, title, des, mail, postId, date);
                result.add(article);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<ArticleDTO> searchArcticle(String search) throws SQLException, ClassNotFoundException, NamingException {
        List<ArticleDTO> result = null;
        try {
            String sql = "SELECT postId, image, title, description "
                    + "FROM tblArticle "
                    + "WHERE description LIKE ? AND status = 4 "
                    + "ORDER BY date";
            con = DBUtil.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, "%"+search+"%");
            rs = stm.executeQuery();
            while (rs.next()) {
                if (result == null) {
                    result = new ArrayList<>();
                }
                int postId = rs.getInt("postId");
                String image = rs.getString("image");
                String title = rs.getNString("title");
                String des = rs.getNString("description");
                ArticleDTO article = new ArticleDTO(postId, image, title, des);
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
            String sql = "INSERT INTO tblArticle(title, image, mail, date, description, likes, dislikes, status)"
                    + " VALUES(?,?,?,?,?,0,0,4)";
            con=DBUtil.getConnection();
            stm=con.prepareStatement(sql);
            stm.setNString(1, dto.getTitle());
            stm.setString(2, dto.getImage());
            stm.setString(3, dto.getMail());
            stm.setDate(4, dto.getDate());
            stm.setString(5, dto.getDescription());
            
        } finally {
            closeConnection();
        }
        return check;
    }

}

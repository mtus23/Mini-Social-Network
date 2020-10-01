/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0010.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jlp0010.dao.ArticleDAO;
import jlp0010.dao.CommentDAO;
import jlp0010.dao.NotiDAO;
import jlp0010.dto.ArticleDTO;
import jlp0010.dto.CommentDTO;
import jlp0010.dto.NotiDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class MakeCommentController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(MakeCommentController.class);
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final String ERROR = "error.jsp";
    private final String SUCCESS = "ShowArticleDetailController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            CommentDAO cmtDao = new CommentDAO();
            String mail = request.getParameter("txtMail");
            int postId = Integer.parseInt(request.getParameter("txtId"));
            String cmt = request.getParameter("txtComment");
            NotiDAO notiDao = new NotiDAO();
            ArticleDAO artDao = new ArticleDAO();
            NotiDTO notiDto = null;
            try {
                Date currentDate = new Date(System.currentTimeMillis());
                CommentDTO dto = new CommentDTO(postId, mail, cmt, currentDate);
                boolean check = cmtDao.addComment(dto);
                if (check) {
                    ArticleDTO postOwner = artDao.getArticleById(postId);
                    if (!postOwner.getMail().equals(mail)) {
                        int cmtId = cmtDao.getLastCommentId();
                        notiDto = new NotiDTO(postId, mail, currentDate, "comments", cmtId);
                        notiDao.addNoti(notiDto);
                    }
                    url = SUCCESS;
                }
            } catch (SQLException | NamingException | ClassNotFoundException e) {
                LOG.error(e.toString());
            } finally {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

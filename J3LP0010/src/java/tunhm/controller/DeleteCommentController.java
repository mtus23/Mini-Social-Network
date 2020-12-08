/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tunhm.dao.CommentDAO;
import tunhm.dao.NotiDAO;
import tunhm.dto.CommentDTO;
import tunhm.dto.UserDTO;

/**
 *
 * @author DELL
 */
public class DeleteCommentController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(DeleteCommentController.class);
    private final String ERROR = "error.jsp";
    private final String SUCCESS = "ShowArticleDetailController";
    private final String SEARCH_PAGE = "search.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            CommentDAO dao = new CommentDAO();
            HttpSession session = request.getSession();
            NotiDAO notiDao = new NotiDAO();
            try {
                int cmtId = Integer.parseInt(request.getParameter("txtCmtId"));
                int postId = Integer.parseInt(request.getParameter("txtId"));
                CommentDTO commentDto = dao.getCommentById(cmtId, postId);
                UserDTO user = (UserDTO) session.getAttribute("User");
                if (commentDto == null) {
                    request.setAttribute("deteleCommentFail", "Comment not exist");
                    url = SEARCH_PAGE;
                } else if (user.getRole().equals("admin") || user.getMail().equals(commentDto.getMail())) {
                    dao.deleteComment(cmtId);
                    notiDao.deleteNotiCmt(cmtId);
                    request.setAttribute("deteleCmtSuccess", "Comment is deleted successfully!");
                    url = SUCCESS;
                } else {
                    request.setAttribute("deteleCommentFail", "You cannot delete this comment");
                    url = SEARCH_PAGE;
                }
            } catch (ClassNotFoundException | SQLException | NamingException e) {
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

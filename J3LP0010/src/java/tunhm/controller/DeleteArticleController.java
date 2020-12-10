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
import tunhm.dao.ArticleDAO;
import tunhm.dao.NotiDAO;
import tunhm.dto.ArticleDTO;
import tunhm.dto.UserDTO;

/**
 *
 * @author DELL
 */
public class DeleteArticleController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(DeleteArticleController.class);
    private final String ERROR = "error.jsp";
    private final String SUCCESS = "SearchController";
    private final String SEARCH_PAGE = "search.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            ArticleDAO dao = new ArticleDAO();
            NotiDAO notiDao = new NotiDAO();
            try {
                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                int postId = Integer.parseInt(request.getParameter("txtId"));
                ArticleDTO article = dao.getArticleById(postId);
                if(article == null){
                    request.setAttribute("deleteFail", "Post not exist");
                    url = SEARCH_PAGE;
                }
                else if ((user.getRole().equals("admin") || user.getMail().equals(article.getMail()))) {
                    dao.deleteArticle(postId);
                    notiDao.deleteNotiInPost(postId);
                    request.setAttribute("deleteSuccess", "Article is deleted successfully!");
                    url = SUCCESS;
                }
                else{
                    request.setAttribute("deleteFail", "You cannot delete this post");
                    url = SEARCH_PAGE;
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

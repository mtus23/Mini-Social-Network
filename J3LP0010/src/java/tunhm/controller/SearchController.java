/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import tunhm.dao.ArticleDAO;
import tunhm.dto.ArticleDTO;

/**
 *
 * @author DELL
 */
public class SearchController extends HttpServlet {

    private final static Logger LOG = Logger.getLogger(SearchController.class);
    private final String ERROR = "error.jsp";
    private final String SEARCH_RESULT = "search.jsp";
    private final int ROWS_PER_PAGE = 20;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            String search = request.getParameter("txtSearch");
            String page = request.getParameter("txtCurrentPage");
            int currentPage = 1;
            if (page != null) {
                currentPage = Integer.parseInt(page);
            }
            ArticleDAO dao = new ArticleDAO();
            List<ArticleDTO> searchResult = null;
            try {
                int numOfArticle = dao.countArticle(search);
                int numOfPage = (int) (Math.ceil((numOfArticle * 1.0) / ROWS_PER_PAGE));
                request.setAttribute("searchValue", search);
                if (currentPage > numOfPage || currentPage <= 0) {
                    currentPage = 1;
                }
                searchResult = dao.searchArcticle(search, currentPage, ROWS_PER_PAGE);
                if (searchResult == null) {
                    request.setAttribute("errorSearch", "Content not found");
                } else {
                    request.setAttribute("numberOfPage", numOfPage);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("searchResult", searchResult);
                }
                url = SEARCH_RESULT;
            } catch (SQLException | ClassNotFoundException | NamingException e) {
                LOG.error(e.getMessage());
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

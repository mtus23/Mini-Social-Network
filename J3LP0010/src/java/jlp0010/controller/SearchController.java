/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0010.controller;

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
import javax.servlet.http.HttpSession;
import jlp0010.dao.ArticleDAO;
import jlp0010.dto.ArticleDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class SearchController extends HttpServlet {
    private final static Logger LOG = Logger.getLogger(SearchController.class);
    private final String ERROR = "error.jsp";
    private final String SEARCH_RESULT = "search.jsp";
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
            ArticleDAO dao = new ArticleDAO();
            try{
                HttpSession session = request.getSession();
                List<ArticleDTO> result =  dao.searchArcticle(search);
                session.setAttribute("searchValue", search);
                if(result == null){
                    if(session.getAttribute("searchResult")!=null){
                        session.removeAttribute("searchResult");
                    }
                    session.setAttribute("errorSearch", "Content not found");
                    url=SEARCH_RESULT;
                }
                else{
                    if(session.getAttribute("errorSearch")!=null){
                        session.removeAttribute("errorSearch");
                    }
                    session.setAttribute("searchResult", result);
                    url=SEARCH_RESULT;
                }
            } catch(SQLException | ClassNotFoundException | NamingException e){
                LOG.error(e.getMessage());
            }
            finally{
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

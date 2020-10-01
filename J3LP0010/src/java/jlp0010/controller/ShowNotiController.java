/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jlp0010.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jlp0010.dao.CommentDAO;
import jlp0010.dao.NotiDAO;
import jlp0010.dao.UserDAO;
import jlp0010.dto.NotiDTO;
import jlp0010.dto.UserDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class ShowNotiController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(ShowNotiController.class);
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final String SUCCESS = "showNotiList.jsp";
    private final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            try {
                NotiDAO notiDao = new NotiDAO();
                HttpSession session = request.getSession();
                UserDAO userDao = new UserDAO();
                CommentDAO cmtDao = new CommentDAO();
                UserDTO user = (UserDTO) session.getAttribute("User");
                List<NotiDTO> listNoti = notiDao.getNotiByUser(user);
                if (listNoti != null) {
                    HashMap<Integer, String> mapCmtContent = cmtDao.getCmtContentByNotiUserMail(user.getMail());
                    if (mapCmtContent != null) {
                        request.setAttribute("mapCmtContent", mapCmtContent);
                    }
                    HashMap<String, String> mapName = new HashMap<>();
                    request.setAttribute("listNoti", listNoti);
                    for (NotiDTO notiDto : listNoti) {
                        mapName.put(notiDto.getMail(), (userDao.getUser(notiDto.getMail())).getName());
                    }
                    request.setAttribute("mapNames", mapName);
                } else {
                    request.setAttribute("listNotiEmpty", "Your notification list is empty!!");
                }
                url = SUCCESS;
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

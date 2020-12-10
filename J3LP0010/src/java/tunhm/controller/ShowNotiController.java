/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.controller;

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
import org.apache.log4j.Logger;
import tunhm.dao.CommentDAO;
import tunhm.dao.NotiDAO;
import tunhm.dao.UserDAO;
import tunhm.dto.NotiDTO;
import tunhm.dto.UserDTO;

/**
 *
 * @author DELL
 */
public class ShowNotiController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final Logger LOG = Logger.getLogger(ShowNotiController.class);
    private final String SUCCESS = "showNotiList.jsp";
    private final String ERROR = "error.jsp";
    private final int ROWS_PER_PAGE = 20;

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
                UserDTO user = (UserDTO) session.getAttribute("user");
                String page = request.getParameter("txtCurrentPage");
                int currentPage = 1;
                if (page != null) {
                    currentPage = Integer.parseInt(page);
                }
                int numOfNoti = notiDao.countNoti(user.getMail());
                int numOfPage = (int) (Math.ceil((numOfNoti * 1.0) / ROWS_PER_PAGE));
                if (currentPage > numOfPage || currentPage <= 0) {
                    currentPage = 1;
                }
                List<NotiDTO> listNoti = notiDao.getNotiByUser(user, currentPage, ROWS_PER_PAGE);
                if (listNoti != null) {
                    HashMap<Integer, String> mapCmtContent = cmtDao.getCmtContentByNotiUserMail(user.getMail());
                    if (mapCmtContent != null) {
                        request.setAttribute("mapCmtContent", mapCmtContent);
                    }
                    HashMap<String, String> mapName = new HashMap<>();
                    for (NotiDTO notiDto : listNoti) {
                        mapName.put(notiDto.getMail(), (userDao.getUser(notiDto.getMail())).getName());
                    }
                    request.setAttribute("mapNames", mapName);
                    request.setAttribute("numberOfPage", numOfPage);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("listNoti", listNoti);
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

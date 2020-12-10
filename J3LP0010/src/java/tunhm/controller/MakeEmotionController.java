/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.controller;

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
import org.apache.log4j.Logger;
import tunhm.dao.ArticleDAO;
import tunhm.dao.EmotionDAO;
import tunhm.dao.NotiDAO;
import tunhm.dto.ArticleDTO;
import tunhm.dto.EmotionDTO;
import tunhm.dto.NotiDTO;

/**
 *
 * @author DELL
 */
public class MakeEmotionController extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(MakeEmotionController.class);
    private final String SUCCESS = "ShowArticleDetailController";
    private final String ERROR = "error.jsp";

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
            String mail = request.getParameter("txtMail");
            int postId = Integer.parseInt(request.getParameter("txtId"));
            String emo = request.getParameter("txtEmo");
            EmotionDAO dao = new EmotionDAO();
            NotiDAO notiDao = new NotiDAO();
            ArticleDAO artDao = new ArticleDAO();
            NotiDTO notiDto = null;
            boolean isLike = false;
            boolean isDislike = false;
            if (emo.equals("Like")) {
                isLike = true;
                isDislike = false;
            } else if (emo.equals("Dislike")) {
                isDislike = true;
                isLike = false;
            }
            try {
                Date currentDate = new Date(System.currentTimeMillis());
                EmotionDTO dto = dao.findEmo(postId, mail);
                if (dto != null) {
                    if (dto.isLikes() && isLike) {
                        notiDto = notiDao.findNoti(postId, mail, "likes");
                        isLike = false;
                    } else if (dto.isDislikes() && isDislike) {
                        notiDto = notiDao.findNoti(postId, mail, "dislikes");
                        isDislike = false;
                    }
                    if (notiDto != null) {
                        notiDao.deleteNoti(notiDto);
                    }
                    dto = new EmotionDTO(postId, mail, isLike, isDislike, currentDate);
                    dao.editEmotion(dto);
                } else {
                    dto = new EmotionDTO(postId, mail, isLike, isDislike, currentDate);
                    dao.createEmotion(dto);
                }
                if (isLike) {
                    notiDto = new NotiDTO(postId, mail, currentDate, "likes");
                } else if (isDislike) {
                    notiDto = new NotiDTO(postId, mail, currentDate, "dislikes");
                }
                notiDao.addNoti(notiDto);
                url = SUCCESS;

            } catch (SQLException | ClassNotFoundException | NamingException e) {
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

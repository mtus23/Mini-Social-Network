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
import tunhm.dao.ArticleDAO;
import tunhm.dao.CommentDAO;
import tunhm.dao.EmotionDAO;
import tunhm.dao.UserDAO;
import tunhm.dto.ArticleDTO;
import tunhm.dto.CommentDTO;
import tunhm.dto.EmotionDTO;
import tunhm.dto.UserDTO;

/**
 *
 * @author DELL
 */
public class ShowArticleDetailController extends HttpServlet {
    private static final Logger LOG = Logger.getLogger(ShowArticleDetailController.class);
    private final String DETAIL = "articleDetail.jsp";
    private final String ERROR = "error.jsp";
    private final String NOT_FOUND = "search.jsp";
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
            try {
                ArticleDAO dao = new ArticleDAO();
                EmotionDAO emoDao = new EmotionDAO();
                CommentDAO cmtDao = new CommentDAO();
                HttpSession session = request.getSession();
                UserDAO userDao = new UserDAO();
                int articleId = Integer.parseInt(request.getParameter("txtId"));
                ArticleDTO dto = dao.getArticleById(articleId);
                if (dto != null) {
                    HashMap<String, String> cmtOwner = new HashMap<>();
                    UserDTO user = (UserDTO) session.getAttribute("user");
                    HashMap<String, Integer> count = emoDao.countEmotion(dto.getPostId());
                    UserDTO articleOwner = userDao.getUser(dto.getMail());
                    List<CommentDTO> listCmt = cmtDao.getCommentInPost(articleId);
                    if (listCmt != null) {
                        for (CommentDTO cmt : listCmt) {
                            cmtOwner.put(cmt.getMail(), userDao.getUser(cmt.getMail()).getName());
                        }
                        request.setAttribute("listComment", listCmt);
                        request.setAttribute("commentOwner", cmtOwner);

                    }
                    EmotionDTO emo = emoDao.findEmo(articleId, user.getMail());
                    request.setAttribute("userEmotion", emo);
                    request.setAttribute("articleDetail", dto);
                    request.setAttribute("emotionCount", count);
                    request.setAttribute("articleOwner", articleOwner);
                    url = DETAIL;
                } else {
                    url = NOT_FOUND;
                    request.setAttribute("errorSearch", "Content not found");
                }
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

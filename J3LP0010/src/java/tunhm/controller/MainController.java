/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tunhm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

/**
 *
 * @author DELL
 */
public class MainController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final static Logger LOG = Logger.getLogger(MainController.class);
    private final String SEARCH = "SearchController";
    private final String LOGIN = "LoginController";
    private final String ERROR_PAGE = "error.jsp";
    private final String REGISTER = "RegisterController";
    private final String LOGOUT = "LogoutController";
    private final String CREATE_ARTICLE = "CreateArticleController";
    private final String ARTICLE_DETAIL = "ShowArticleDetailController";
    private final String MAKE_EMOTION = "MakeEmotionController";
    private final String MAKE_COMMENT = "MakeCommentController";
    private final String DELETE_ARTICLE = "DeleteArticleController";
    private final String SHOW_NOTI = "ShowNotiController";
    private final String SHOW_NOTI_CORRESPONDING = "ShowNotiCorrespondingController";
    private final String DELETE_COMMENT = "DeleteCommentController";
    private final String CREATE_ARTICLE_PAGE = "createArticle.jsp";
    private final String ACTIVE_ACCOUNT_PAGE ="activeAccount.jsp";
    private final String RESEND_ACTIVATION = "ResendActivationController";
    private final String ACTIVATE_ACCOUNT ="ActivateAccountController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR_PAGE;
            try {
                boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
                if (isMultiPart) {
                    url = CREATE_ARTICLE;
                } else {
                    String action = request.getParameter("btnAction");
                    if (action.equals("Login")) {
                        url = LOGIN;
                    } else if (action.equals("Register")) {
                        url = REGISTER;
                    } else if (action.equals("Logout")) {
                        url = LOGOUT;
                    } else if (action.equals("Search")) {
                        url = SEARCH;
                    } else if (action.equals("Create")) {
                        url = CREATE_ARTICLE;
                    } else if (action.equals("ArticleDetail")) {
                        url = ARTICLE_DETAIL;
                    } else if (action.equals("MakeEmotion")) {
                        url = MAKE_EMOTION;
                    } else if (action.equals("Submit Comment")) {
                        url = MAKE_COMMENT;
                    } else if (action.equals("DeleteArticle")) {
                        url = DELETE_ARTICLE;
                    } else if (action.equals("showNoti")) {
                        url = SHOW_NOTI;
                    } else if (action.equals("showNotiCorresponding")) {
                        url = SHOW_NOTI_CORRESPONDING;
                    } else if (action.equals("DeleteComment")) {
                        url = DELETE_COMMENT;
                    } else if (action.equals("createArticle")) {
                        url = CREATE_ARTICLE_PAGE;
                    } else if(action.equals("activeAccountPage")){
                        url = ACTIVE_ACCOUNT_PAGE;
                    } else if(action.equals("resendActivation")){
                        url = RESEND_ACTIVATION;
                    } else if(action.equals("activation")){
                        url = ACTIVATE_ACCOUNT;
                    }
                }
            } catch (Exception e) {
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

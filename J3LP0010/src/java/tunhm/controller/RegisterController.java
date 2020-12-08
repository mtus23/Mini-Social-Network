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
import org.apache.log4j.Logger;
import tunhm.dao.UserDAO;
import tunhm.dto.RegisterErrorDTO;
import tunhm.dto.UserDTO;
import tunhm.util.EmailSender;

/**
 *
 * @author DELL
 */
public class RegisterController extends HttpServlet {

    private final static Logger LOG = Logger.getLogger(RegisterController.class);
    private final String ERROR = "register.jsp";
    private final String LOGIN_PAGE = "login.jsp";
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
            String name = request.getParameter("txtName");
            String pass = request.getParameter("txtPassword");
            String rePass = request.getParameter("txtConfirmPass");
            boolean error = false;
            UserDAO dao = new UserDAO();
            RegisterErrorDTO errorDto = new RegisterErrorDTO("", "", "", "");
            try {
                if (mail.length() < 1) {
                    errorDto.setErrorMail("Mail cannot be blank");
                    error = true;
                } else if (!mail.matches("^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")) {
                    errorDto.setErrorMail("invalid email");
                    error = true;
                } else if (dao.checkDuplicated(mail)) {
                    errorDto.setErrorMail("Mail is existed");
                    error = true;
                }
                if (name.length() < 1) {
                    errorDto.setErrorName("Name cannot be blank");
                    error = true;
                }
                if (pass.length() < 1) {
                    errorDto.setErrorPassword("Password cannot be blank");
                    error = true;
                }
                if (rePass.length() < 1) {
                    errorDto.setErrorConfirmPassword("RePassword cannot be blank");
                    error = true;
                } else if (!rePass.equals(pass)) {
                    errorDto.setErrorConfirmPassword("RePassword and Password are different");
                    error = true;
                }
                if (error) {
                    request.setAttribute("registerError", errorDto);
                } else {
                    EmailSender sender = new EmailSender(mail);
                    String code = sender.randomCode();
                    UserDTO dto = new UserDTO(mail, name, pass, code);
                    dao.register(dto);
                    sender.sendEmailActivate(code);
                    request.setAttribute("registerSuccess", "Register successfully!");
                    url = LOGIN_PAGE;
                }
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

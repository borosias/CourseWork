package Controllers;

import DB.ConnectionDB;
import Models.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SignUp", value = "/SignUp")
public class SignUp extends HttpServlet {
    public static final int COOKIE_AGE = 48*60*60;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String f_name = request.getParameter("f_name");
        String s_name = request.getParameter("s_name");
        String email = request.getParameter("email");
        String password = request.getParameter("psw");
        try {
            User user = new User();
            user.addUser(email,password,f_name,s_name);

            Cookie uid = new Cookie("uid", user.getUserID());
            uid.setMaxAge(COOKIE_AGE);
            response.addCookie(uid);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

       response.sendRedirect(request.getContextPath() + "/ChekLog");

    }
}

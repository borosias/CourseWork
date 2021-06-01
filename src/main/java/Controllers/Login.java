package Controllers;

import Models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet(name = "login", value = "/login")
public class Login extends HttpServlet {
    public static final int COOKIE_AGE = 48*60*60;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        try {
            if (user.checkEmailAndPassword(req.getParameter("email"), req.getParameter("psw"))){
                Cookie uid = new Cookie("uid", user.getUserID());
                uid.setMaxAge(COOKIE_AGE);
                resp.addCookie(uid);
                resp.sendRedirect(req.getContextPath() + "/ChekLog");
            }else {
                req.setAttribute("error", true);
                getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);
            }
        } catch (SQLException | ClassNotFoundException throwables) {
            throwables.printStackTrace();
        }
    }
}

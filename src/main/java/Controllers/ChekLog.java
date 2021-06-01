package Controllers;

import Models.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ChekLog", value = "/ChekLog")
public class ChekLog extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        String isLogged = "false";
        Cookie[] cookies = req.getCookies();
        for (Cookie cookie : cookies) {
            if ("uid".equals(cookie.getName())) {
                isLogged = "true";
                user.setUserID(cookie.getValue());
                user.getInfById(Integer.parseInt(user.getUserID()));

                req.setAttribute("email", String.valueOf(user.getUserEmail()));
                req.setAttribute("sname", String.valueOf(user.getSecondN()));
                req.setAttribute("fname", String.valueOf(user.getFirstN()));
            }
        }
        req.setAttribute("isLogged", isLogged);
        getServletContext().getRequestDispatcher("/index.jsp").forward(req, resp);

    }
}

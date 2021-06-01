package Controllers;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LogOut", value = "/LogOut")
public class LogOut extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if ("uid".equals(cookie.getName())) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }

        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

}

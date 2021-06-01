package Controllers;

import Models.Group;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "TableShower", value = "/TableShower")
public class TableShower extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Group gp = new Group();
        Cookie[] cookies = req.getCookies();
        for (Cookie cookie : cookies) {
            if ("gName".equals(cookie.getName())) {
                cookie.setMaxAge(0);
                resp.addCookie(cookie);
            }
        }
        Object obj = req.getAttribute("isEditor");
        if (!Objects.isNull(obj)) {
            req.setAttribute("isEditor", obj);
            req.setAttribute("editingName", req.getAttribute("editingName"));
        }
        List<String> gNames;
        gNames = gp.getAllGroupsName();
        Collections.sort(gNames);
        System.out.println("Groups will shows");
        req.setAttribute("list", gNames);
        getServletContext().getRequestDispatcher("/groups.jsp").forward(req, resp);
    }

}

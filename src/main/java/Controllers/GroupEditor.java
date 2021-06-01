package Controllers;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "groupEdit", value = "/groupEdit")
public class GroupEditor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("editingName", req.getParameter("name"));
        req.setAttribute("isEditor", true);
        getServletContext().getRequestDispatcher("/TableShower").forward(req, resp);
    }
}
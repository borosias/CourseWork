package Controllers;

import Models.Group;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "DeleteGroup", value = "/DeleteGroup")
public class GroupDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Group gp = new Group();
        try {
            gp.getIdByGName(request.getParameter("name"));
            gp.delete(gp.getId());
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() +"/TableShower");
    }
}

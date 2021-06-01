package Controllers;

import Models.Group;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "tableEditConfirm", value = "/tableEditConfirm")
public class TableEditConfirm extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Group gp = new Group();
        try {
            gp.getIdByGName(request.getParameter("name"));
            gp.editGNameById(request.getParameter("gp_name"),gp.getId()); ;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() +"/TableShower");
    }
}

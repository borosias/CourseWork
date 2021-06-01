package Controllers;

import Models.Group;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "tableAdd", value = "/tableAdd")
public class GroupAdd extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String gp_name = req.getParameter("gp_name");
        Group gp = new Group();
        gp.addGroup(gp_name);
        resp.sendRedirect(req.getContextPath() +"/TableShower");
    }
}
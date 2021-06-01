package Controllers;

import Models.Group;
import Models.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "ShowStudents", value = "/ShowStudents")
public class ShowStudents extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Group gp = new Group();
        Student st = new Student();
        String name = request.getParameter("name");

        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if ("gName".equals(cookie.getName())) {
                request.setAttribute("gname",cookie.getValue());
            } else {
                Cookie gName = new Cookie("gName",name);
                gName.setMaxAge(100000);
                gName.setDomain("ShowStudents");
                response.addCookie(gName);
                request.setAttribute("gname",gName.getValue());
            }
        }
        try {
            gp.getIdByGName(name);
            List<ArrayList<String>> listStudents = st.getAllInformationByGId(gp.getId());
            listStudents.sort(Comparator.comparing(student -> student.get(1)));
            request.setAttribute("listStudents",listStudents);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        getServletContext().getRequestDispatcher("/sel_group.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}

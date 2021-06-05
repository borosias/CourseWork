package Controllers;

import Models.Group;
import Models.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "finder", value = "/finder")
public class Finder extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String filter = req.getParameter("filter");
        List<ArrayList<String>> listFindStudents = null;
        Student st = new Student();
        Group gp = new Group();
        String search = req.getParameter("search").toLowerCase();
        if ("surname".equals(filter)) {
            listFindStudents = st.findStudentBySurname(search);
            listFindStudents.sort(Comparator.comparing(student -> student.get(1)));

        }
        if ("group".equals(filter)) {
            try {
                gp.getIdByGName(search);
                listFindStudents = st.findStudentByGroup(gp.getId());
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            assert listFindStudents != null;
            listFindStudents.sort(Comparator.comparing(student -> student.get(1)));

        }
        req.setAttribute("listFindStudents",listFindStudents);
        getServletContext().getRequestDispatcher("/finded.jsp").forward(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
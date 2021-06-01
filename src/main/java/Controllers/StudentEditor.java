package Controllers;

import Models.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "studentEdit", value = "/studentEdit")
public class StudentEditor extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        String gname = req.getParameter("name");
        String[] info = req.getParameter("student").split(", ");
        String fsname = info[0].replaceAll("[^A-Za-z]","");
        String ssname = info[1].replaceAll("[^A-Za-z]","");
        String status = info[2].replaceAll("[^A-Za-z]","");
        String email = info[3].replaceAll("[^A-Za-z0-9@.!#$%&]","");

        System.out.println(status);

        req.setAttribute("editName",fsname);
        req.setAttribute("editSurname",ssname);
        req.setAttribute("editStatus",status);
        req.setAttribute("editEmail",email);
        req.setAttribute("isEditor", true);
        getServletContext().getRequestDispatcher("/ShowStudents").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
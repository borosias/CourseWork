package Controllers;

import Models.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "studentDelete", value = "/studentDelete")
public class StudentDelete extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Student st = new Student();
        String gname = req.getParameter("name");
        String[] info = req.getParameter("student").split(", ");
        String email = info[info.length-1].replaceAll("[^A-Za-z0-9@.!#$%&]","");
        st.delete(st.getIdByEmail(email));
        getServletContext().getRequestDispatcher("/ShowStudents").forward(req, resp);
    }
}
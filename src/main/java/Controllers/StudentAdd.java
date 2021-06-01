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

@WebServlet(name = "studentAdd", value = "/studentAdd")
public class StudentAdd extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String gname = req.getParameter("name");
        Group gp = new Group();
        Student st = new Student();
        try {
            gp.getIdByGName(gname);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        int gid = Integer.parseInt(gp.getId());
        String f_name = req.getParameter("st_f_name").toLowerCase();
        String s_name = req.getParameter("st_s_name").toLowerCase();
        String status = req.getParameter("st_status").toLowerCase();
        String sEmail = req.getParameter("st_email");
        st.addStudent(f_name,s_name,gid,sEmail,status);


        getServletContext().getRequestDispatcher("/ShowStudents").forward(req, resp);
    }
}
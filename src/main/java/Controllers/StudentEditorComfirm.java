package Controllers;

import Models.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "studentEditConfirm", value = "/studentEditConfirm")
public class StudentEditorComfirm extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Student st = new Student();
        String gname = req.getParameter("name");
        String oldEmail = req.getParameter("old_email");
        String fName = req.getParameter("st_f_name");
        String sName = req.getParameter("st_s_name");
        String status = req.getParameter("st_status");
        String email = req.getParameter("st_email");

        st.editInfoById(st.getIdByEmail(oldEmail),fName,sName,email,status);
        getServletContext().getRequestDispatcher("/ShowStudents").forward(req, resp);
    }
}
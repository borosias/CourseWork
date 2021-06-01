package Models;

import DB.ConnectionDB;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Student {
    private String sName;
    private String fName;
    private String date;
    private String status;

    public Student() {

    }

    public void addStudent(String fName, String sName, int gid, String sEmail, String status) {
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            stat.executeUpdate("INSERT INTO students (f_sname,s_sname,gid,st_email,stat) VALUES ('" + fName + "','" + sName + "','" + gid + "','" + sEmail + "','" + status + "')");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public void deleteStudentByGId(String gid) {
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            stat.executeUpdate("DELETE FROM students WHERE gid = '" + gid + "'");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public String getIdByEmail(String email) {
        String id = "";
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            ResultSet rs = stat.executeQuery("SELECT id from students WHERE st_email ='" + email + "'");
            while (rs.next()) {
                id = String.valueOf(rs.getInt("id"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return id;
    }

    public void editInfoById(String id, String fName, String sName, String email, String status) {
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            stat.executeUpdate("UPDATE students " +
                    "SET f_sname = '" + fName.toLowerCase() + "', s_sname = '" + sName.toLowerCase() + "', st_email= '" + email.toLowerCase() + "', stat = '" + status.toLowerCase() + "'" +
                    " WHERE id ='" + Integer.parseInt(id) + "' ");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public List<ArrayList<String>> getAllInformationByGId(String gid) {
        List<ArrayList<String>> students = new ArrayList<>();
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            ResultSet rs = stat.executeQuery("SELECT * from students WHERE gid ='" + gid + "'");
            while (rs.next()) {
                ArrayList<String> student = new ArrayList<>();
                student.add(rs.getString("f_sname").toUpperCase());
                student.add(rs.getString("s_sname").toUpperCase());
                student.add(rs.getString("stat").toUpperCase());
                student.add(rs.getString("st_email"));
                students.add(student);
            }
            System.out.println("well done");
        } catch (SQLException throwables) {
            System.out.println("Something wrong");
            throwables.printStackTrace();
        }
        return students;
    }

    public void delete(String id) {
        Student st = new Student();
        st.deleteStudentByGId(id);
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            stat.executeUpdate("DELETE FROM students WHERE id = '" + id + "'");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    public List<ArrayList<String>> findStudentBySurname(String surname) {
            List<ArrayList<String>> students = new ArrayList<>();
            Group gp = new Group();
            try (Statement stat = ConnectionDB.getConnection().createStatement()) {
                ResultSet rs = stat.executeQuery("SELECT * from students WHERE s_sname ='" + surname + "'");
                while (rs.next()) {
                    ArrayList<String> student = new ArrayList<>();
                    student.add(rs.getString("s_sname").toUpperCase());
                    student.add(rs.getString("f_sname").toUpperCase());
                    student.add(rs.getString("stat").toUpperCase());
                    student.add(rs.getString("st_email"));
                    student.add(gp.getGNameById(rs.getInt("gid")).toUpperCase());
                    students.add(student);
                }
                System.out.println("well done");
            } catch (SQLException throwables) {
                System.out.println("Something wrong");
                throwables.printStackTrace();
            }
            return students;
        }

        public List<ArrayList<String>> findStudentByGroup(String gid) {
            List<ArrayList<String>> students = new ArrayList<>();
            Group gp = new Group();
            try (Statement stat = ConnectionDB.getConnection().createStatement()) {
                ResultSet rs = stat.executeQuery("SELECT * from students WHERE gid ='" + gid + "'");
                while (rs.next()) {
                    ArrayList<String> student = new ArrayList<>();
                    student.add(rs.getString("s_sname").toUpperCase());
                    student.add(rs.getString("f_sname").toUpperCase());
                    student.add(rs.getString("stat").toUpperCase());
                    student.add(rs.getString("st_email"));
                    student.add(gp.getGNameById(rs.getInt("gid")).toUpperCase());
                    students.add(student);
                }
                System.out.println("well done");
            } catch (SQLException throwables) {
                System.out.println("Something wrong");
                throwables.printStackTrace();
            }
            return students;
        }

    }
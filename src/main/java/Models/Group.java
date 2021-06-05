package Models;

import DB.ConnectionDB;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class Group {
    private String gName;
    private String id;

    public Group() {
    }



    public String getgName() {
        return gName;
    }

    public void setgName(String gName) {
        this.gName = gName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<String> getAllGroupsName() {
        List<String> groups = new ArrayList<>();
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            ResultSet rs = stat.executeQuery("SELECT * from group_names");
            while (rs.next()) {
                groups.add(rs.getString("g_name").toUpperCase());
                setId(String.valueOf(rs.getInt("gid")));
            }
            System.out.println("well done");
        } catch (SQLException throwables) {
            System.out.println("Something wrong");
            throwables.printStackTrace();
        }
        return groups;
    }


    public void addGroup(String name) {
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            stat.executeUpdate("INSERT INTO group_names (g_name) VALUES ('" + name.toLowerCase() + "')");
            System.out.println("well done");
            setgName(name);
        } catch (SQLException throwables) {
            System.out.println("SOME WRONG");
            throwables.printStackTrace();
        }
    }

    public void editGNameById(String name, String id) throws SQLException {
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            stat.executeUpdate("UPDATE group_names SET g_name = '" + name.toLowerCase() + "' WHERE gId ='" + id + "'");
        }
    }

    public void getIdByGName(String name) throws SQLException {
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            ResultSet rs = stat.executeQuery("SELECT gId from group_names WHERE g_name ='" + name + "'");
            while (rs.next()) {
                setId(rs.getString("gId"));
            }
        }
    }

    public String getGNameById(Integer id) throws SQLException {
        String gName = "";
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            ResultSet rs = stat.executeQuery("SELECT g_name from group_names WHERE gId ='" + id + "'");
            while (rs.next()) {
                gName = rs.getString("g_name");
            }
        }
        return gName;
    }

    public void delete(String id) {
        Student st = new Student();
        st.deleteStudentByGId(id);
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            stat.executeUpdate("DELETE FROM group_names WHERE gId = '" + id + "'");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

}




package Models;

import DB.ConnectionDB;

import java.sql.*;

public class User {
    private String userID;
    private String firstN;
    private String SecondN;
    private String password;
    private String userEmail;

    public User() {

    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFirstN() {
        return firstN;
    }

    public void setFirstN(String firstN) {
        this.firstN = firstN;
    }

    public String getSecondN() {
        return SecondN;
    }

    public void setSecondN(String secondN) {
        SecondN = secondN;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public void addUser(String uEmail, String uPsw, String fName, String sName) throws ClassNotFoundException {
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            stat.executeUpdate("INSERT INTO user_login (email, psw, name,surname) VALUES ('" + uEmail + "','" + uPsw + "','" + fName + "','" + sName + "')");
            System.out.println("well done");
            setUserEmail(uEmail);
            setFirstN(fName);
            setSecondN(sName);
            setPassword(uPsw);
            getId(uEmail);
        } catch (SQLException throwable) {
            throwable.printStackTrace();
            System.out.println("Some wrong");
        }
    }

    public void getId(String uEmail) throws ClassNotFoundException {
        int id = 0;
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            ResultSet rs = stat.executeQuery("SELECT id from user_login WHERE email ='" + uEmail + "'");
            while (rs.next()) {
                setUserID(String.valueOf(rs.getInt("id")));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        System.out.println(id);
    }

    public void getInfById(Integer id) {
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            ResultSet rs = stat.executeQuery("SELECT email, name, surname from user_login WHERE id ='" + id + "'");
            while (rs.next()) {
                setUserEmail(rs.getString("email"));
                setFirstN(rs.getString("name"));
                setSecondN(rs.getString("surname"));
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
            System.out.println("Some wrong");
        }

    }


    public boolean checkEmailAndPassword(String email, String psw) throws ClassNotFoundException, SQLException {
        boolean tmp = false;
        try (Statement stat = ConnectionDB.getConnection().createStatement()) {
            ResultSet rs = stat.executeQuery("SELECT email,psw from user_login");
            while (rs.next()) {
                if (email.equals(rs.getString("email"))){
                    if (psw.equals(rs.getString("psw"))){
                        tmp = true;
                        getId(email);
                    }
                }

            }
        }
        return tmp;
    }
}



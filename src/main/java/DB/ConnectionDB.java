package DB;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectionDB {
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String HOST = "jdbc:mysql://localhost:3306/generale?serverTimezone=UTC";

    private static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(HOST, USERNAME, PASSWORD);
        } catch (SQLException | ClassNotFoundException throwables) {
            throwables.printStackTrace();
        }

    }

    public static Connection getConnection() {
        return connection;
    }
}
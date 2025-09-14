package com.student.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseUtility {
	private static String url;
	private static String username;
	private static String password;

	static {
		loadDatabaseProperties();
	}

	private static void loadDatabaseProperties() {
		Properties props = new Properties();
		try (InputStream input = DatabaseUtility.class.getClassLoader().getResourceAsStream("driverinfo.properties")) {

			if (input == null) {
				throw new RuntimeException("driverinfo.properties file not found in classpath");
			}

			props.load(input);
			url = props.getProperty("url");
			username = props.getProperty("usn");
			password = props.getProperty("pwd");

			// Load Oracle JDBC driver
			Class.forName("oracle.jdbc.driver.OracleDriver");

		} catch (IOException | ClassNotFoundException e) {
			throw new RuntimeException("Failed to load database configuration", e);
		}
	}

	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); // This works with ojdbc17.jar
			System.out.println("Attempting to connect to: " + url);
			return DriverManager.getConnection(url, username, password);
		} catch (ClassNotFoundException e) {
			throw new SQLException("Oracle JDBC Driver not found. Make sure ojdbc17.jar is in WEB-INF/lib", e);
		}
	}

	public static void closeConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
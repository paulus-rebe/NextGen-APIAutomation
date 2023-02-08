package utility;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBConnector {

	public Connection con;
	public Statement stmt;

	public Statement getStatement() throws ClassNotFoundException, SQLException {
		try {
			String driver = "org.postgresql.Driver";
			String connection = "jdbc:postgresql://account-management-qa.caspbjhnrhyo.ap-northeast-2.rds.amazonaws.com:5432/account_management";
			String userName = "postgres";
			String password = "fehge7-qubkaq-kiFsap";
			Class.forName(driver);
			con = DriverManager.getConnection(connection, userName, password);
			stmt = con.createStatement();
			return stmt;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stmt;
	}

	public void insertData(String query) throws ClassNotFoundException, SQLException {
		Statement sta = getStatement();
		sta.executeUpdate(query);
	}

	public ResultSet getData(String query) throws ClassNotFoundException, SQLException {
		ResultSet data = getStatement().executeQuery(query);
		return data;
	}

	public void updateData(String query) throws ClassNotFoundException, SQLException {
		getStatement().executeUpdate(query);
	}

	public void deleteData(String query) throws ClassNotFoundException, SQLException {
		PreparedStatement st = con.prepareStatement(query);
		st.executeUpdate();
	}

	public String getOTPfromDB(String email) throws SQLException, ClassNotFoundException {
		String OTP = "";
		try {
			DBConnector obj = new DBConnector();
			String query = "SELECT id, email, otp FROM public.t_user_otp where email='" + email + "';";
			System.out.println("Reading data from Database with query " + query);
			ResultSet rs = obj.getData(query);
			while (rs.next()) {
				OTP = rs.getString("OTP");
			}
		} catch (SQLException e) {

		} catch (ClassNotFoundException e) {

		} finally {
			if (con != null) {
				con.close();
			}

		}
		System.out.println("Retrieved OTP value " + OTP);
		return OTP;
	}

	public void clearAllProjects() throws SQLException {
		try {

			String driver = "org.postgresql.Driver";
			String connection = "jdbc:postgresql://project-management-qa.caspbjhnrhyo.ap-northeast-2.rds.amazonaws.com:5432/project_management";
			String userName = "postgres";
			String password = "hazgir-1reBpe-rivcav";
			Class.forName(driver);
			con = DriverManager.getConnection(connection, userName, password);
			stmt = con.createStatement();
			String query = "Delete from public.t_project where user_id='2c61269b-02ca-4ec7-ad7b-8acf7c35c271'";
			int rowsdeleted = stmt.executeUpdate(query);
			System.out.println("Number of rows deleted " + rowsdeleted);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}

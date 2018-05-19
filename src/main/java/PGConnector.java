package com.mtorrents;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

public final class PGConnector {
	private Connection dbConnection;
	private String url;

	public PGConnector(String hostAddress, Integer dbPort, String dbName) {
		url = "jdbc:postgresql://" + hostAddress + ":" + String.valueOf(dbPort) + "/" + dbName;
		dbConnection = null;
	}

	public PGConnector(String hostAddress, String dbName) {
		url = "jdbc:postgresql://" + hostAddress + ":5432/" + dbName;
		dbConnection = null;
	}

	private void connect(String userName, String userPassword) throws Exception {
		try {
			Class.forName("org.postgresql.Driver");
			dbConnection = DriverManager.getConnection(url, userName, userPassword);
		} catch (Exception e) {
			throw e;
		}
	}

	private void disconnect() throws Exception {
		try {
			dbConnection.close();
		} catch (Exception e) {
			throw e;
		}
	}

	private boolean isConnected() {
		if (dbConnection != null) {
			return true;
		} else {
			return false;
		}
	}

	public boolean testLoginCredentials(String userName, String userPassword) {
		try {
			connect(userName, userPassword);
			disconnect();

			return true;
		} catch (Exception e) {
			return false;
		}
	}

	public void execute(String userName, String userPassword, String queryString) throws Exception {
		try {
			this.connect(userName, userPassword);

			Statement Query = null;

			try {
				Query = dbConnection.createStatement();
				Query.execute(queryString);
			} catch(SQLException e) {
				throw e;
			} finally {
				try {
					Query.close();
				} catch(Exception e) {
					throw e;
				}
			}

			try {
				disconnect();
			} catch(Exception e) {
				throw e;
			}
		} catch(Exception e) {
			throw e;
		}
	}

	public ArrayList<HashMap<String, Object>> executeQuery(String userName, String userPassword, String queryString) throws Exception {
		try {
			connect(userName, userPassword);

			Statement Query = null;
			ResultSet result = null;

			ArrayList<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
			HashMap<String, Object> row = null;

			try {
				Query = dbConnection.createStatement();
				result = Query.executeQuery(queryString);

				ResultSetMetaData metaData = result.getMetaData();

				int columnCount = metaData.getColumnCount();

				while(result.next()) {
					row = new HashMap<>();

					for(int i = 1; i <= columnCount; i++) {
						row.put(metaData.getColumnName(i), result.getObject(i));
					}

					resultList.add(row);
				}
			} catch (SQLException e) {
				throw e;
			} finally {
				try { result.close(); } catch (Exception e) { throw e; }
				try { Query.close(); } catch (Exception e) { throw e; }
			}

			try {
				disconnect();
			} catch(Exception e) {
				throw e;
			}

			return resultList;
		} catch (Exception e) {
			throw e;
		}
	}
}

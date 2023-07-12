/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package model;

import java.sql.*;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author acer
 */
public class Users {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
    }
        // TODO code application logic here
        static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
        static final String DB_URL = "jdbc:mysql://localhost:3306/penjualan";
        static final String USER = "root";
        static final String PASS = "";


    static Connection conn;
    static Statement stmt;
    static ResultSet rs;
    
    public int checkUser(String uname, String paswd){
       try{
            Class.forName(JDBC_DRIVER);	   
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,uname);
            ps.setString(2,paswd);  //string dari nama parameter
            ps.execute();
            rs = ps.executeQuery();
            int count = 0;
           while(rs.next()){
               count++;
           }
           return count;
            
       }
       catch(Exception e)
       {
           e.printStackTrace();
           return 0;
       }
    }
}
    

package javabean;

import java.sql.*;


/********************
*@date  2019年6月8日---下午6:31:28
*@IDE	eclipse
*@jdk	1.8.0_161
*********************/

public class db_conn {
	public Connection conn = null;
	public ResultSet res = null;
	public Statement st = null;
	
	//数据库初始化连接
	public  db_conn() {
		String URL="jdbc:mysql://localhost:3306/db_name?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=utf-8&autoReconnect=true";     //将db_name更换成自己的数据库名称
		String USER="root";    //数据库用户名
		String PWD="";    //数据库密码
		
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
		}catch(ClassNotFoundException e){
			System.out.println(e);
		}try{
			conn = DriverManager.getConnection(URL,USER,PWD);
			st=conn.createStatement();
		}catch(SQLException e){
			System.out.println(e);
		}
	}
	
	//向数据库中添加数据
	public int executeInsert(String sql){
		int num=0;
		try{
			num=st.executeUpdate(sql);
		}
		catch(SQLException e){
			System.out.println("添加数据出错信息:"+e.getMessage());
		}
		return num;
	}
	
	//从数据库中查询数据
	public ResultSet executeQuery(String sql){
		res=null;
		try{
			res=st.executeQuery(sql);
		}
		catch(SQLException e){
			System.out.print("查询出错信息:"+e.getMessage());
		}
		return res;
	}
	
	//更新数据
	public int Update(String sql){
		int num=0;
		try{
			num=st.executeUpdate(sql);
		}catch(SQLException ex){
			System.out.print("执行修改有错误："+ex.getMessage());
		}
		return num;
	}
	
	//删除数据
	public int executeDelete(String sql){
		int num=0;
		try{
			num=st.executeUpdate(sql);
		}
		catch(SQLException e){
			System.out.print("执行删除有错误:"+e.getMessage());
		}
		return num;
	}
	
	//关闭数据库连接
	public void closeDB(){
		try{
			st.close();
			conn.close();
		}
		catch(Exception e){
			System.out.print("执行关闭Connection对象有错误:"+e.getMessage());
		}
	}
}

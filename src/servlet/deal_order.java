package servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javabean.db_conn;

/********************
*@date  2019年6月14日---下午8:57:39
*@IDE	eclipse
*@jdk	1.8.0_161
*********************/
public class deal_order extends HttpServlet{

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		HttpSession session = req.getSession();
		System.out.println("======1========");
		if(session.getAttribute("user_id")!=null) {
			System.out.println("======2========");
			String user_id=session.getAttribute("user_id").toString();
			String f_i=req.getParameter("flight_id");
			String passenger_name=req.getParameter("passenger_name");
			String date=req.getParameter("date");
			String grade=req.getParameter("grade");
			String passenger_id=req.getParameter("passenger_id");
			String contact=req.getParameter("contact");
			String contact_phone=req.getParameter("contact_phone");
			
			
			/*
			 * System.out.println(f_i); System.out.println(passenger_name);
			 * System.out.println(date); System.out.println(grade);
			 * System.out.println(passenger_id); System.out.println(contact);
			 * System.out.println(contact_phone);
			 */
			 System.out.println("f_i:"+f_i+" passenger_name:"+passenger_name+" date:"+date+" grade:"+grade+" passenger_id:"+passenger_id+" contact:"+contact+" contact_phone:"+contact_phone);
			 
			if(f_i!=""&&passenger_name!=""&&date!=""&&grade!=""&&passenger_id!=""&&contact!=""&&contact_phone!="") {
				System.out.println("======3========");
				db_conn conn=new db_conn();
				String sql="insert into t_order (f_n,order_user,p_name,date,grade,p_id,contact,c_p) values('"+f_i+"','"+user_id+"','"+passenger_name+"','"+date+"','"+grade+"','"+passenger_id+"','"+contact+"','"+contact_phone+"')";
				Integer res=conn.executeInsert(sql);
				//同步修改航班余票
				String querySql="SELECT first_surplus_number,business_surplus_number,economy_surplus_number from flight WHERE f_n = '"+f_i+"'";
				ResultSet resultSet = conn.executeQuery(querySql);
				String first_surplus_number = "";
				String business_surplus_number = "";
				String economy_surplus_number = "";
				try {
					while(resultSet.next()) {
						first_surplus_number = resultSet.getString(1);
						business_surplus_number = resultSet.getString(2);
						economy_surplus_number = resultSet.getString(3);
					}
				}catch (SQLException e) {
					System.out.println("出错信息如下："+e);
				}

				Integer updateRes = 0;
				if(grade.equals("头等舱")){
					Integer vlaue = Integer.valueOf(first_surplus_number)-1;
					if(vlaue>=0){
						String updateSql = "update  flight  set first_surplus_number = "+vlaue+ " WHERE f_n = '" + f_i + "'";
						updateRes = conn.Update(updateSql);
					}else {
						session.setAttribute("flag","true");
					}
				}else if(grade.equals("商务舱")){
					Integer vlaue = Integer.valueOf(business_surplus_number)-1;
					if(vlaue>=0) {
						String updateSql = "update  flight  set business_surplus_number = " + vlaue + " WHERE f_n = '" + f_i + "'";
						updateRes = conn.Update(updateSql);
					}else {
						session.setAttribute("flag","true");
					}
				}else if(grade.equals("经济舱")){
					Integer vlaue = Integer.valueOf(economy_surplus_number)-1;
					if(vlaue>=0) {
						String updateSql = "update  flight  set economy_surplus_number = " + vlaue + " WHERE f_n = '" + f_i + "'";
						updateRes = conn.Update(updateSql);
					}else {
						session.setAttribute("flag","true");
					}
				}

				System.out.println(res);
				if(res.equals(1)&&updateRes.equals(1)) {
					session.setAttribute("flag","false");
					resp.sendRedirect("default/order_list.jsp");
				}else {
					resp.sendRedirect("default/index.jsp");
				}
				
			}else {
				System.out.println("======4========");
				resp.sendRedirect("default/order.jsp");
			}
			
		}else {
			System.out.println("======5========");
			resp.sendRedirect("default/order.jsp");
		}	
		
	}
}

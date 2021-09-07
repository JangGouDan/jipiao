<%@page import="javabean.db_conn"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-----------------------------------
-@data-time	2019?6?13?---??5:09:05
-@author	created by xiaohutuxian
-@IDE		eclipse
-@tomcat	9.0
-@jdk		1.8.0_161	
------------------------------------%>
<%
	//添加URL session ，作为用户登录后跳转回来的依据,登录servlet中已经写了判断程序，如果有url_cookie，就跳转到url_cookie，如果没有，就跳转到用户中心
	session.setAttribute("url", request.getRequestURI());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>小糊涂仙机票预订系统</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet">
<link href="css/corptravel.css" rel="stylesheet">
<link href="css/enterprise.css" rel="stylesheet">
<link href="css/iconfont.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<script type="text/javascript">
	function gaiqian(changeFlightNumber,changePriceNumber) {
		<%
		String orderId = request.getParameter("orderId");
		String flightNumber = request.getParameter("flightNumber");
		String priceNumber = request.getParameter("priceNumber");
		%>

		var flag;
		var vlaue = <%=priceNumber%> - changePriceNumber;
		if(vlaue == 0){
			flag = confirm("由航班"+"<%=flightNumber%>"+"改签为"+changeFlightNumber+"，差价为"+vlaue+"元！");
			alert("改签成功！")
		}else if(vlaue > 0){
			flag = confirm("由航班"+"<%=flightNumber%>"+"改签为"+changeFlightNumber+"，差价"+vlaue+"将在两个工作日内退回支付账户！");
			if (flag) {
				alert("改签成功，差价退款" + vlaue + "元！")
			}
		}else {
			flag = confirm("由航班"+"<%=flightNumber%>"+"改签为"+changeFlightNumber+"，还需支付"+Math.abs(vlaue)+"元！");
			if (flag) {
				alert("改签成功，支付"+Math.abs(vlaue)+"元！")
			}
		}

		if (flag) {

			// window.location.href = "/fly_ticket_pre_book/default/ticket_changes.jsp";
		}
	}


</script>
<body class="bg-body">


	<!-- 搜索 -->
	<div class="index-wall white " style="margin: 15px;">
		<div class="container"
			style="position: relative;  width: auto;">
			<form class="form-inline" action="../search" method="post">
				<div class="form-group">
					<select name="" class="form-control">
						<option selected>单程</option>
						<option>往返</option>
					</select>
				</div>
				<div class="form-group mar-left-10">
					<label for="">出发城市</label> <input name="departure" type="text" class="form-control"
						style="width: 85px;" id="" value="" placeholder="出发城市">
				</div>
				<div class="form-group">
					<label for=""> — <a href="#" class="huan">换</a> —
					</label>
				</div>
				<div class="form-group">
					<label for="">到达城市</label> <input name="destination" type="text" class="form-control"
						style="width: 85px;" id="" value="" placeholder="到达城市">
				</div>
				<button type="submit" class="btn btn-warning mar-left-10">搜索</button>
			</form>
		</div>
	</div>
	<!-- 搜索结束 -->



	<!-- 列表开始 -->
	<div class="container mar-bottom-30 " style="width: 882px">
		<div class="hangbanlist">
			<div>
				<%
					db_conn conn=new db_conn();
					String sql="select * from flight";
					ResultSet res=conn.executeQuery(sql);
					while(res.next()){
						String f_i=res.getString(1);
						String s_p=res.getString(2);
						String end_place=res.getString(3);
						String s_a=res.getString(4);
						String e_a=res.getString(5);
						String t_t=res.getString(6);
						String l_t=res.getString(7);
						String f_p=res.getString(8);
						Integer f_p_i=Integer.parseInt(f_p);
						String b_p=res.getString(9);
						Integer b_p_i=Integer.parseInt(b_p);
						String e_p=res.getString(10);
						Integer e_p_i=Integer.parseInt(e_p);
				%>
			
				<!-- 表头 -->
				<ul class="list-inline bor-bottom-solid-1  ">
					<li class="w-percentage-25"><img src="images/air/CA.png"
						width="24" height="24"> <strong>国航</strong> <%=f_i %><span
						class="gray-999 font12 mar-left-10">机型：空客320（中）</span></li>
					<li class="text-right w80"><strong class="time " style="font-size: 18px"><%=t_t %></strong></li>
					<li class="">——</li>
					<li class="w80"><strong class="time "><%=l_t %></strong></li>
					<li class="w100 text-right"><%=s_a %></li>
					<li class="">——</li>
					<li class=" w100"><%=e_a %></li>
					
				</ul>
				<!-- 表头结束 -->
				<!-- 表BODY -->
				<div class="collapse" id="collapseExample" style="display: block;">
					<div class="hangbanlist-body " style="background-color: #FEFCFC;">
						<ul class="list-inline">
							<li class="w-percentage-20"><strong class="blue-0093dd">头等舱(F)</strong></li>
							<li class="w-percentage-25">座位数：≥16</li>
							<li class="w-percentage-25">票面价：<span class="rmb">￥<%=f_p_i+500 %></span></li>


							<li class="w-percentage-20 ">优惠价：<strong
								class="rmb orange-f60 font16">￥<%=f_p %></strong></li>
							<li class="pull-right "><button type="button"
									class="btn btn-danger btn-sm"
<%--									onClick="window.location.href ='order.jsp?flight_id=<%=f_i %>&grade=f';" --%>
															onclick="gaiqian('<%= res.getString(1) %>',<%= res.getString(8) %>)">改签</button></li>
						</ul>
						<ul class="list-inline">
							<li class="w-percentage-20"><strong class=" red">商务舱(B)</strong></li>
							<li class="w-percentage-25">座位数：≥29</li>
							<li class="w-percentage-25">票面价：<span class="rmb">￥<%=b_p_i+200 %></span></li>


							<li class="w-percentage-20 ">优惠价：<strong
								class="rmb orange-f60 font16">￥<%=b_p %></strong></li>
							<li class="pull-right "><button type="button"
									class="btn btn-danger btn-sm"
<%--									onClick="window.location.href ='order.jsp?flight_id=<%=f_i %>&grade=b';--%>
															onclick="gaiqian('<%= res.getString(1) %>',<%= res.getString(9) %>)">改签</button></li>
						</ul>
						<ul class="list-inline">
							<li class="w-percentage-20"><strong class="blue-0093dd">经济舱(E)</strong></li>
							<li class="w-percentage-25">座位数：≥62</li>
							<li class="w-percentage-25">票面价：<span class="rmb">￥<%=e_p_i+100 %></span></li>


							<li class="w-percentage-20 ">优惠价：<strong
								class="rmb orange-f60 font16">￥<%=e_p %></strong></li>
							<li class="pull-right "><button type="button"
									class="btn btn-danger btn-sm"
<%--									onClick="window.location.href ='order.jsp?flight_id=<%=f_i %>&grade=e';--%>
															onclick="gaiqian('<%= res.getString(1) %>',<%= res.getString(10) %>)">改签</button></li>
						</ul>
					</div>
				</div>
				<!-- 表BODY 结束 -->
				
				<%
					}
				%>
				
			</div>


			<div class="clearfix"></div>
		</div>
	</div>

</body>
</html>
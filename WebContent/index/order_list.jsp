<%@page import="java.sql.ResultSet" %>
<%@page import="javabean.db_conn" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-----------------------------------
-@data-time	2019?6?11?---??6:56:16
-@author	created by xiaohutuxian
-@IDE		eclipse
-@tomcat	9.0
-@jdk		1.8.0_161	
------------------------------------%>
<%@ include file="verify_login.jsp" %><%--包含验证登陆代码--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="../default/css/bootstrap.min.css" rel="stylesheet">
    <link href="../default/css/common.css" rel="stylesheet">
    <link href="../default/css/corptravel.css" rel="stylesheet">
</head>
<script type="text/javascript" src="../js/jquery-2.2.1.min.js"></script>


<body>

<div class="container bg-gray-eee box-shadow mar-bottom-30"
     style="padding-right: 0px; padding-left: 0px; position: relative; margin-top: 120px;">
    <table border="0" cellspacing="0" cellpadding="0"
           class="table table-hover table-striped font12 table-bordered v-align-top">
        <tr>
            <th style="width:10%;">航班号</th>
            <th style="width:10%;">乘机人</th>
            <th style="width:12%;">乘机日期</th>
            <th style="width:10%;">舱位</th>
            <th style="width:17%;">乘客证件</th>
            <th style="width:10%;">联系人</th>
            <th style="width:10%;">联系电话</th>
            <th style="width:11%;">状态</th>
            <th style="width:10%;">操作</th>
        </tr>

        <%
            db_conn conn = new db_conn();
            String user_id = session.getAttribute("user_id").toString();
            String sql = "select * from t_order where order_user='" + user_id + "'";
            ResultSet res = conn.executeQuery(sql);
            int i = 0;
            while (res.next()) {
                i++;

        %>

        <tr>
            <td id = <%= i %>>
                <%=res.getString(3) %>
            </td>
            <td><p><%=res.getString(4) %>
            </p></td>
            <td><%=res.getString(5) %>
            </td>
            <td><%=res.getString(6) %>
            </td>
            <td><%=res.getString(7) %>
            </td>
            <td><%=res.getString(8) %>
            </td>
            <td><%=res.getString(9) %>
            </td>

            <% String a = res.getString(10);
                if (a.equals("0")) {%>
            <td>正常</td>
            <td>
                <a onclick="gaiqian(<%= res.getString(1) %>,'<%= res.getString(3) %>',<%= res.getString(11) %>)">改签</a>
                <a onclick="tuiding()">退订</a>
            </td>
            <%}%>
            <% if (a.equals("1")) {%>
            <td>已改签</td>
            <%}%>
            <% if (a.equals("2")) {%>
            <td>已退订</td>
            <%}%>
        </tr>

        <script type="text/javascript">
            function gaiqian(orderId,flightNumber,priceNumber) {
                var flag = confirm("确认要改签吗！");
                if (flag) {
<%--                    <%--%>
<%--                            session.setAttribute("orderId"+ i,res.getString(1));//订单id--%>
<%--                            session.setAttribute("flightNumber",res.getString(3));//航班号--%>
<%--                            session.setAttribute("priceNumber",res.getString(3));//原价格--%>
<%--                    %>--%>
                    window.location.href = "/fly_ticket_pre_book/default/ticket_changes.jsp?orderId="+orderId+"&flightNumber="+flightNumber+"&priceNumber="+priceNumber;
                } else {

                }
            }

            function tuiding() {
                var flag = confirm("退订需要收取20%手续费，确认要退订吗！");
            }


        </script>
        <%
            }
        %>

    </table>
</div>

</body>

</html>
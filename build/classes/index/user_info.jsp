

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-----------------------------------
-@data-time	2019?6?11?---??11:58:31
-@author	created by xiaohutuxian
-@IDE		eclipse
-@tomcat	9.0
-@jdk		1.8.0_161	
------------------------------------%>
<%@ include file="verify_login.jsp" %><%--包含验证登陆代码--%>
<jsp:useBean id="img_url" class="javabean.get_img" scope="session" />
<jsp:setProperty property="user_id" name="img_url" value="<%=session.getAttribute(\"user_id\") %>"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="/fly_ticket_pre_book/index/css/core.css">
<link type="text/css" rel="stylesheet" href="/fly_ticket_pre_book/index/css/home.css">
</head>
<body>

	<div class="ydc-content-slide ydc-body">
		<div class="ydc-flex">

			<!-- right begin -->
			<div class="ydc-column ydc-column-8">
				<div class="ydc-release-content">
					<div class="ydc-tabPanel ydc-tabPanel-release">
						<div class="ydc-release-tab-head">
							<ul>
								<li class="hit">欢迎登陆</li>
							</ul>
						</div>
						<div class="ydc-panes">
							<div class="ydc-pane ydc-pane-clear" style="display: block;">
								<div class="ydc-reg-form-group clearfix">
									<label>帐号名称</label>
									<div class="ydc-reg-form-input">
										<label><%=session.getAttribute("user_id") %></label>
									</div>
								</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- right end -->
		</div>
	</div>

</body>
</html>
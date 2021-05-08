<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Fast Food Ordering System</title>
        <link href="<c:url value="/assets/css/bootstrap.min.css" />" rel="stylesheet">
        
        <script src="<c:url value="/assets/js/bootstrap.bundle.min.js" />"></script>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <main class="container">
            <div class="py-5 px-3 mt-5">

                <h2><spring:message code="viewList.title" />${foodId}: <c:out value="${food.foodName}" /></h2>

                <i><c:out value="${food.description}" /></i><br /><br />
                <spring:message code="viewList.price" />: $<c:out value="${food.price}" /><br /><br />
                <spring:message code="viewList.ava" />: <c:out value="${food.availability}" /><br /><br />
                <c:if test="${fn:length(food.attachments) > 0}">
                    Attachments:<br />
                    <c:forEach items="${food.attachments}" var="attachment"
                               varStatus="status">


                        <img src="data:${attachment.mimeContentType};base64,${attachment.getByteArrayString()}" width="150" height="150"><br />

                    </c:forEach><br /><br />
                </c:if>
                <a href="<c:url value="/menu" />"><spring:message code="viewList.backURL" /></a>
                <br /><br /><h2><spring:message code="viewList.comTitle" /></h2>

                <security:authorize access="isAuthenticated()">
                    <form:form method="POST" enctype="multipart/form-data"
                               modelAttribute="commentForm">
                        <sec:authentication var="user" property="principal.username" />
                        <c:out value="${user}" />
                        <input type="hidden" name="name" value="${user}" />
                        <input type="hidden" name="id" value="${foodId}"/>
                        <form:textarea path="body" rows="5" cols="30" /><br />
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="submit" value="<spring:message code="viewList.comBtn" />"/>
                    </form:form>
                </security:authorize>

                <br />
                <c:choose>
                    <c:when test="${fn:length(commentDatabase) == 0}">
                        <i>There are no comment in the system for this fast food.</i>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <c:forEach items="${commentDatabase}" var="entry">
                                <tr>
                                    <th>${entry.timestamp}</th>
                                    <th>${entry.userName}</th>
                                    <th>${entry.contents}</th>
                                    <th><security:authorize access="hasRole('ADMIN')">
                                            [<a href="<c:url value="/menu/view/${foodId}/delete/${entry.id}" />">Delete</a>]
                                        </security:authorize> </th>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </body>
</html>


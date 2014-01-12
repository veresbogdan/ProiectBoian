<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>
    <title>Biblioteca-carti</title>
    <spring:url value="/pages/style.css" var="resourceUrl"/>
    <link media="screen" rel="stylesheet" href="${resourceUrl}" type="text/css" />

    <spring:url value="/pages/js/common.js" var="jqueryURL"/>
    <script type='text/javascript' src="${jqueryURL}"></script>

</head>
<body>

<div id="wrapper">

    <div id='header'>

        <h1>Biblioteca</h1>

    </div>

    <div id="menu-container">

        <div class="menu">
            <ul>
                <li><a href="./listAll" >Lista Carti</a></li>
                <li><a href="./manage" id="current">Gestiune Biblioteca</a>
                    <ul>
                        <li><a href="../author/manage?action=add">Gestiune Autori</a></li>
                        <li><a href="../book/manage">Gestiune Carti</a></li>
                        <li><a href="../user/manage?action=add">Gestiune Utilizatori</a></li>
                    </ul>
                </li>

            </ul>

        </div><!-- menu -->




    </div><!-- menu container -->

    <div id='main-container'>

        <div id="left-menu" class="left inline">

            <div class="leftTabMenu">
                <ul>
                    <li><a href="../book/add">Adauga carte</a></li>
                    <li><a href="../book/manage">Editeaza/Sterge Carte</a></li>

                </ul>
            </div><!-- menu -->

            <div class="clear"></div>

        </div><!--left-container-->

        <div class="left inline">

            <table>
                <thead>
                <th>Nume Carte</th>
                <th>Editura</th>
                <th>Autori</th>
                <th>Stare</th>
                </thead>
                <tbody>

                <c:forEach var="book" items="${books_result}">
                    <tr>
                        <td><c:out value="${book.title}"></c:out></td>
                        <td><c:out value="${book.publisher}"></c:out></td>
                        <td>
                            <c:forEach  var="author" items="${book.authors}">
                                <c:out value="${author.name}"></c:out> <br/>
                            </c:forEach>
                        </td>

                        <c:choose>
                        <c:when test="${book.bookingDate != null}">
                        <td class="red">
                                <c:out value="Imprumutata"></c:out>

                            </c:when>
                            <c:otherwise>
                        <td class="green">
                            <c:out value="Disponibila"></c:out>
                            </c:otherwise>
                            </c:choose>

                        </td>

                    </tr>
                </c:forEach>

                </tbody>

            </table>

        </div><!-- right container-->

    </div><!-- main container -->
    <div class="clear"></div>

</div>


</body>
</html>

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

    <spring:url value="/pages/images/biblioteca.png" var="bibliotecaUrl"/>
</head>
<body>

<div id="wrapper">

    <div id='header'>

        <img src="${bibliotecaUrl}">

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

            <div class="leftTabMenu" style="width: 300px">
                <ul>
                    <li><a href="../book/create">Adauga Carte</a></li>
                    <li><a href="../book/manage">Sterge Carte</a></li>

                </ul>
            </div><!-- menu -->

            <div class="clear"></div>

        </div><!--left-container-->

        <div id="right-content" class="left inline">

            <table>
                <thead>
                <th>Nume Carte</th>
                <th>Editura</th>
                <th>Autori</th>
                <th>Stare</th>
                <th></th>
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

                        <td><form id="deleteButton" action="" method="">
                            <input readonly hidden="true" type="text" name="id" id="id" value="${book.id}"/>
                            <button id="${book.id}" type="submit">Sterge</button>
                        </form></td>

                    </tr>
                </c:forEach>

                </tbody>

            </table>

            <!-- START Scripts for JSON POST -->

            <script type="text/javascript">
                $(function () {
                    $("#deleteButton").bind("submit", function(evt) {
                        <!--evt.currentTarget[1] is the button as second element (index 0) -->
                        $JsonValue = "{\"id\":" + evt.currentTarget[1].id + "}";

                        $.ajax({
                            url: "../book/delete",
                            type: "POST",
                            contentType: "application/json",
                            data: $JsonValue,
                            success: function (data, textStatus, jqXHR) {
                                window.location.href = "./manage"
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert(errorThrown)
                            }
                        });

                        return false;
                    });

                });
            </script>

            <!-- END Scripts for JSON POST -->

        </div><!-- right container-->

    </div><!-- main container -->
    <div class="clear"></div>

</div>


</body>
</html>

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

    <style type="text/css">
        #tableEdit{
            margin-top:20px;
            margin-left:100px;
            border-collapse: collapse;
            width:60%;
            border:2px solid silver;
        }

        #tableEdit thead th{
            background-color: lightgrey;
            height:35px;
            padding:5px;
            border-right:1px solid silver;
        }

        #tableEdit th:last-child {
            border-right:none;
        }

        #tableEdit td{
            height:35px;
            border:1px solid silver;
            text-align:center;
        }

        #tableEdit td{
            padding:10px
        }
    </style>
</head>
<body>

<div id="wrapper">

    <div id='header'>

        <img src="${bibliotecaUrl}">

    </div>

    <div id="menu-container">

        <div class="menu">
            <ul>
                <li><a href="../book/listAll" >Lista Carti</a></li>
                <li><a href="../book/manage" id="current">Gestiune Biblioteca</a>
                    <ul>
                        <li><a href="../author/manage?action=add">Gestiune Autori</a></li>
                        <li><a href="../book/manage">Gestiune Carti</a></li>
                        <li><a href="./manage?action=add">Gestiune Utilizatori</a></li>
                    </ul>
                </li>

            </ul>

            <div id="search">

                <form action="" method="">

                    <span>Search</span>

                    <input type="text" value=""/>

                    <button type="submit"> Go </button>

                </form>

            </div><!-- search -->


        </div><!-- menu -->




    </div><!-- menu container -->

    <div id='main-container'>

        <div id="leftEditContainer" class="left inline">

            <div class="leftTabMenu" style="width: 300px">
                <ul>
                    <li><a href="./manage?action=add">Adauga Utilizator</a></li>
                    <li><a href="./manage?action=delete">Sterge Utilizator</a></li>
                </ul>
            </div><!-- menu -->

            <div class="clear"></div>

        </div><!--left container-->

        <div id="right-content" class="left inline">



            <c:choose>
                <c:when test="${param.action=='delete'}">
                    <!-- START Edit page -->

                    <table style="margin-top:0px;!important" class="general_table">
                        <thead>
                        <th>Id</th>
                        <th>CNP</th>
                        <th>Email</th>
                        <th>Name</th>
                        <th></th>
                        </thead>
                        <tbody>

                        <c:forEach var="user" items="${users_result}">
                            <tr>
                                <td><c:out value="${user.id}"></c:out></td>
                                <td><c:out value="${user.cnp}"></c:out></td>
                                <td><c:out value="${user.email}"></c:out></td>
                                <td><c:out value="${user.name}"></c:out></td>

                                <td><form id="deleteButton" action="" method="">
                                    <input readonly hidden="true" type="text" name="id" id="id" value="${user.id}"/>
                                    <button id="${user.id}" type="submit">Sterge</button>
                                </form></td>
                            </tr>
                        </c:forEach>

                        </tbody>


                        <!-- START Scripts for JSON POST -->

                        <script type="text/javascript">
                            $(function () {
                                $("#deleteButton").bind("submit", function(evt) {
                                    <!--evt.currentTarget[1] is the button as second element (index 0) -->
                                    $JsonValue = "{\"id\":" + evt.currentTarget[1].id + "}";

                                    $.ajax({
                                        url: "../user/delete",
                                        type: "POST",
                                        contentType: "application/json",
                                        data: $JsonValue,
                                        success: function (data, textStatus, jqXHR) {
                                            window.location.href = "./manage?action=delete"
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


                    </table>

                    <!-- END Edit page -->

                </c:when>
                <c:when test="${param.action=='add'}">
                    <jsp:include page="add_user.jsp"></jsp:include>
                </c:when>
                <c:otherwise>Operation successful.</c:otherwise>
            </c:choose>

        </div><!-- right container-->

    </div><!-- main container -->
    <div class="clear"></div>

</div>


</body>
</html>

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
                <li><a href="../book/listAll" >Lista Carti</a></li>
                <li><a href="../book/manage" id="current">Gestiune Biblioteca</a>
                    <ul>
                        <li><a href="./manage?action=add">Gestiune Autori</a></li>
                        <li><a href="../book/manage">Gestiune Carti</a></li>
                        <li><a href="../user/manage">Gestiune Utilizatori</a></li>
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

        <div id="edit-container" class="left inline">

            <div class="leftTabMenu" style="width: 300px">
                <ul>
                    <li><a href="./manage?action=add">Adauga autori</a></li>
                    <li><a href="./manage?action=delete">Sterge autori</a></li>
                </ul>
            </div><!-- menu -->

            <div class="clear"></div>

        </div><!--left-container-->

        <div id="right-container" class="left inline">

            <c:choose>
                <c:when test="${param.action=='delete'}">
                    <jsp:include page="authors/delete_author.jsp"></jsp:include>
                </c:when>
                <c:when test="${param.action=='add'}">
                    <jsp:include page="authors/add_author.jsp"></jsp:include>
                </c:when>
                <c:otherwise>Operation successful.</c:otherwise>
            </c:choose>

        </div><!-- right container-->

    </div><!-- main container -->
    <div class="clear"></div>

</div>


</body>
</html>

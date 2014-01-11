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
                        <li><a href="../author/manage">Gestiune Autori</a></li>
                        <li><a href="./manage">Gestiune Carti</a></li>
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

        <div id="left-container" class="left inline">

            <div class="leftTabMenu">
                <ul>
                    <li><a href="../author/manage">Gestiune Autori</a></li>
                    <li><a href="./manage">Gestiune Carti</a></li>
                    <li><a href="../user/manage">Gestiune Utilizatori</a></li>
                </ul>
            </div><!-- menu -->

            <div class="clear"></div>

        </div><!--left-container-->

        <div id="right-container" class="left inline">

            <div id="infos">

                <h4>Informatii carte</h4>
                <br/>
                <table>
                    <tr>
                        <td>Nume:</td>
                        <td>Carte 1</td>
                    </tr>
                    <tr>
                        <td>Stare:</td>
                        <td>Imprumutata</td>
                    </tr>

                    <tr><td colspan="2">&nbsp;</td></tr>

                    <tr>
                        <td>User:</td>
                        <td>Mihai Dan</td>
                    </tr>
                    <tr>
                        <td>Data Imprumut:</td>
                        <td>11.11.2013</td>
                    </tr>
                    <tr>
                        <td>Data Limita:</td>
                        <td>25.11.2013</td>
                    </tr>

                </table>

                <button> Returneaza </button>

            </div>

        </div><!-- right container-->

    </div><!-- main container -->
    <div class="clear"></div>

</div>


</body>
</html>

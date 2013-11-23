<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <spring:url value="/pages/style.css" var="resourceUrl"/>
    <link media="screen" rel="stylesheet" href="${resourceUrl}" type="text/css" />
    <title>Biblioteca</title>
    <link media="all" type="text/css" rel="stylesheet" href="style.css">
</head>
<body>


<div id="wrapper">

    <div id='header'>

           <h1>Biblioteca</h1>

    </div>

    <div id="menu-container">

        <div class="menu">
            <ul>
                <li><a href="#" >Lista Carti</a></li>
                <li><a href="#" id="current">Gestiune Biblioteca</a>
                    <ul>
                        <li><a href="#">Gestiune Autori</a></li>
                        <li><a href="#">Gestiune Carti</a></li>
                        <li><a href="#">Gestiune Utilizatori</a></li>
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

    <div class="clear"></div>

    <div id='main-container'>

           <div id="left-container" class="left inline">

                <table>
                    <thead>
                        <th>Nume Carte</th>
                        <th>Editura</th>
                        <th>Autori</th>
                        <th>Stare</th>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Carte 1</td>
                            <td>Editura 1</td>
                            <td>Autor1, Autor 2</td>
                            <td>Imprumutata</td>
                        </tr>
                        <tr>
                            <td>Carte 1</td>
                            <td>Editura 1</td>
                            <td>Autor1, Autor 2</td>
                            <td>Imprumutata</td>
                        </tr>
                        <tr>
                            <td>Carte 1</td>
                            <td>Editura 1</td>
                            <td>Autor1, Autor 2</td>
                            <td class="red">Imprumutata</td>
                        </tr>
                        <tr>
                            <td>Carte 1</td>
                            <td>Editura 1</td>
                            <td>Autor1, Autor 2</td>
                            <td class="green">Disponibila</td>
                        </tr>
                    </tbody>

                </table>


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
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

    <spring:url value="/pages/js/jquery-1.8.3.min.js" var="jqueryURL"/>
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
                        <li><a href="./manage">Gestiune Carti</a></li>
                        <li><a href="../user/manage?action=add">Gestiune Utilizatori</a></li>
                    </ul>
                </li>

            </ul>

            <div id="search">

                <form action="" method="">

                    <span>Search</span>

                    <input type="text" value=""/>

                    <button onclick="search_books();"> Go </button>

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

                <c:forEach var="book" items="${books_result}">
                    <tr>
                        <td onclick="show_details(${book.id})" style="cursor:pointer">
                           <strong>${book.title}</strong>
                        </td>
                        <td>${book.publisher}</td>
                        <td>
                            <c:forEach  var="author" items="${book.authors}">
                               ${author.name}<br/>
                            </c:forEach>
                        </td>

                            <c:choose>
                                <c:when test="${book.bookingDate != null}">
                                    <td class="red">
                                         Imprumutata

                                </c:when>
                                <c:otherwise>
                                    <td class="green">
                                        Disponibila
                                </c:otherwise>
                            </c:choose>

                                    </td>
                        
                    </tr>
                </c:forEach>

                </tbody>

            </table>


        </div><!--left-container-->

        <div id="right-container" class="left inline" style="display:none;">

            <div id="infos">

                <h4>Informatii carte</h4>
                <br/>

                <div id='info_area'>
                    <%--<table>--%>
                        <%--<tr>--%>
                            <%--<td>Nume:</td>--%>
                            <%--<td>Carte 1</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>Stare:</td>--%>
                            <%--<td>Imprumutata</td>--%>
                        <%--</tr>--%>

                        <%--<tr><td colspan="2">&nbsp;</td></tr>--%>

                        <%--<tr>--%>
                            <%--<td>User:</td>--%>
                            <%--<td>Mihai Dan</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>Data Imprumut:</td>--%>
                            <%--<td>11.11.2013</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>Data Limita:</td>--%>
                            <%--<td>25.11.2013</td>--%>
                        <%--</tr>--%>

                    <%--</table>--%>

                    <%--<button> Returneaza </button>--%>
                </div>

            </div>

        </div><!-- right container-->

    </div><!-- main container -->
    <div class="clear"></div>

</div>

<script type="text/javascript">

    function show_details(book_id){

        $.ajax({
            url: "../book/findBook/"+book_id,
            type: "POST",
            contentType: "application/json",
            success: function (data, textStatus, jqXHR) {
                // do something with your data here.


                if(data != null) {

                    var to_append = '';

                    to_append +='<table>';
                    to_append += '<tr><td>Nume:</td><td>'+data.title+'</td></tr>';


                    //if the product was found
                    if( data.bookingDate == null ) {

                        to_append += '<tr><td>Stare:</td><td>Disponibila</td> </tr>';
                        to_append += '<tr><td colspan="2">&nbsp;</td></tr>';

                        to_append += '<tr><td>Utilizatori:</td>';
                        to_append += '<td><select name="user">';
                        to_append += '<option value="0">Selecteaza utilizator</option>';

                        <c:forEach  var="user" items="${users_result}">
                        to_append += '<option value="${user.id}">${user.name}</option>';
                         </c:forEach>

                        to_append += '</select></td> </tr>';
                        to_append += '<tr><td colspan="2">&nbsp;</td></tr>';

                        to_append += '<tr> <td colspan="2"><button onclick="borrow_book('+data.id+');">Imprumuta</button></td></tr>';

                    }//if the book is not borrowed
                    else {

                        to_append += '<tr><td>Stare:</td><td>Imprumutata</td> </tr>';
                        to_append += '<tr><td colspan="2">&nbsp;</td></tr>';

                        to_append += '<tr><td>User:</td><td>'+data.user.name+'</td></tr>';
                        to_append += '<tr><td>Data Imprumut:</td><td>'+format_date(data.bookingDate)+'</td></tr>';
                        to_append += '<tr><td>Data Limita:</td><td>'+format_date(data.dueDate)+'</td></tr>';
                        to_append += '<tr><td colspan="2">&nbsp;</td></tr>';

                        to_append += '<tr> <td colspan="2"><button onclick="return_book('+data.id+','+data.user.id+');">Returneaza</button></td></tr>';

                    }//if the book was borrowed

                    to_append +='</table>';


                    $('#info_area').html(to_append);
                    $('#right-container').show();

                }//if product returned
                else {
                    alert('Produsul selectat nu exista.')
                }//if no product returned;

            },
            error: function (jqXHR, textStatus, errorThrown) {
                // likewise do something with your error here.
                alert(errorThrown)
            }
        });


    }//show_details


    function borrow_book(book_id) {

        var user_id = $('select[name="user"]').val();

        if(user_id == 0 ) { alert('Trebuie sa selectati un utilizator'); return false; }

        var form_data = {};

        form_data['id'] = book_id;
        form_data['user'] = {};

        form_data['user']['id']= user_id;


        $.ajax({
            url: "../book/borrow",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(form_data),
            success: function (data, textStatus, jqXHR) {
                // do something with your data here.
                if(data == null)
                {
                    alert('Action crashed. Please try again.');
                }else{
                    $('#info_area').html('<span class="green">Cartea a fost imprumutata de catre:'+data.user.name+'</span>');

                }


            },
            error: function (jqXHR, textStatus, errorThrown) {
                // likewise do something with your error here.
                alert(errorThrown)
            }
        });


    }//borrow book


    function return_book(book_id,user_id) {


        var form_data = {};

        form_data['id'] = book_id;
        form_data['user'] = {};

        form_data['user']['id']= user_id;


        $.ajax({
            url: "../book/return",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(form_data),
            success: function (data, textStatus, jqXHR) {
                // do something with your data here.
                if(data == null)
                {
                    alert('Action crashed. Please try again.');
                }else{
                    $('#info_area').html('<span class="green">Cartea a fost returnata!</span>');

                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // likewise do something with your error here.
                alert(errorThrown)
            }
        });


    }//borrow book


    function format_date(timestamp){

        var date = new Date(timestamp);

        var year = date.getFullYear();

        var month = date.getMonth();

        var day = date.getDate();


        return year + '-' + month + '-' + day;

    }//format date

</script>

</body>
</html>

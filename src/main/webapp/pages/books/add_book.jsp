<%--
  Created by IntelliJ IDEA.
  User: Alexandra
  Date: 1/11/14
  Time: 5:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <title>Add book</title>
    <spring:url value="/pages/style.css" var="resourceUrl"/>
    <link media="screen" rel="stylesheet" href="${resourceUrl}" type="text/css" />

    <spring:url value="/pages/js/jquery-1.8.3.min.js" var="jqueryURL"/>
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
                        <li><a href="../author/manage">Gestiune Autori</a></li>
                        <li><a href="../book/manage">Gestiune Carti</a></li>
                        <li><a href="../user/manage">Gestiune Utilizatori</a></li>
                    </ul>
                </li>

            </ul>

        </div><!-- menu -->




    </div><!-- menu container -->

    <div id='main-container'>

        <div id="left-menu" class="left inline">

            <div class="leftTabMenu">
                <ul>
                    <li><a href="../book/create">Adauga carte</a></li>
                    <li><a href="../book/manage">Editeaza/Sterge Carte</a></li>

                </ul>
            </div><!-- menu -->

            <div class="clear"></div>

        </div><!--left-container-->

        <div id="right-content"  class="left inline">

            <div id="errors" style="display:none;">
                <span class="red"></span>
            </div>

            <form action="" method="">

            <table>
               <tr>
                   <td>Titlu</td>
                   <td><input type="text" name="title"/></td>
               </tr>
                <tr>
                    <td>Anul aparitiei</td>
                    <td><input type="text" name="year"/></td>
                </tr>
                <tr>
                    <td>Editura</td>
                    <td><input type="text" name="publisher"/></td>
                </tr>
                <tr>
                    <td>Autori</td>
                    <td>
                        <c:forEach  var="author" items="${authors_result}">
                            <input type="checkbox" value="${author.id}" name="authors[]"/> <c:out value="${author.name}"></c:out> <br/>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" />
                    </td>
                </tr>

            </table>

            </form>

        </div><!-- right container-->

    </div><!-- main container -->
    <div class="clear"></div>

</div>


<script type="text/javascript">
    $(function () {
        $.fn.serializeObject = function()
        {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };


        $("form").bind("submit", function(evt) {
            evt.preventDefault();

//            var form_datas = JSON.stringify($("form").serializeObject());
            var form_data = {};


            form_data['title'] = $('input[name="title"]').val();
            form_data['year'] = $('input[name="year"]').val();
            form_data['publisher'] = $('input[name="publisher"]').val();
            form_data['authors'] = [];

            $('input[name="authors[]"]:checked').each(function() {
                console.log($(this).val())
                var author_data = {};
                author_data['id'] = $(this).val();
                form_data['authors'].push(author_data);

            });
            console.log(form_data);

            $.ajax({
                url: "../book/create",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(form_data),
                success: function (data, textStatus, jqXHR) {
                    // do something with your data here.
                    console.log(data)
                    if(data != null) {
                        $('form')[0].reset();
                        alert('Autorul a fost adaugat cu success');
                    }else {
                        alert('Toate campurile sunt obligatorii.')
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // likewise do something with your error here.
                    alert(errorThrown)
                }
            });

            return false;
        });

    });

</script>

</body>




</html>

<%--
  Created by IntelliJ IDEA.
  User: Adrian
  Date: 1/11/14
  Time: 2:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Biblioteca-carti</title>
</head>
<body>

<div id="right-content"  class="left inline">

    <form id="authorForm" action="" method="">
        <table id="table-form">
               <tr>
                   <td>Nume Autor:</td>
                   <td><input type="text" name="name" id="name" /></td>
               </tr>
            <tr>
                <td>
                    Nationalitate:
                </td>
                <td>
                    <input type="text" name="nationality" id="nationality" />
                </td>
            </tr>
            <tr>
                <td colspan="2"> <input type="submit" /></td>
            </tr>

        </table>


    </form>

</div>

    <!-- START Scripts for JSON POST -->

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


            $("#authorForm").bind("submit", function(evt) {
                console.log(JSON.stringify($("#authorForm").serializeObject()));

                $.ajax({
                    url: "../author/create",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify($("#authorForm").serializeObject()),
                    success: function (data, textStatus, jqXHR) {
                        window.location.href = "../author/manage"
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        // likewise do something with your error here.
                    }
                });

                return false;
            });

        });
    </script>

    <!-- END Scripts for JSON POST -->

</body>
</html>

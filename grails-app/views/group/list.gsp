

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Group List</title>
    </head>
    <body>

        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

            <div class="list">
                <table>

                    </thead>
                    <tbody>
                    <g:each in="${groupInstanceList}" status="i" var="groupInstance">
                        <div class="entry">

                            <h2><a href="${groupInstance.website}">${fieldValue(bean:groupInstance, field:'name')}</a>	</h2>

                            ${groupInstance.location}<br />

                            <p>${groupInstance.description}</p>

                           <!-- <td>${fieldValue(bean:fooInstance, field:'active')}</td>-->

<!--                            <g:if test="${groupInstance.user}">
                              <span class="user">${groupInstance.user},</span> User<br />
                            </g:if>-->
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>

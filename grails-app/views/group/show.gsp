

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>${fieldValue(bean:groupInstance, field:'name')}</title>
    </head>
    <body>
        <div class="nav">

        </div>
        <div class="body">
            <h1>${fieldValue(bean:groupInstance, field:'name')}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"></td>
                            
                            <td valign="top" class="value"><h3>${fieldValue(bean:groupInstance, field:'location')}</h3></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Website:</td>
                            
                            <td valign="top" class="value"><a href="${groupInstance.website}">${fieldValue(bean:groupInstance, field:'website')}</a></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"></td>
                            
                            <td valign="top" class="value">${fieldValue(bean:groupInstance, field:'description')}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <sec:ifAllGranted roles="ROLE_ADMIN">
            <div class="buttons">
                <g:form>
                    <input type="hidden" name="id" value="${groupInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" value="Edit" /></span>
                </g:form>
            </div>
            </sec:ifAllGranted>
        </div>
    </body>
</html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Register New Groovy / Grails Group</title>         
    </head>
    <body>
        <div class="body">
            <h2>Request Proposal Update</h2>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${groupInstance}">
            <div class="errors">
                <g:renderErrors bean="${groupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:hasErrors bean="${user}">
            <div class="errors">
                <g:renderErrors bean="${user}" as="list" />
            </div>
            </g:hasErrors>
            <p>If you've already proposed a group on the site and would like it to be moved to the list of active groups, please fill this out.</p><br >
            <g:form action="pg" method="post" >
                <div class="dialog">
	                            <table style="width:400px">

				                    <tr class="prop2">
				                            <td valign="top" class="name">

		                                    <label for="name">Group Name:</label>

		                                    <input type="text" id="name" name="name" value="${fieldValue(bean:groupInstance,field:'name')}"/>
		                                </td>
		                            </tr>
		
		                            <tr class="prop2">
		                                <td valign="top" class="location">
	
                                    <label for="location">Location:</label>
  
                                    <input type="text" id="location" name="location" value="${fieldValue(bean:groupInstance,field:'location')}"/>
                                </td>
                            </tr> 

		                    <tr class="prop2">
		                            <td valign="top" class="name">
	
                                    <label for="website">Website:</label>
  
                                    <input type="text" id="website" name="website" value="${fieldValue(bean:groupInstance,field:'website')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description">Group Description:</label>
                                    <br/>
                                    <textarea rows="8" cols="56" name="description">${fieldValue(bean:groupInstance, field:'description')}</textarea>
                                </td>
                            </tr> 
                        </tbody>
                    </table>
                    <h4>Group Submitted By:</h4>
                    <table>  
                        <tbody>  
                            <tr class="prop2">
                                <td valign="top" class="name">
                                    <label for="user.name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:user,field:'name','errors')}">
                                    <input type="text" id="user.name" name="user.name" value="${fieldValue(bean:user,field:'user.name')}"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="email">email:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:user,field:'email','errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean:user,field:'email')}"/>
                                </td>
                            </tr> 
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Submit" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>

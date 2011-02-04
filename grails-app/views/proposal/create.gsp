<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Register New Groovy / Grails Group</title>         
    </head>
    <body>
        <div class="body">
            <h2>Propose a Group</h2>
			<p>Propose starting a new Groovy user group in your area.  You will receive emails if others are interested.  Then you can contact them and get the ball rolling.  
				You also might want to consider starting a Google group, so you and your new friends can share ideas.</p>
			<p>Once you have a group started, be sure to <g:link controller="group" action="p">let us know</g:link> so we can get it on the Active Group list. Good luck!</p>
            <g:if test="${flash.message}">
            <br />
            <div class="message"><p style="font-size:large; color:red;"><b>${flash.message}</b></p></div>
            <br />
            </g:if>
            <g:hasErrors bean="${proposalInstance}">
            <div class="errors">
                <g:renderErrors bean="${proposalInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:hasErrors bean="${user}">
            <div class="errors">
                <g:renderErrors bean="${user}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
	                            <table style="width:400px">
		                            <tr class="prop2">
		                                <td valign="top" class="location">
	
                                    <label for="location">Location:</label>
  
                                    <input type="text" id="location" name="location" value="${fieldValue(bean:proposalInstance,field:'location')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comment">Comments:</label>
                                    <br/>
                                    <textarea rows="5" cols="56" name="comment">${fieldValue(bean:proposalInstance, field:'comment')}</textarea>
                                </td>
                            </tr> 
                        </tbody>
                    </table>
                    <h4>Group Submitted By:</h4>
                    <table>  
                        <tbody>  
                            <tr class="prop2">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:user,field:'name','errors')}">
                                    <input type="text" id="name" name="name" value="${name}"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="email">Email:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:user,field:'email','errors')}">
                                    <input type="text" id="email" name="email" value="${email}"/>
                                </td>
                            </tr> 
                        </tbody>
                    </table>
					<br/>
					<h3>High Tech Spam Prevention</h3>
                    <p>If you had 1 Gonzo, and you added 1 Rizzo, and then you added 1 each of Statler and Waldorf, what would be your total number of Muppets? (The correct answer is 4. If you are not a spam bot, enter it below.)</p><br />
                    <input type="text" id="answer" name="answer" value="${answer}"/>
                </div>
                <div class="buttons"><p>&nbsp;</p>
                    <span class="button"><input class="save" type="submit" value="Submit" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>

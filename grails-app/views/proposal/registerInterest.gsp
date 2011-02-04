<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Register Interest in New Groovy / Grails Group</title>         
    </head>
    <body>

        <div class="body">
            <h2>Register Interest for a Group in ${proposal.location}</h2>
            <g:if test="${flash.message}">
            <br />
            <div class="message">${flash.message}</div>
            <br />
            </g:if>
            <g:hasErrors bean="${interest}">
            <div class="errors">
                <g:renderErrors bean="${interest}" as="list" />
            </div>
            </g:hasErrors>
            <g:hasErrors bean="${user}">
            <div class="errors">
                <g:renderErrors bean="${user}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="saveInterest" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
							<tr>
								<td colspan="2">
									Let others know you'd be interested in attending or helping with a Groovy user group in ${proposal.location}.
								</td>
							</tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="supporter">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:user,field:'supporter','errors')}">
                                    <input type="text" id="name" name="name" value="${fieldValue(bean:user,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">Email:</label>
                                    
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:user,field:'email','errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean:user,field:'email')}"/>
                                </td>
                            </tr> 

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comment">Comments:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:interest,field:'comment','errors')}">
                                    <textarea rows="6" cols="45" name="comment">${fieldValue(bean:interest, field:'comment')}</textarea>
                                    <p>Your email will only be sent to the proposed group's contact, ${proposal.proposer?.name}, and others who have expressed an interest in this group. Your name and comment will be displayed on ${proposal.proposer?.name}'s proposal page.</p>
                                </td>
                            </tr> 
                            <g:hiddenField name="proposalId" value="${proposal?.id}" />

                        </tbody>
                    </table>
					<p>If you had 1 Gonzo, and you added 1 Rizzo, and then you added 1 each of Statler and Waldorf, what would be your total number of Muppets? (The correct answer is 4. If you are not a spam bot, enter it below.)</p><br />
                    <input type="text" id="answer" name="answer" value="${answer}"/>
                </div>
                <div class="buttons">
	                <p>&nbsp;</p>
                    <span class="button"><input class="save" type="submit" value="Submit" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
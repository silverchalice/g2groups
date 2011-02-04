<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Proposed Groovy / Grails Groups</title>
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
                    <g:each in="${proposalInstanceList}" status="i" var="proposal">
                        <div class="entry">
			    
   
                            <h2><g:link action="show" id="${proposal.id}">Proposal in ${proposal.location}</g:link></h2>

                            <g:if test="${proposal.interest?.size()}">
                              <g:if test="${proposal.interest?.size() == 1}">
                                <h4>(${proposal.interest?.size()} supporter)</h4>
                              </g:if>
                              <g:else>
                                <h4>(${proposal.interest?.size()} supporters)</h4>
                              </g:else>
                            </g:if>
                        
                           <p>${proposal?.comment}</p>
                        
                            Submitted By: <span class="user">${proposal.proposer?.name} | <span class="button"><g:link controller="proposal" action="registerInterest" id="${proposal?.id}">Support This Group</g:link></span><br/></span><br />
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
			<div class="paginateButtons"><br />
			    <g:paginate total="${proposalInstanceTotal}" />
			    <p>&nbsp;</p>
			</div>
        </div>
    </body>
</html>

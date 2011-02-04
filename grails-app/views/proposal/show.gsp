

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'proposal.label', default: 'Proposal')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="body">
	        <g:if test="${flash.message}">
            <br /><div class="message">${flash.message}</div><br />
            </g:if>
            <h2>Proposed group in ${proposalInstance.location}</h2>
            <div class="dialog">
                <div style="margin-top:10px"><h3>Comments:</h3>
                   <p class="proposalComment">${fieldValue(bean:proposalInstance, field:'comment')}</p><br/>

                   <p>Submitted by <span style="font-weight:bold;">${fieldValue(bean:proposalInstance, field:'proposer')}</span> </p><br />
                   <sec:ifAllGranted roles="ROLE_ADMIN">
                       <p><input type="text" value="${proposalInstance.proposer.email}" /></p><br />
				   </sec:ifAllGranted>
                   <p><span class="button"><g:link action="registerInterest" id="${proposalInstance?.id}">Support This Group</g:link></span></p>
                   <div id="comments">
                       
                      <g:each in="${proposalInstance.interest.sort{it.id}}" status="i" var="interest">

                            <div class="comment">

                              <p style="font-weight:bold;">${interest.supporter}</p>

                              <sec:ifAllGranted roles="ROLE_ADMIN">
                                  <p style="font-weight:bold;"><input type="text" value="${interest.supporter.email}" /></p>
                              </sec:ifAllGranted>

                              <p>${interest.comment}<p>
                          </div>

                      </g:each>
                  </div>

               </div>
            </div>
            <sec:ifAllGranted roles="ROLE_ADMIN">
				<div class="buttons">
    				<span class="button"><g:link action="edit">Edit</g:link></span>
				</div>
			</sec:ifAllGranted>
        </div>
    </body>
</html>

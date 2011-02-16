
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

        <g:set var="entityName" value="${message(code: 'proposal.label', default: 'Proposal')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>

                            <th><g:message code="proposal.location.label" default="Location" /></th>

                            <g:sortableColumn property="proposer" title="${message(code: 'proposal.proposer.label', default: 'Proposer')}" />

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${proposalInstanceList}" status="i" var="proposalInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                            <td><g:link action="edit" id="${proposalInstance.id}">${fieldValue(bean: proposalInstance, field: "location")}</g:link></td>

                            <td>${fieldValue(bean: proposalInstance, field: "proposer")}</td>


                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>

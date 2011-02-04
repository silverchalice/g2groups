<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add a new Twitter account</title>
</head>
<body>
    <span style="color:red">${flash.error}</span>
    <h1>Add a new Twitter account</h1>
    <p>1. <g:link target="_blank" action="auth">Get a new PIN</g:link> (a new window will be opened. Click "allow", get the PIN and close window)</p>
    <p>2. Insert the PIN
    <g:form action="addAccount">
        <g:textField name="pin"/>
        <g:submitButton name="Enable account" value="send"/>
    </g:form>
    </p>
</body>
</html>
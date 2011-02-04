<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Simple GSP page</title>
    <style type="text/css">
    h1 {
        font: 14pt lucida, arial;
        margin: 20px 0 0 0;
        color: #4e763e;
        font-weight: bold;
    }

    #mentionsWrapper, #timelineWrapper, #rtsWrapper {
        border: 1px solid #37a3c1;
        max-height: 300px;
        width: 248px;
        overflow: auto;
    }

    #mentions, #timeline, #rts {
        width: 228px;
    }

    .tweet {
        width: 220px;
        min-height: 30px;
        color: #444;
        font: 9pt Arial;
        border-bottom: 1px dotted #37a3c1;
        padding: 6px 6px 10px 6px;
    }

    .tweet A {
        text-decoration: none;
        color: #37a3c1;
    }

    .tweet A.author {
        color: #4e763e;
        font-weight: bold;
    }

    .tweet .avatar {
        float: left;
        display: block;
        margin: 0 6px 0 0px;
    }

    .tweet IMG {
        width: 30px;
        height: 30px;
    }

    .tweet .text {
    }

    .tweet .foot {
        margin-top: 4px;
        color: #888;
        font: 7pt lucida, arial;
    }

    .tweet .foot A.reply {
        font-weight: bold;
    }



    </style>
</head>
<body>
<h1>My timeline</h1>
<div id="timelineWrapper">
    <div id="timeline">
        <twitterChecker:timeline max="10"/>
    </div>
</div>

<h1>Mentions</h1>
<div id="mentionsWrapper">
    <div id="mentions">
        <twitterChecker:mentions/>
    </div>
</div>

<h1>Retweets</h1>
<div id="rtsWrapper">
    <div id="rts">
        <twitterChecker:rts/>
    </div>
</div>

</body>
</html>
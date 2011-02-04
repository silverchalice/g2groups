<g:each in="${statuses}" var="tweet">
    <div class="tweet">

        <div class="text">

            <span class="tweetText"><twitterChecker:parseLinks>${tweet.text}</twitterChecker:parseLinks></span>
            <div class="foot">
                <span class="date">At ${tweet.createdAt.format("dd/MMM")}</span>
                <a class="reply" target="_blank" href="http://twitter.com/?status=@${tweet.user.screenName}%20&in_reply_to_status_id=${tweet.id}&in_reply_to=${tweet.user.screenName}">reply</a>
            </div>
        </div>
    </div>
</g:each>

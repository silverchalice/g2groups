<g:each in="${statuses}" var="tweet">
    <div class="tweet">
        <div class="avatar"><a href="${tweet.user.url?:'#'}" target="_blank"><img alt="${tweet.user.screenName}" title="${tweet.user.screenName}" src="${tweet.user.profileImageUrl}"/></a></div>
        <div class="text">
            <a class="author" href="http://twitter.com/${tweet.user.screenName}" target="_blank">${tweet.user.screenName}</a>:
            <span class="tweetText"><twitterChecker:parseLinks>${tweet.text}</twitterChecker:parseLinks></span>
            <div class="foot">
                <span class="date">At ${tweet.createdAt.format("dd/MMM")}</span>
                <a class="reply" target="_blank" href="http://twitter.com/?status=@${tweet.user.screenName}%20&in_reply_to_status_id=${tweet.id}&in_reply_to=${tweet.user.screenName}">reply</a>
            </div>
        </div>
    </div>
</g:each>

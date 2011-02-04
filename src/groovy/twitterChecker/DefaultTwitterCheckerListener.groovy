package twitterChecker

import org.apache.commons.logging.*
import org.springframework.beans.factory.annotation.*
import org.springframework.stereotype.*
import twitter4j.*

@Component("DefaultTwitterCheckerListenerBean")
class DefaultTwitterCheckerListener {

    @Autowired
    TwitterCheckerService twitterCheckerService

    static Log log = LogFactory.getLog(DefaultTwitterCheckerListener.class.getName())

    def onNewFollowers = { ids ->
        ids.each { id ->
            User user = twitterCheckerService.showUser(id) // The showUser() method makes a real Twitter request to get the user info
            log.debug "New follower: @${user.screenName}"

//            twitterCheckerService.sendDirectMessage(id, "Thank you for following me!")

        }
    }

    def onUnfollows = { ids ->
        ids.each { id ->
            User user = twitterCheckerService.showUser(id)
            log.debug  "Unfollow: @${user.screenName}"

//            twitterCheckerService.updateStatus("See you soon @${user.screenName}!")

        }
    }

    def onMentions = { statuses ->
        statuses.each { status ->
            log.debug  "New mention: $status.text"
        }
    }

    def onRetweets = { statuses ->
        statuses.each { status ->
            log.debug  "New RT: $status.text"
        }
    }
}

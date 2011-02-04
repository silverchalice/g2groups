package net.g2groups

import org.codehaus.groovy.grails.commons.*
import twitter4j.*
import twitter4j.http.*
import twitter4j.conf.*
import org.codehaus.groovy.grails.commons.GrailsApplication
import grails.util.GrailsUtil


class ProposalController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def mailService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        params.sort = 'id'
		params.order = 'desc'
        [proposalInstanceList: Proposal.list(params), proposalInstanceTotal: Proposal.count()]
    }

    def create = {
        def proposalInstance = new Proposal()
        proposalInstance.properties = params
        return [proposalInstance: proposalInstance]
    }

    def save = {
		        println params

		        def proposedGroup = new Proposal()
		        proposedGroup.properties = params

		        def user = User.findByEmail(params.email)
		        if (!user)
		            user = new User(params)
		        proposedGroup.proposer = user

		        if(!params.answer || params.answer != "4"){
			        flash.message = "There is a question at the bottom of the page. Please check your answer."
			        render(view: "create", model: [proposalInstance: proposedGroup, email:params.email, name:params.name])
			        return
		        }

		        if(!user.hasErrors() && user.save(failOnError:true) && !proposedGroup.hasErrors() && proposedGroup.save()){
			      mailService.sendMail{
				      from "G2Groups <feedback.g2groups@gmail.com>"
				      to "daveklein@usa.net", "ben@silver-chalice.com"
			          subject "[G2Groups] ${user?.name} wants to start a group in ${proposedGroup.location}"
			          body """
Hi, people. ${user?.name} just came to the G2Groups site and left a proposal for a group in ${proposedGroup?.location}.

${user?.name} says:
"${proposedGroup.comment}"

Merry Christmas!
			          """
			      }

		          def configured = ConfigurationHolder.config.twitterChecker.oauth.consumerKey && ConfigurationHolder.config.twitterChecker.oauth.consumerSecret

					ConfigurationBuilder cb = new ConfigurationBuilder();
					cb.setDebugEnabled(true)
					  .setOAuthConsumerKey(ConfigurationHolder.config.twitterChecker.oauth.consumerKey)
					  .setOAuthConsumerSecret(ConfigurationHolder.config.twitterChecker.oauth.consumerSecret)
					  .setOAuthAccessToken(ConfigurationHolder.config.twitterChecker.token)
					  .setOAuthAccessTokenSecret(ConfigurationHolder.config.twitterChecker.tokenSecret);
					TwitterFactory tf = new TwitterFactory(cb.build());
					Twitter twitter = tf.getInstance();

                  if (GrailsUtil.getEnvironment().equals(GrailsApplication.ENV_PRODUCTION)){
			          Status status = twitter.updateStatus("Someone has proposed a #Groovy user group in ${proposedGroup?.location}. Show your support at http://g2groups.net/proposed/${proposedGroup?.id}.");
			          println "Successfully updated the status to [" + status.text() + "]."
			      } else {
				      println "If I were running in production, I would have updated the status."
			      }
		
		          println proposedGroup
		          render(view:"thankyou", model:[proposal: proposedGroup])
		        } else {
			      flash.message = "There were errors with your proposal's information."
			      render(view: "create", model: [proposalInstance: proposedGroup, email:params.email, name:params.name])
		        }
    }

    def show = {
	    println params.id
        def proposalInstance = Proposal.get(params.id)
        if (!proposalInstance) {
            flash.message = "Couldn't find a group proposal with that ID."
            redirect(action: "list")
        }
        else {
            def supporters = []
            proposalInstance.interest.each{
	            supporters << it.supporter.email
            }
            [proposalInstance: proposalInstance, supporterEmails:supporters]
        }
    }

    def edit = {
        def proposalInstance = Proposal.get(params.id)
        if (!proposalInstance) {
            flash.message = "Couldn't find a group proposal with that ID."
            redirect(action: "list")
        }
        else {
            return [proposalInstance: proposalInstance]
        }
    }

    def update = {
        def proposalInstance = Proposal.get(params.id)
        if (proposalInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (proposalInstance.version > version) {
                    
                    proposalInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'proposal.label', default: 'Proposal')] as Object[], "Another user has updated this group proposal while you were editing")
                    render(view: "edit", model: [proposalInstance: proposalInstance])
                    return
                }
            }
            proposalInstance.properties = params
            if (!proposalInstance.hasErrors() && proposalInstance.save(flush: true)) {
                flash.message = "Updated ${proposalInstance?.proposer?.name}'s group proposal"
                redirect(action: "show", id: proposalInstance.id)
            }
            else {
                render(view: "edit", model: [proposalInstance: proposalInstance])
            }
        }
        else {
            flash.message = "Couldn't find a group proposal with that ID."
            redirect(action: "list")
        }
    }

    def delete = {
        def proposalInstance = Proposal.get(params.id)
        if (proposalInstance) {
            try {
                proposalInstance.delete(flush: true)
                flash.message = "Deleted proposal."
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "This proposal could not be deleted. (We got us a nice DataIntegrityViolationException.)"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "Couldn't find a group proposal with that ID."
            redirect(action: "list")
        }
    }

    def registerInterest = {
	    log.info("Beginning registerInterest action")
            println params
            def proposal = Proposal.get(params.id)
            [proposal:proposal]
    }

    def saveInterest = {
            println "Entering saveInterest action"
            println params
            println params.proposalId	    
            def interest = new Interest(params)
            def proposal = Proposal.get(params.proposalId)
            def supporters = []
            proposal.interest.each{
	            supporters << it.supporter.email
            }
	    def supporter = User.findByEmail(params.email)
	    if (!supporter)
	        supporter= new User(params)
	   
            interest.supporter = supporter
            interest.proposal = proposal
            interest.properties = params

	        if(!params.answer || params.answer != "4"){
		        flash.message = "There is a question at the bottom of the page. Please check your answer."
		        render(view: "registerInterest", model: [interest: interest, proposal: interest.proposal, user:supporter])
		        return
	        }

	    if(!supporter.hasErrors() && supporter.save() && !interest.hasErrors() && interest.save()){
                println "Interest saved"

                sendMail {
	              from "G2Groups <feedback.g2groups@gmail.com>"
                  to "${proposal.proposer.email}"
                  cc supporters
                  bcc "daveklein@usa.net", "ben@silver-chalice.com"
                  subject "[G2Groups] ${supporter.name} is interested in your proposed group"
                  if(interest.comment){
                      html """
                              Dear ${proposal.proposer.name},
    
                              <p>${supporter.name} has commented on your proposed group in ${proposal.location}.</p>
                              <p>"${interest.comment}"<br/>
                                  - ${supporter.name}, ${supporter.email}</p>
                              <p>Regards, <br/>
                                the <a href="http://g2groups.net">G2Groups</a> team </p>
                           """
                    } else { 
	                    html """
                              Dear ${proposal.proposer.name},

                              <p>${supporter.name} is interested in your proposed group in ${proposal.location}. Email: ${supporter.email}</p>
                              <p>Regards, <br/>
                                the <a href="http://g2groups.net">G2Groups</a> team </p>
                           """
                    }
                }

	        redirect(action:show, id :proposal.id)
	    }
	    else{
                println "Interest not saved"
                println interest
                println proposal
                interest.errors.allErrors.each {println it}
	        render(view:'registerInterest', model:[interest:interest, supporter:supporter, proposal:proposal])
	    }
    }

    def thankyou = {
        
    }

}

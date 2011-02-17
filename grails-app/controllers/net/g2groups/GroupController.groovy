package net.g2groups

class GroupController {
	
	def mailService
	def grailsApplication

    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static def allowedMethods = [deleteProposal:'GET', delete:'GET', save:'POST', update:'POST']

    def list = {
	    println("Beginning list action")
	    def d = new Date()

        session.searchClass = 'Groups' 
        [ groupInstanceList: Group.findAllByActive(true) ]
    }


	def admin_list = {
		[ groupInstanceList: Group.list() ]
	}

    def show = {
	
	    log.info("Beginning show action")
        def groupInstance = Group.get( params.id )

        if(!groupInstance) {
            flash.message = "Group not found with id ${params.id}"
            redirect(action:list)
        } else if (groupInstance && groupInstance.active == false){
	        flash.message = "This group is not active yet."
	        redirect(uri:'/')
        }
        else { return [ groupInstance : groupInstance ] }
    }

    def delete = {
        def groupInstance = Group.get( params.id )
        if(groupInstance) {
            try {
                groupInstance.delete(flush:true)
                flash.message = "Group ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Group ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Group not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def groupInstance = Group.get( params.id )

        if(!groupInstance) {
            flash.message = "Group not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ groupInstance : groupInstance ]
        }
    }

    def update = {
        def groupInstance = Group.get( params.id )
        if(groupInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(groupInstance.version > version) {
                    
                    groupInstance.errors.rejectValue("version", "group.optimistic.locking.failure", "Another user has updated this Group while you were editing.")
                    render(view:'edit',model:[groupInstance:groupInstance])
                    return
                }
            }
            groupInstance.properties = params
            if(!groupInstance.hasErrors() && groupInstance.save()) {
                flash.message = "Group ${params.id} updated"
                redirect(action:show,id:groupInstance.id)
            }
            else {
                render(view:'edit',model:[groupInstance:groupInstance])
            }
        }
        else {
            flash.message = "Group not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
	    log.info("Beginning create action")
        def groupInstance = new Group()
        groupInstance.properties = params
        return ['groupInstance':groupInstance]
    }

    def save = {
	    log.info("Beginning save action")
        def groupInstance = new Group(params)
        if(!groupInstance.hasErrors() && groupInstance.save()) {
            flash.message = "Group ${groupInstance.id} created"
            redirect(action:list)
        }
        else {
            render(view:'create',model:[groupInstance:groupInstance])
        }
    }


    def newGroup = {
	    log.info("Beginning newGroup action")
        def group = new Group()
        def user = new User()
        [group:group, user:user]
    }

    def saveGroup = {
        def group = new Group(params)
        def user = User.findByEmail(params.email)
        if (!user)
            user = new User(params)
        group.user = user
        if(!group.hasErrors() && group.save() && !user.hasErrors() && user.save()){
            redirect(action:thankyou, id:group.id)
        }
        else{

            render(view:'newGroup', model:[group:group, user:user])
        }
    }

//`At this time of the rolling year,' the spectre said `I suffer most. Why did I walk through crowds of fellow-beings with my eyes turned down, and never raise them to that blessed Star which led the Wise Men to a poor abode! Were there no poor homes to which its light would have conducted me!'

        def search = {
            println "Entering search action"

	    if (params.searchClass == 'Groups'){
		    session.searchClass = 'Groups'
		    def groupList
		    if (params.query) {
                        println params.query
		        def searchResult = Group.search(params.query)
		        println "here are the results ${searchResult}"
		        groupList = searchResult.results
                        println "About to render the results..."
		    }

		    else { groupList = Group.findAllByActive(true) }

                    render(view:'list', model:[groupInstanceList:groupList])
             }
        else{
	        session.searchClass="Proposals"
	        redirect(action:'searchProposals', params:params)
            }
        }

        def searchProposals = {

		    def proposalList
		    if (params.query) {
                        println params.query
		        def searchResult = Proposal.search(params.query)
		        println "here are the results ${searchResult}"
		        proposalList = searchResult.results
                        println "About to render the results..."
                        render(view:'proposedGroupList', model:[proposedGroups:proposalList])
		    }

		    else {
                        proposalList = Proposal.list()
                        render(view:'proposedGroupList', model:[proposedGroups:proposalList])
                    }
        }

        def p = {
	        def groupInstance = new Group()
	        groupInstance.properties = params
	        return ['groupInstance':groupInstance]
        }

        def pg = {
	        println "we just got into the pg action here, and the params are " + params
	        def groupInstance = new Group(params)
	        groupInstance.active = false
	        if(!groupInstance.hasErrors() && groupInstance.save(failOnError:true)) {
			    mailService.sendMail{
			        from "Groups <feedback.g2groups@gmail.com>"
			        to "daveklein@usa.net", "ben@silver-chalice.com"
		            subject "[Groups] ${groupInstance?.user?.name} wants to update a group proposal"
				    body """
Hi, people. ${groupInstance?.user?.name} just came to the Groups site and asked you to move the proposal for a group in ${groupInstance?.location} to a regular group.

Here is the group description:
"${groupInstance?.description}"

You can edit this group at http://g2groups.net/group/edit/${groupInstance?.id}.

Merry Christmas!
					          """
					      }
	            flash.message = "Your request has been sent, & we will take a look at it."
	            redirect(uri:'/')
	        }
	        else {
	            render(view:'p', model:[groupInstance:groupInstance])
	        }
        }


	def map = {

		def groups = Group.list()

		[groups: groups]

	}

	def latlong = {

		def APPID = grailsApplication.config.g2groups.yahoo.appId

		//def geocoder = "http://local.yahooapis.com/MapsService/V1/geocode?appid=${APPID}"

		def group = Group.get(params.id)

		if (group.latitude) geocoder += "&lat=" + URLEncoder.encode(group.latitude);
		if (group.longitude) geocoder += "&long=" + URLEncoder.encode(group.longitude);

		def xml = geocoder.toURL().text
		def records = new XmlParser().parseText(xml);

		location.latitude = records.Result[0].Latitude.text()
 		location.longitude = records.Result[0].Longitude.text()
	}


//'A chance and hope of my procuring, Ebenezer.'       

}

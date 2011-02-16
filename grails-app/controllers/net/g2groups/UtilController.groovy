package net.g2groups

import groovy.sql.Sql


class UtilController {

	def dataSource
	def springSecurityService

    def updateUsers = {
		def sql = Sql.newInstance(dataSource)
		sql.eachRow("select * from founder", { founder ->
			def user = new User(name: founder.founder_name,
					email: founder.email,
					username: founder.email,
					password:springSecurityService.encodePassword("${founder.founder_name.replaceAll(" ", "_")}g2g"),
					accountExpired:false,
					accountLocked: false,
					passwordExpired: false,
					enabled: true)

			if(!user.save(flush: true)) {
				user.errors.allErrors.each {println it}
			} else {
				sql.execute("update proposal set proposer_id = ${user.id} where proposer_id = ${founder.id}")
				sql.execute("update g2group set user_id = ${user.id} where founder_id = ${founder.id}")
			}




		} );


	}
}

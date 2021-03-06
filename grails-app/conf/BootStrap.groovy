import net.g2groups.*
import grails.util.GrailsUtil

class BootStrap {
	
	 def springSecurityService

     def init = { servletContext ->
          if(GrailsUtil.environment == "development") {
  
            def f1 = new User(name:'Dave Klein', email:'daveklein@usa.net').save()
            def g1 = new Group(name:'Gateway Groovy Users', location:'St. Louis, MO', website:'http://gatewaygroovy.org', user:f1, active:true)
            if (!g1.save()){
				g1.errors.allErrors.each{println it}
			}
            def g2 = new Group(name:'Madison Groovy Users', location:'Madison, WI', website:'http://madgroovy.org', user:f1, active:true)
            if (!g2.save()){
				g2.errors.allErrors.each{println it}
			}
            def pf1 = new User(name:'Wu Doo', email:'wudoo@gmail.com').save()
            def pg1 = new Proposal(location:'New York', comment:'I think we need a groovy user group in New York', proposer:pf1).save()
            def pf2 = new User(name:'Fred Marsh', email:'fmarsh@hotmail.com').save()
            def pg2 = new Proposal(location:'Banglore, India', comment:'I think we need a groovy user group in Banglore', proposer:pf1).save()
          }

          if(!User.findByUsername("admin")){
			  println "creating admin"
            def ar = Role.findByAuthority("ROLE_ADMIN")
            def a = new User(username:"admin", password:springSecurityService.encodePassword("password"), name:"administrator", email:"zak@silver-chalice.com", enabled: true, accountExpired: false, accountLocked: false, passwordExpired: false)
			
			if(!ar.save()) ar.errors.allErrors.each {println it}	
			if(!a.save()) a.errors.allErrors.each {println it}	
			
            UserRole.create a, ar
          }
     }
     def destroy = {
     }
} 

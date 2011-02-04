package net.g2groups

class User {

	String username
	String name
	String email
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static constraints = {
		username blank: false, unique: true
	    name(blank:false)
	    email(blank:false, email:true)
		password blank: false
	}

	static mapping = {
		password column: '`password`'
	}

    String toString(){ name }

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}
}

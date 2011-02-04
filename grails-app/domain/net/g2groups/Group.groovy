package net.g2groups

class Group {
    static Searchable = true

    String name
    String location
	String latitude
	String longitude

    String description
    String website
    Boolean active = false
    User user

    static constraints = {
        name(blank:false)
        location(blank:false)
        website(blank:false)
        description(size:0..1000, blank:true, nullable:true) 
        user(nullable:true)
		latitude(nullable:true)
		longitude(nullable:true)
    }

	static mapping = {
	    table 'g2group'
	}
   
    String toString(){name}
}

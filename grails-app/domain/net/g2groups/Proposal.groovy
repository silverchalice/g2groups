package net.g2groups

class Proposal {
    static Searchable = true

    String location
    String comment
    User proposer
	String latitude
	String longitude
    static hasMany = [interest:Interest]

    static constraints = {
        location(blank:false)
        comment(nullable:true, blank:true, size:0..1000)
        interest(nullable:true)
		latitude(nullable:true)
		longitude(nullable:true)
    }
    
    String toString(){location}
}

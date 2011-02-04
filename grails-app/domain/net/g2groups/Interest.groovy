package net.g2groups

class Interest {
    String comment
    User supporter
    Proposal proposal

    static belongsTo = Proposal
      
    static constraints = {
       comment(nullable:true, blank:true, size:0..1000)
       supporter(nullable:false)
       proposal(nullable:false)
    }
}

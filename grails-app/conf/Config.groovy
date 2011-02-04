import grails.plugins.springsecurity.SecurityConfigType

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text-plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]
// The default codec used to encode data with ${}
grails.views.default.codec="none" // none, html, base64
grails.views.gsp.encoding="UTF-8"
grails.converters.encoding="UTF-8"

// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://www.changeme.com"
    }
}

// log4j configuration
log4j {
    appender.stdout = "org.apache.log4j.FileAppender"
    appender.'stdout.layout'="org.apache.log4j.PatternLayout"
    appender.'stdout.layout.ConversionPattern'='[%r] %c{2} %m%n'
    appender.'stdout.File'="g2g_out.log"
    appender.stacktraceLog = "org.apache.log4j.FileAppender"
    appender.'stacktraceLog.layout'="org.apache.log4j.PatternLayout"
    appender.'stacktraceLog.layout.ConversionPattern'='[%r] %c{2} %m%n'
    appender.'stacktraceLog.File'="stacktrace.log"
    rootLogger="info,stdout"
    logger {
        grails="info"
        StackTrace="error,stacktraceLog"
        org {
            codehaus.groovy.grails.web.servlet="error"  //  controllers
            codehaus.groovy.grails.web.pages="info" //  GSP
            codehaus.groovy.grails.web.sitemesh="error" //  layouts
            codehaus.groovy.grails."web.mapping.filter"="error" // URL mapping
            codehaus.groovy.grails."web.mapping"="error" // URL mapping
            codehaus.groovy.grails.commons="info" // core / classloading
            codehaus.groovy.grails.plugins="error" // plugins
            codehaus.groovy.grails.orm.hibernate="error" // hibernate integration
            springframework="off"
            hibernate="off"
        }
    }
    additivity.StackTrace=false
}


grails {
   mail {
     host = "smtp.gmail.com"
     port = 465
     username = "feedback.g2groups@gmail.com"
     password = "gm5551212"
     props = ["mail.smtp.auth":"true", 					   
              "mail.smtp.socketFactory.port":"465",
              "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
              "mail.smtp.socketFactory.fallback":"false"]

} }

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'UserRole'
grails.plugins.springsecurity.authority.className = 'Role'
grails.plugins.springsecurity.requestMap.className = 'Requestmap'
grails.plugins.springsecurity.securityConfigType = SecurityConfigType.InterceptUrlMap

grails.plugins.springsecurity.interceptUrlMap = [
   '/':                                  ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/proposed':                          ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/propose':                           ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/group/show/**':                   ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/group/list':                      ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/group/p':                         ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/group/pg':                        ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/group/search':                    ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/group/searchProposals':           ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/proposed/**':                       ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/proposal/registerInterest/**':      ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/proposal/saveInterest':             ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/proposal/list':                     ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/proposal/save':                     ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/js/**':                             ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/css/**':                            ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/images/**':                         ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/*':                                 ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/login/**':                          ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/logout/**':                         ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/proposal/edit/**':                                    ['ROLE_ADMIN'],
   '/proposal/update':                                     ['ROLE_ADMIN'],
   '/g2Group/create':                                      ['ROLE_ADMIN'],
   '/g2Group/save':                                        ['ROLE_ADMIN'],
   '/g2Group/edit/**':                                     ['ROLE_ADMIN'],
   '/g2Group/update':                                      ['ROLE_ADMIN'],
   '/**':                                                  ['ROLE_ADMIN']
]


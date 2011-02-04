class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
	  "/"(controller:'group', action:'list')
	
	  "500"(view:'/error')
          "/proposed"(controller:'proposal', action:'list')
	  "/propose"(controller:'proposal', action:'create')
	  "/proposed/$id"(controller:'proposal', action:'show')
	}
}

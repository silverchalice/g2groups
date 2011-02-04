dataSource {
	 pooled = true
}

hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
         	driverClassName = "com.mysql.jdbc.Driver"
         	username = "g2g"
         	password = "nevergivein89"

			dbCreate = "update"
			url = "jdbc:mysql://localhost:3306/g2g"
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:hsqldb:mem:testDb"
		}
	}
	production {
		dataSource {
			pooled = false
         	driverClassName = "com.mysql.jdbc.Driver"
         	username = "g2g"
         	password = "nevergivein89"

			dbCreate = "update"
			url = "jdbc:mysql://localhost:3306/g2g"
			

		}
	}
}

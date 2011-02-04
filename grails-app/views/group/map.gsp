<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Map</title>

		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=true_or_false&amp;key=ABQIAAAAXeAx6Va9xJMTHMkJ3KHQXBSJGSVjnGeLiZeTQg2BDNUcF0RZChSmXz2E5iewntNI2BPdrZTRDUeT7Q" type="text/javascript"></script>


		<style type="text/css">
			div#map {
				width: 480px;
				height: 300px;
			}
		</style>



		<script type="text/javascript">

			$(mapContainer).dialog({ autoOpen: false })

			function initialize_map()	{
	//			var map = new YMap(document.getElementById('ymap'));
	//			map.addTypeControl();
	//			map.addZoomLong();
	//			map.addPanControl();
	//			map.setMapType(YAHOO_MAP_REG);

	//			var hq = new YGeoPoint(1, 1);
	// 			map.drawZoomAndCenter(hq, 17);

				var map = new GMap2(document.getElementById("map"));
				map.setCenter(new GLatLng(39.754286, -104.994637), 1);
				map.addControl(new GLargeMapControl());
				map.addControl(new GMapTypeControl());
				map.setMapType(G_NORMAL_MAP);

				<g:each var="group" in="${groups}">

					<g:if test="${group.latitude && group.longitude}">

						var m${group.id} = new GMarker(new GLatLng(${group.latitude},${group.longitude}))
						map.addOverlay(m${group.id});

					   GEvent.addListener(m${group.id}, "click", function() {
						  m${group.id}.openInfoWindowHtml("<a href='${group.website}'>${group.name}</a>");
						});

					</g:if>

				</g:each>

			}

		</script>

	</head>



	<body onload="initialize_map()">

		<h1>My Google Map</h1>

		<div id="map"></div>

	</body>
</html>
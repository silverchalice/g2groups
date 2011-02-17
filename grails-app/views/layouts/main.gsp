<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--

Design by Free CSS Templates
http://www.freecsstemplates.org
Released for free under a Creative Commons Attribution 2.5 License

Title      : Boorish
Version    : 1.0
Released   : 20080123
Description: A wide two-column design suitable for blogs and small websites.

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>g2groups.net</title>
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=ABQIAAAAUBuwYLt8MoHV8G-JyWegDxSJGSVjnGeLiZeTQg2BDNUcF0RZChTYQCUB_Yogm-ABhaNK6_c9361Pdg" type="text/javascript"></script>

	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
	<link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	<g:layoutHead />
	<g:javascript library="jquery" plugin="jquery"/>
	<jqui:resources/>

	<link rel="stylesheet" type="text/css" href="${resource(dir:'jquery-ui/themes/smoothness', file:'jquery-ui-1.8.7.custom.css')}">


	<script type="text/javascript">

		$(document).ready(function() {

			$("#x").button();

			$("#mapWrapper").dialog({
				autoOpen: false,
				modal: true,
				width: 605,
				height:440,
				resizable: false,
				title: 'G2Groups around the World'
			});

			$("#mapThumb").click(function() {
				$("#mapWrapper").dialog("open");
				initialize_map();
			});

		});




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

			<% def groups%>

			<g:if test="${groupInstanceList}">
				<% groups = groupInstanceList %>
			</g:if>
			<g:else>
				<% groups = proposalInstanceList %>
			</g:else>

			<g:each var="group" in="${groups}">
				<g:if test="${groupInstanceList}">
					var info = "<a href='${group.website}'>${group.name}</a>"
				</g:if>
				<g:else>
					var info = "${group.proposer}"
				</g:else>
				<g:if test="${group.latitude && group.longitude}">

					var m${group.id} = new GMarker(new GLatLng(${group.latitude},${group.longitude}))
					map.addOverlay(m${group.id});

				   GEvent.addListener(m${group.id}, "click", function() {
					  m${group.id}.openInfoWindowHtml(info);
					});

				</g:if>

			</g:each>

		}

	</script>

	<style type="text/css">
		div#map {
			width: 572px;
			height: 400px;
		}

		#x {
			padding: 1px 1px 3px;
			margin-left:5px;
			color:#299d5d;
		}



		.ui-widget-header {
			color:#299d5d;
		}
	</style>

</head>
<body>
<!-- start header -->
<div id="header">
<div id="logo">
		<img class="logo" src="${createLinkTo(dir:'images',file:'grails_logo.png')}" />
	</div>
	<div id="menu">
		<ul>
			<li><span class="menuButton"><g:link controller="group" action="list">active<br/> groups</g:link></span></li>
                        <li> <span class="menuButton"><g:link controller="proposal" action="list">proposed <br/>groups</g:link></span></li>
                        <li> <span class="menuButton"><g:link class="create" controller="proposal" action="create">propose<br/>a  group</g:link></span></li>
		</ul>
	</div>
</div>
<!-- end header -->
<!-- start page -->
<div id="page">
	<!-- start leftbar -->
	
	<!-- start content -->
	<div id="content">
		<div id="mapWrapper">
			<div id="map"></div>
		</div>

		<g:layoutBody />
		
	</div>
	<!-- end content -->
<!-- end page -->
        <div id="sidebar">
		<ul>
                    <li id="search">
                        <img class="headerImage" src="${createLinkTo(dir:'images',file:'search.png')}" />
                        <g:form controller='group' action="search">
                            <fieldset>
                                    <input type="text" id="query" name="query" value="" /><input type="submit" id="x" value="search" /><br/>
                                    <g:if test="${session?.searchClass == 'Groups'}">
                                        <g:radio name='searchClass' value='Groups' checked='true' /><strong>Active</strong> Groups <br/>
                                        <g:radio name="searchClass" value="Proposals" /><strong>Proposed</strong> Groups
                                    </g:if>
                                    <g:else>
                                        <g:radio name='searchClass' value='Groups' /><b>Active</b> Groups<br/>
                                        <g:radio name="searchClass" value="Proposals" checked='true' /><b>Proposed</b> Groups
                                    </g:else>
                                        
                                            
                            </fieldset>
                        </g:form>
                        <img class="headerImage" src="${createLinkTo(dir:'images',file:'sidebar.png')}" />
                    </li>

                    <li>
                        <img class="headerImage" src="${createLinkTo(dir:'images',file:'welcome.png')}" />
                        <p>
                          This site is dedicated to Groovy-related user groups. You can check out existing groups, propose one in your area, or show your support for a proposed group. 
                        </p>
                        <img class="divider" src="${createLinkTo(dir:'images',file:'sidebar.png')}" />
                    </li>
                    <li>
	                    <h3> is your group listed here?</h3>
                        <p>
                          If your group is listed as <g:link controller="proposal" action="list">proposed</g:link> but is currently <strong>active</strong>, <g:link controller="group" action="p">give us the group information</g:link> so we can do something about it.
                        </p>
                        <img class="divider" src="${createLinkTo(dir:'images',file:'sidebar.png')}" />
                    </li>
					<li>
						<a id="mapThumb" href="javascript:openMap()"><img style="margin-left:20px" src="${resource(dir:'images', file:'map-thumb.png')}" />  </a>
						<img class="divider" src="${createLinkTo(dir:'images',file:'sidebar.png')}" />
					</li>

                    <li>
                        <a style="margin-left:50px" href="http://twitter.com/g2groups"><img class="headerImage" src="${createLinkTo(dir:'images',file:'GreenTwitterBird.png')}" /></a>
                        <img class="divider" src="${createLinkTo(dir:'images',file:'sidebar.png')}" />
                    </li>
                    <li>
                        <img class="headerImage" src="${createLinkTo(dir:'images',file:'beta.png')}" />
                        <p>
                          This site is currently in <b>beta</b>; we appreciate your feedback! If you have an idea or complaint, <a href="mailto:feedback.g2groups@gmail.com">please let us know!</a><br />
                        </p>
                    </li>
		</ul>
		<div style="clear: both;">&nbsp;</div>
	</div>
	<!-- end sidebar -->
        <div id="footer">
	         <p id="legal">&copy;2011 <a href="http://silver-chalice.com/">Silver Chalice</a>. All Rights Reserved. | Design by <a href="http://www.freecsstemplates.org/">FCT</a>.</p>
        </div>


</div>
<!-- end page -->
</div>
</body>
</html>

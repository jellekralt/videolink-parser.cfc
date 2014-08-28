<cfcomponent name="videolink-parser" displayname="Videolink Parser" hint="Parses links for video sites like YouTube and Vimeo and converts them to embed links and codes">

	<cffunction name="embed" returnType="string" access="public" output="false" displayname="Embed" description="Generates an embed code for a video link">
		<cfargument name="link" type="string" required="true" displayname="Link" hint="Link to the video resource" /> 
		
		<cfset var videoLinkInfo = parseLink(arguments.link) />
		
		<cfreturn embedTemplate(videoLinkInfo.link.player, videoLinkInfo.type) />
	</cffunction>

	<cffunction name="playerLink" returnType="string" access="public" output="false" displayname="Player link" description="Generates the link to the player">
		<cfargument name="link" type="string" required="true" displayname="Link" hint="Link to the video resource" /> 
		
		<cfreturn parseLink(arguments.link).link.player />
	</cffunction>

	<cffunction name="parseLink" returntype="struct" access="private" displayname="Parse link" description="Parses a link and returns information about it">
		<cfargument name="link" type="string" required="true" displayname="Link" hint="Link to the video resource" /> 

		<cfset var sVideoInfo = {
			id = "",
			type = "",
			link = {
				original = "",
				player = ""
			}
		} />
		<cfset var aPatterns = [
			{
				regex = ".*youtu\.be\/([\w\-.]+)", 
				type = "youtube",
				url = "//www.youtube.com/embed/$1"
			},
			{
				regex = ".*youtube\.com(.+)v=([^&]+)", 
				type = "youtube",
				url = "//www.youtube.com/embed/$2"
			},
			{
				regex = ".*vimeo\.com\/([0-9]+)", 
				type = "vimeo",
				url = "//player.vimeo.com/video/$1"
			},
			{
				regex = ".*vimeo\.com\/(.*)\/([0-9]+)", 
				type = "vimeo",
				url = "//player.vimeo.com/video/$2"
			}
		] />
		<cfset var urlPosition = 0 />
		<cfset var regexMatch = false />
		<cfset var videoID = ""/>

		<!--- Loop all patterns --->
		<cfloop array="#aPatterns#" index="pattern">

			<!--- Check if the link matches the pattern's regex --->
			<cfif arrayLen(reMatchNoCase(pattern.regex, arguments.link))>

				<cfset urlPosition = reMatchNoCase("\$[0-9]",pattern.url) />
				<cfset urlPosition = replace(urlPosition[1], "$", "") />
				<cfset sVideoInfo.id = reReplaceNoCase(arguments.link, pattern.regex, "\#urlPosition#") />
				<cfset sVideoInfo.type = pattern.type />
				<cfset sVideoInfo.link.original = arguments.link />
				<cfset sVideoInfo.link.player = reReplaceNoCase(pattern.url, "\$[0-9]", sVideoInfo.id) />

				<cfbreak />
			</cfif>
		</cfloop>

		<cfreturn sVideoInfo />
	</cffunction>

	<cffunction name="embedTemplate" returntype="string" displayname="Embed template" description="Generates an embed template based on the video service type">
		<cfargument name="url" type="string" required="true" displayname="Video URL" hint="URL of the video player" />
		<cfargument name="type" type="string" required="true" displayname="Video service type" hint="Type of video service" />

		<cfswitch expression="#arguments.type#">
			<cfcase value="youtube">
				<cfreturn '<iframe src="#arguments.url#" frameborder="0" allowfullscreen></iframe>' />
			</cfcase>
			<cfcase value="vimeo">
				<cfreturn '<iframe src="#arguments.url#" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>' />
			</cfcase>
			<cfdefaultcase>
				<cfreturn "Invalid video type" />
			</cfdefaultcase>
		</cfswitch>

	</cffunction>

</cfcomponent>
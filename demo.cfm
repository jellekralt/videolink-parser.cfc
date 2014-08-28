<cfset videoLinkParser = createObject("component", "videolink-parser") />

<cfset youtube = "https://www.youtube.com/watch?v=oHg5SJYRHA0" />

<cfdump var="#videoLinkParser.embed(youtube)#" />
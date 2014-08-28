<cfset videoLinkParser = createObject("component", "videolink-parser") />

<cfset youtube = "https://www.youtube.com/watch?v=oHg5SJYRHA0" />

<h1>Video link parser demo</h1>
<p>This demo shows the parsers input and output</p>
<cfoutput>

	<h2>Input</h2>
	<p>Demo link: #youtube#</p>

	<h2>Output</h2>
	<p><strong>Embed code - embed()</strong></p>
	<cfdump var="#videoLinkParser.embed(youtube)#" />

	<p><strong>Player link - playerLink()</strong></p>
	<cfdump var="#videoLinkParser.playerLink(youtube)#" />
</cfoutput>
videolink-parser.cfc
====================

This cfc parses links for video sites like YouTube and Vimeo and convert them to embed links and codes
In short, it converts this:

```
https://www.youtube.com/watch?v=oHg5SJYRHA0
```

To this:

```html
<iframe src="//www.youtube.com/embed/oHg5SJYRHA0" frameborder="0" allowfullscreen></iframe>
```

## Usage
```coldfusion

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
```

## Video website support
The module currently supports the following video websites:

### YouTube
The module supports the following YouTube link formats
* https://www.youtube.com/watch?v=oHg5SJYRHA0
* http://youtu.be/oHg5SJYRHA0

### Vimeo
The module supports the following Vimeo link formats
* http://vimeo.com/2619976

### Other websites
If you'd like other video websites to be supported you are more than welcome to submit a pull request or an issue requesting a site :smiley:

## Licence
MIT: http://jellekralt.mit-license.org/

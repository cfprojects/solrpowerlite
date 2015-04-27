<cfcomponent output="false">
<!---
/**
 * @copyright Earl Gregg Swem Library. (http://swem.wm.edu)
 * @license Apache Licence, Version 2.0 (http://www.apache.org/licenses/LICENSE-2.0)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @package client.coldfusion
 * @author Wayne Graham <wsgrah@wm.edu>
 * @version = 2007-10-04
 */
--->

<!--- response version supported --->
<cfset SOLR_VERSION = "2.2" />

<!--- default response writer --->
<cfset SOLR_WRITER = "Standard" />

<!--- servlet mappings --->
<cfset PING_SERVLET = "/admin/ping" />
<cfset UPDATE_SERVLET = "/update" />
<cfset SEARCH_SERVLET = "/select" />
<cfset THREADS_SERVLET = "/admin/threads" />

<!--- server identification strings --->
<cfset variables.host = "" />
<cfset variables.port = "" />
<cfset variables.path = "" />
<cfset variables.solrStem = "" />

<cfset variables.updateUrl = "" />
<cfset variables.searchUrl = "" />
<cfset variables.threadsUrl = "" />


<cffunction name="init" access="public" output="false" returntype="SolColdfusion">
	<cfargument name="host" required="true" type="string" hint="Solr Server host" />
	<cfargument name="port" required="false" type="numeric" default="8080" hint="Port Solr server is running on" />
	<cfargument name="path" required="false" type="string" default="/solr" hint="Path to solr instance">

	<cfset setHost(arguments.host) />
	<cfset setPort(arguments.port) />
	<cfset setPath(arguments.path) />

	<cfset setSolrStem(getHost(), getPath()) />

	<cfreturn this/>

</cffunction>

<cffunction name="search" access="public" output="false" hint="Search for documents in the Solr index">
	<cfargument name="q" type="string" required="true" hint="Raw query string" />
	<cfargument name="start" type="numeric" required="false" default="0" hint="Starting offset for the result documents" />
	<cfargument name="limit" type="numeric" required="false" default="0" hint="Maximum number of documents to return" />
	<cfargument name="params" type="array" required="false" hint="Key value pairs of Solr values" />

	<cfset var response = "" />
	<cfset var queryURL = getSolrStem() & SEARCH_SERVLET />
	<cfset var i = "" />
	<cfset var debugURL = ""/>
	
	 <cfhttp url="#queryURL#" port="#getPort()#" result="response">
		<cfhttpparam name="version" value="#variables.SOLR_VERSION#" type="url" />
		<cfhttpparam name="q" value="#arguments.q#" type="url" />
		<cfhttpparam name="start" value="#arguments.start#" type="url" />
		<cfhttpparam name="rows" value="#arguments.limit#" type="url" />

		<cfif structKeyExists(arguments, "params") AND arrayLen(arguments.params) GT 0>
			<!--- loop over parameters. Some can be used more than once --->
			<cfloop from="1" to="#arrayLen(arguments.params)#" index="i">
				<cfhttpparam name="#arguments.params[i][1]#" value="#arguments.params[i][2]#" type="url" />
			</cfloop>
		</cfif>
	</cfhttp>
	
	<cfif structkeyexists(url,"debug")>
		<cfset debugURL = queryURL & "version=#variables.SOLR_VERSION#&q=#arguments.q#&start=#arguments.start#&rows=#arguments.limit#"/>
		<cfif structKeyExists(arguments, "params") AND arrayLen(arguments.params) GT 0>
			<!--- loop over parameters. Some can be used more than once --->
			<cfloop from="1" to="#arrayLen(arguments.params)#" index="i">
				<cfset debugURL = debugURL & "&#arguments.params[i][1]#=#arguments.params[i][2]#"/>
			</cfloop>
		</cfif>
		<cflog file="solr" type="information" text="#debugurl#">
	</cfif>

	<!--- TODO: deal with non-XML response formats --->

	<cfreturn response.fileContent />

</cffunction>

<cffunction name="add" access="public" description="Adds an XML record to the Solr repository" output="true">
	<cfargument name="document" type="XML" required="true" />

	<cfset var updateURL = getSolrStem() & UPDATE_SERVLET />
	<cfset var response = "" />
	<cfset var ret = ""/>
	<cftry>
	<!--- submit the document to the repository --->
	<cfhttp url="#updateURL#" port="#getPort()#" method="post" result="response">
		<cfhttpparam type="xml" value="#document#" />
	</cfhttp>

	<cfset ret = xmlParse(response.FileContent) />
	<cfcatch type="any">
	<cfoutput>#cfcatch.Message# - #cfcatch.Detail# <cfdump var="#response#">
	
		<textarea rows="40" cols="80">#document# 
			#response.FileContent#</textarea>
		</cfoutput><cfabort>
	</cfcatch>
	</cftry>
	
	<cfreturn ret />
</cffunction>

<cffunction name="deleteById" access="public" output="false" description="Deletes a single record by ID">
	<cfargument name="id" type="string" required="true" hint="Id of the document to delete from the index" />
	<cfargument name="fromPending" type="boolean" required="false" default="true" hint="" />
	<cfargument name="fromCommitted" type="boolean" required="false" default="true" hint=""/>

	<cfset var response = "" />
	<cfset var updateURL = getSolrStem() & UPDATE_SERVLET />
	<cfset var solrDelete = "" />

	<cfxml variable="solrDelete">
		<cfoutput>
			<delete fromPending="#arguments.fromPending#" fromCommitted="#arguments.fromCommitted#">
				<id>#trim(arguments.id)#</id>
			</delete>
		</cfoutput>
	</cfxml>

	<cfhttp url="#updateURL#" port="#getPort()#" method="post" result="response">
		<cfhttpparam value="#solrDelete#" type="xml" />
	</cfhttp>

	<cfreturn xmlParse(response.FileContent) />
</cffunction>

<cffunction name="deleteByQuery" access="public" output="false" hint="Delete a series of items from the index by a query">
	<cfargument name="query" type="string" required="true" hint="Query that matches ALL the elements that will be deleted. Takes the format field:queryValue" />
	<cfargument name="fromPending" type="boolean" required="false" default="true" hint="" />
	<cfargument name="fromCommitted" type="boolean" required="false" default="true" hint=""/>

	<cfset var response = "" />
	<cfset var updateURL = getSolrStem() & UPDATE_SERVLET />
	<cfset var solrDelete = "" />

	<cfxml variable="solrDelete">
		<cfoutput>
			<delete fromPending="#arguments.fromPending#" fromCommitted="#arguments.fromCommitted#">
				<query>#trim(arguments.query)#</query>
			</delete>
		</cfoutput>
	</cfxml>

	<cfhttp url="#updateURL#" port="#getPort()#" method="post" result="response">
		<cfhttpparam value="#solrDelete#" type="xml" />
	</cfhttp>

	<cfreturn xmlParse(response.FileContent) />

</cffunction>

<cffunction name="purgeIndex" access="public" output="false" hint="Delete a series of items from the index by a query">
	<cfset var response = "" />
	<cfset var updateURL = getSolrStem() & UPDATE_SERVLET />
	<cfset var solrDelete = "" />

	<cfxml variable="solrDelete"><cfoutput><delete><query>*:*</query></delete></cfoutput></cfxml>

	<cfhttp url="#updateURL#" port="#getPort()#" method="post" result="response">
		<cfhttpparam value="#solrDelete#" type="xml" />
	</cfhttp>

</cffunction>

<cffunction name="commit" access="public" output="false" hint="Commits documents to the index">

	<cfargument name="waitFlush" required="false" default="true" type="boolean" hint="block until index changes are flushed to disk" />
	<cfargument name="waitSearcher" required="false" default="true" type="boolean" hint="block until a new searcher is opened and registered as the main query searcher, making the changes visible" />

	<cfset var updateURL = getSolrStem() & UPDATE_SERVLET />
	<cfset var response = "" />
	<cfset var commitString = '<commit waitFlush="' & arguments.waitFlush & '" waitSearcher="' & arguments.waitsearcher & '"/>' />

	<cfhttp url="#updateURL#" port="#getPort()#" method="post" result="response">
		<cfhttpparam value="#xmlParse(commitString)#" type="xml" />
	</cfhttp>
		
	<cfreturn xmlParse(response.FileContent) />
</cffunction>

<cffunction name="optimize" access="public" output="false" returntype="xml" hint="Optimizes the index (if it runs slow)">
	<cfargument name="waitFlush" required="false" default="true" type="boolean" hint="block until index changes are flushed to disk" />
	<cfargument name="waitSearcher" required="false" default="true" type="boolean" hint="block until a new searcher is opened and registered as the main query searcher, making the changes visible" />

	<cfset var updateURL = getSolrStem() & UPDATE_SERVLET />
	<cfset var response = ""/>
	<cfset var optimizeString = '<optimize waitFlush="' & arguments.waitFlush & '" waitSearcher="' & arguments.waitsearcher & '"/>' />
	<cfset var ret = "" />
	<cfhttp url="#updateURL#" port="#getPort()#" method="post" result="response">
		<cfhttpparam value="#xmlParse(optimizeString)#" type="xml" />
	</cfhttp>
	<cftry>
		<cfset ret =  xmlParse(response.FileContent) />
	<cfcatch type="any">
		<cfoutput>#response.FileContent#</cfoutput><cfabort>
	</cfcatch>
	</cftry>
	<cfreturn ret/>
</cffunction>

<cffunction name="ping" access="public" hint="Returns the response time for the ping in milliseconds">
	<cfargument name="timeout" type="numeric" required="false" default="5" />

	<cfset var start = getTickCount() />
	<cfset var pingURL = getSolrStem() & PING_SERVLET />
	<cfset var end = "" />

	<cfhttp timeout="#timeout#" url="#pingURL#" port="#getPort()#"></cfhttp>

	<cfset end = getTickCount() />

	<cfif cfhttp.StatusCode IS "200 OK">
		<cfreturn (end - start) />
	<cfelse>
		<cfreturn "Timeout">
	</cfif>

</cffunction>

<cffunction name="getSolrStem" returntype="string" access="public" hint="Returns the Solr URL stem">
	<cfreturn variables.solrStem />
</cffunction>

<cffunction name="setSolrStem" returntype="void" access="public" hint="Creates a stem URL for Solr queries for use with CFHTTP">
	<cfargument name="host" type="string" required="true" />
	<cfargument name="path" type="string" required="true" />

	<cfset var stem = arguments.host & arguments.path />

	<!--- clean double "//" characters from stem
	<cfset stem = rereplace(stem, "//", "/", "ALL") />--->

	<cfset variables.solrStem = stem />

	<cfreturn />
</cffunction>

<cffunction name="getHost" returntype="string">
	<cfreturn variables.host />
</cffunction>

<cffunction name="getPort" returntype="String">
	<cfreturn variables.port />
</cffunction>

<cffunction name="getPath" returntype="string">
	<cfreturn variables.path />
</cffunction>

<cffunction name="setHost">
	<cfargument name="host" required="true" type="string" hint="Solr Server host" />
	<cfset variables.host = arguments.host />
	<cfreturn />
</cffunction>

<cffunction name="setPort">
	<cfargument name="port" required="false" type="numeric" default="8080" hint="Port Solr server is running on" />
	<cfset variables.port = arguments.port />
	<cfreturn />
</cffunction>

<cffunction name="setPath">
	<cfargument name="path" required="false" type="string" default="/solr/" hint="Path to solr instance">
	<cfset variables.path = arguments.path />
	<cfreturn />
</cffunction>

<!--- Utility functions --->
<cfscript>
/**
 * Merges one xml document into another
 *
 * @param xml1 	 The XML object into which you want to merge (Required)
 * @param xml2 	 The XML object from which you want to merge (Required)
 * @param overwriteNodes 	 Boolean value for whether you want to overwrite (default is true) (Optional)
 * @return void (changes the first XML object)
 * @author Nathan Dintenfass (nathan@changemedia.com)
 * @version 1, November 2, 2003
 */
function xmlMerge(xml1,xml2){
	var readNodeParent = arguments.xml2;
	var writeNodeList = arguments.xml1;
	var writeNodeDoc = arguments.xml1;
	var readNodeList = "";
	var writeNode = "";
	var readNode = "";
	var nodeName = "";
	var ii = 0;
	var writeNodeOffset = 0;
	var toAppend = 0;
	var nodesDone = structNew();
	//by default, overwrite nodes
	var overwriteNodes = false;
	//if there's a 3rd arguments, that's the overWriteNodes flag
	if(structCount(arguments) GT 2)
		overwriteNodes = arguments[3];
	//if there's a 4th argument, it's the DOC of the writeNode -- not a user provided argument -- just used when doing recursion, so we know the original XMLDoc object
	if(structCount(arguments) GT 3)
		writeNodeDoc = arguments[4];
	//if we are looking at the whole document, get the root element
	if(isXMLDoc(arguments.xml2))
		readNodeParent = arguments.xml2; // changed this from readNodeParent = arguments.xml2.xmlRoot (was skipping root node) TODO: fix this better
	//if we are looking at the whole Doc for the first element, get the root element
	if(isXMLDoc(arguments.xml1))
		writeNodeList = arguments.xml1.xmlRoot;
	//loop through the readNodeParent (recursively) and override all xmlAttributes/xmlText in the first document with those of elements that match in the second document
	for(nodeName in readNodeParent){
		writeNodeOffset = 0;
		//if we haven't yet dealt with nodes of this name, do it
		if(NOT structKeyExists(nodesDone,nodeName)){
			readNodeList = readNodeParent[nodeName];
			//if there aren't any of this node, we need to append however many there are
			if(NOT structKeyExists(writeNodeList,nodeName)){
				toAppend = arrayLen(readNodeList);
			}
			//if there are already at least one node of this name
			else{
				//if we are overwriting nodes, we need to append however many there are minus however many there were (if there none new, it will be 0)
				if(overWriteNodes){
					toAppend = arrayLen(readNodeList) - arrayLen(writeNodeList[nodeName]);
				}
				//if we are not overwriting, we need to add however many there are
				else{
					toAppend = arrayLen(readNodeList);
					//if we are not overwriting, we need to make the offset of the writeNode equal to however many there already are
					writeNodeOffset = arrayLen(writeNodeList[nodeName]);
				}
			}
			//append however many nodes necessary of the name
			for(ii = 1;  ii LTE toAppend; ii = ii + 1){
				arrayAppend(writeNodeList.xmlChildren,xmlElemNew(writeNodeDoc,nodeName));
			}
			//loop through however many of this nodeName there are, writing them to the writeNodes
			for(ii = 1; ii LTE arrayLen(readNodeList); ii = ii + 1){
				writeNode = writeNodeList[nodeName][ii + writeNodeOffset];
				readNode = readNodeList[ii];
				//set the xmlAttributes and xmlText to this child's values
				writeNode.xmlAttributes = readNode.xmlAttributes;
				writeNode.xmlText = readNode.xmlText;
				//if this element has any children, recurse
				if(arrayLen(readNode.xmlChildren)){
					xmlMerge(writeNode,readNode,overwriteNodes,writeNodeDoc);
				}
			}
			//add this node name to those nodes we have done -- we need to do this because an XMLDoc object can have duplicate keys
			nodesDone[nodeName] = true;
		}
	}
}
</cfscript>
</cfcomponent>

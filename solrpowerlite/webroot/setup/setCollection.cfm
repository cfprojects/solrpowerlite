<!---
/**
 * @copyright 2012 Robert Munn <cfmunster@gmail.com>
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
 * @author 	Robert Munn <cfmunster@gmail.com>
 * @date 	5-14-2012
 */
  --->

<cfimport taglib='/tags' prefix='t'/>
<t:checkAdmin/>

<cfparam name='form.createCollection' default='0' />
<cfparam name='form.collectionName' default='' />
<cfparam name='form.collectionPath' default='' />

<cfif len(form.collectionName)>
	<cfquery name='setCollection' datasource='#request.dsn#'>
		UPDATE config 
		set 	collectionname = <cfqueryparam cfsqltype='cf_sql_varchar' value='#form.collectionName#' />
	</cfquery>
	<cfif form.createCollection>
		<cfcollection action='list' name='c' engine='solr' />
		<cfif listfindnocase(valuelist(c.name),form.collectionName)>
			<cfcollection action='delete' collection='#form.collectionName#' />
		</cfif>
		
		<cfcollection action='create' collection='#form.collectionName#' engine='solr' path='#form.collectionPath#'/>
		
		<cfset schemaPath = getSchemaPath(form.collectionName,form.collectionPath)/>
		<!--- wait for the server to create the collection --->
		<cfset wait = true />
		<cfset iter = 1>
		<cfloop condition="wait eq true" >
			<cfset sleep(500)/>
			<cfif fileExists(schemaPath)>
				<cfset wait = false />
				<cfbreak/>
			</cfif>
			<cfif iter eq 30>
				<cfoutput>#schemaPath# exists? #fileExists(schemaPath)#</cfoutput>
				
				<cfabort>
			</cfif>
			<cfset iter++/>
		</cfloop>
		
		<cflock name='application' type='readonly' timeout='10' >
			<cfset application.collection = form.collectionName />
		</cflock>		
		
		<cfset checkSolrConfig(schemaPath)/>

	<cfelse>
		<t:checkCollection collectionName='#form.collectionName#'/>
		<cflock name='application' type='readonly' timeout='10' >
			<cfset application.collection = form.collectionName />
		</cflock>		
		
		<cfif collectionExists and len(collectionPath)>
			
			<cfset schemaPath = getSchemaPath(form.collectionName,collectionPath)/>
			<cfset checkSolrConfig(schemaPath)/>
		<cfelse>
			<!--- the user did not ask for the collection to be created, but the collection specified does not exist --->
			<!---<cflocation url='/setup.cfm?step=1'  addtoken='true'/>--->
				<t:htmlwrapper>
		
				<h3>Solr Collection does not exist</h3>
				<div class='expText'>
					<p>The collection you specified does not exist.</p>
					
					<p><a href='/setup.cfm?step=1'>Go back and check the box to create the collection, or provide a different collection name.</a></p>
				</div>			
				</t:htmlwrapper>
		</cfif>		
		
	</cfif>
	
<cfelse>
	<cflocation url='/setup.cfm?step=1'  addtoken='true'/>
</cfif>

<cffunction name='getSchemaPath' access='private' returntype='string'>
	<cfargument name='collectionName' type='string' required='true'/>
	<cfargument name='collectionPath' type='string' required='true'/>
		<cfif findnocase('\',arguments.collectionPath)>
			<cfset sep = '\'/>
		<cfelse>
			<cfset sep = '/'/>
		</cfif>
		<cfset cp = arguments.collectionPath />
		<cfif right(arguments.collectionPath,1) neq sep>
			<cfset cp = arguments.collectionPath & sep />
		</cfif>		
		<cfreturn '#cp##arguments.collectionName##sep#conf#sep#schema.xml'/>		
</cffunction>

<cffunction name='checkSolrConfig' access='private' returntype='void' output='true'>
	<cfargument name='schemaPath' type='string' required='true'/>
	
	<!--- read the schema and update the key field to indexed='true' so we can delete entries --->
	<cffile action="read" file="#schemaPath#" variable="s"/>
	<cfset schema = xmlparse(s)/>
	<cfset key = xmlSearch(schema,"/schema/fields/field[@name='key']")/>
	<cfif key[1].XmlAttributes.indexed eq false>
		<cfset key[1].XmlAttributes.indexed = true/>

		<cffile action='write' file='#schemaPath#' output='#toString(schema)#' />
		<t:htmlwrapper>
		<cfif fileExists("C:\WINDOWS\system32\cmd.exe")>
				<h3>Solr collection updated</h3>
				<div class='expText'>
			<cfoutput>
				<p>The ColdFusion Solr Service is being restarted, please wait...</p>
			</cfoutput>
				<!---</div>--->
			<cfflush/>
			<cfexecute name="C:\WINDOWS\system32\cmd.exe" arguments="/c ""#expandPath('../../solrrestart.bat')#""" variable="result" timeout="30">
			</cfexecute>
			<cfoutput>
				<!---<div>--->
				<script>
					setTimeout("location.href='/setup.cfm?step=2';",5000);
				</script>
				
				<p>Finished. The page will refresh in five seconds.</p> 
				
				<p><a href='/setup.cfm?step=2'>Click here to proceed immediately.</a></p>
				</div>
			</cfoutput>	
		<cfelse>
			<div class='expText'>
			<cfoutput>Please restart the ColdFusion Solr Service. <a href='/setup.cfm?step=2'>Click here to proceed</a> after the service restarts.</cfoutput>
			</div>
		</cfif>	
	<cfelseif key[1].XmlAttributes.indexed eq true>
		<cflocation url='/setup.cfm?step=2'  addtoken='true'/>
	<cfelse>
		<cflocation url='/setup.cfm?step=1'  addtoken='true'/>
	</cfif>
</cffunction>

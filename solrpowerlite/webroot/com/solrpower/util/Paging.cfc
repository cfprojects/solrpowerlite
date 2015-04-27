<cfcomponent displayname="Paging">
<!---/**
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
 */--->
	<cffunction name="init" access="public" returntype="com.solrpower.util.Paging">
	
		<cfreturn this />
	</cffunction>

	<cffunction name="getNav" access="public" returntype="array" output="false" hint="I return a structure of urls to page through a recordset">
		<cfargument name="baseURL" type="string" required="true"/>
		<cfargument name="startrow" type="numeric" required="true"/>
		<cfargument name="totalRecords" type="numeric" required="true"/>
		<cfargument name="rowCount" type="numeric" required="true"/>
		<cfargument name="navSize" type="numeric" required="false" default="9">
		
		<cfset var pageArray = arrayNew(1)/>
		<cfset var idx = ""/>
		<cfset var firstPage = 1/>
		<cfset var lastPage = ceiling(totalRecords/rowCount)>
		<cfset var pageMin = 1/>
		<cfset var pageMax = duplicate(lastPage) />
		<cfset var i = 1 />
		<cfset var start = "" />
		<cfset var end = ""/>
		<cfset var pageNum = ceiling(startRow / rowCount)>
		<!---  set the minimum page to show to 4 less than the current page --->
		<cfif pageNum - (arguments.navSize/2 - 1) gt 1>
			<cfset pageMin = pageNum - ceiling(arguments.navSize/2 - 1)/>
		</cfif>
		
		<!---  set the max page to show to 4 greater than the current page --->
		<cfif pageNum + (arguments.navSize/2 - 1) lt pageMax>
			<cfset pageMax = pageNum + ceiling(arguments.navSize/2 - 1)/>
		</cfif>
		<!---  don't show first/last navigation if not needed --->
		<cfif lastPage gt arguments.navSize>
			<cfset pageArray[i] = structNew()/>
			<cfset pageArray[i].navURL = baseURL & "&startRow=1&rowCount=" & rowCount />
			<cfset pageArray[i].label = "<<" />
			<cfset pageArray[i].isCurrentPage = false/>	
		<cfelse>
			<!--- set the first element of the array  --->
			<cfset pageArray[i] = structNew()/>
			<cfset pageArray[i].navURL = "" />
			<cfset pageArray[i].label = "" />
			<cfset pageArray[i].isCurrentPage = false/>				
		</cfif>
		<!--- increment the array index --->
		<cfset i = i + 1 />
		
		<!---  create the array of urls --->
		<cfloop from="#pageMin#" to="#pageMax#" index="idx">
			<cfset start = rowCount * idx - rowCount + 1/>
			<cfset end = start + rowCount - 1 />
			<cfset pageArray[i] = structNew()/>
			<cfset pageArray[i].navURL = baseURL & "&startRow=" & start & "&rowCount=" & rowCount/>
			<cfset pageArray[i].label = idx />	
			<cfif pageNum eq idx>
				<cfset pageArray[i].isCurrentPage = true/>				
			<cfelse>
				<cfset pageArray[i].isCurrentPage = false/>	
			</cfif>
			<cfset i = i + 1 />
		</cfloop>
		<!--- set the last page --->
		<cfif lastPage gt arguments.navSize>
			<cfset start = evaluate(totalRecords-rowCount+1)/>
			<cfset pageArray[i] = structNew()/>
			<cfset pageArray[i].navURL = baseURL & "&startRow=" & start & "&rowCount=" & rowCount />
			<cfset pageArray[i].label = ">>" />		
			<cfset pageArray[i].isCurrentPage = false/>	
		<cfelse>
			<!--- show an empty entry as the last page --->		
			<cfset pageArray[i] = structNew()/>
			<cfset pageArray[i].navURL = "" />
			<cfset pageArray[i].label = "" />
			<cfset pageArray[i].isCurrentPage = false/>					 
		</cfif>
		
		<cfreturn pageArray />
	</cffunction>

	<cffunction name="render" access="public" returntype="void" output="true">
		<cfargument name="pageArray" type="array" required="true"/>
		
		<!---<cfif arraylen(arguments.pageArray) gt 3>--->
			<cfoutput>
            	<cfloop from="1" to="#arraylen(arguments.pageArray)#" index="i">
					<cfset local.p = arguments.pageArray[i]/>
					
					<cfif len(local.p.navURL)>
						<cfif local.p.isCurrentPage><strong>[#local.p.label#]</strong><cfelse><a href="#AjaxLink(local.p.navURL)#">[#local.p.label#]</a></cfif>  
						<cfif i lt arrayLen(arguments.pageArray)><cfset local.nextP = arguments.pageArray[i + 1] /><cfif len(local.nextP.navURL)> - </cfif></cfif>
					</cfif>
				</cfloop>
            </cfoutput>
		<!---</cfif>--->
	</cffunction>
</cfcomponent>
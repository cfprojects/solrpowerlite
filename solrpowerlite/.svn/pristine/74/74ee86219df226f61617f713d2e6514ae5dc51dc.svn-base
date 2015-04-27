<cfcomponent>
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
	<cfset this.name = "solrpowerLite" />
	<cfset this.applicationtimeout = CreateTimeSpan(0,10,0,0)/>
	<cfset this.sessionmanagement = true />
	<cfset this.setclientcookies = true />
	
	<cffunction name="onApplicationStart" access="public" output="true" returntype="boolean">
		<cfset request.dsn = 'solrpowerlite'/>
	
		<!--- verify the system is configured --->
		<cftry>
		<cfinclude template='/setup/getAdmin.cfm'/>
		<cfcatch type='any'>
			<!--- DSN must not be defined, let's define it. --->

				<cfif cgi.CF_TEMPLATE_PATH contains "createDSN.cfm">
				<cfinclude template='/setup/createDSN.cfm'/>	
			<cfelse>
				<cfinclude template='/setup/dsnSetup.cfm'/>	
			</cfif>
			<cfreturn true />
		</cfcatch>	
		</cftry>

		<cfinclude template='/setup/getConfig.cfm'/>
		<cfset application.collection = getConfig.collectionName />
		<cfreturn true/>
	</cffunction>

	<cffunction name='onRequestStart' access='public' returntype='boolean'>
		
		<cfif not isNull(url.init) and url.init eq 1>
			<cfset onApplicationStart()/>
		</cfif>
		<cfset request.dsn = 'solrpowerlite'/>
		<cflock type='readonly' name='application' timeout='10'>
			<cfset request.collection = application.collection />
		</cflock>
		<cfreturn true/>
	</cffunction>
</cfcomponent>
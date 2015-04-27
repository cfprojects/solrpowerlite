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
<cfinclude template='getAdmin.cfm' />

<cfif getAdmin.password eq form.password>
	<!--- validated login --->
	<cflock name='session' type='exclusive' timeout='10'>
		<cfset session.admin = true />
	</cflock>
	
	<cfif not isNull(form.referer)>
		<cflocation url = form.referer />
	<cfelseif not isNull(cgi.http_referer)>
		<cflocation url = '#cgi.http_referer#' />
	<cfelse>
		<cflocation url='index.cfm'/>
	</cfif>
<cfelse>
	<cfset msg = 'Login failed. Please try again.'/>
	<cfif NOT isNull(form.referer)>
		<cfset referer = form.referer />
	<cfelseif NOT isNull(cgi.http_referer)>
		<cfset referer = cgi.http_referer />
	</cfif> 
	<cflocation url='login.cfm?referer=#urlencodedformat(referer)#&msg=#urlencodedformat(msg)#'/>
</cfif>
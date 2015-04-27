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

<cfparam name="form.username" default="admin">
<cfparam name="form.password" default="">
<cfset loginSuccessful = CreateObject("component","cfide.adminapi.administrator").login(form.password, form.username)>
<cfif loginSuccessful>
    <cfset datasource = CreateObject("component", "cfide.adminapi.datasource")>
    <cfset datasource.setDerbyEmbedded(
				name=request.dsn,
				database=expandpath("../../db/solrpower/"),
				isnewdb=true)/>
	<cfinclude template='/setup/setupdb.cfm' />
    <cflocation url='/setup.cfm'/>
<cfelse>

<t:htmlwrapper>
<div>
	<h3>Invalid Username or Password.</h3> 

</div>	
</t:htmlwrapper>
	
</cfif>
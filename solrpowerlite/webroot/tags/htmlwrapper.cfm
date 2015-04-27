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

<cfif thisTag.executionmode eq 'start'>
<cfoutput>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
	<html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			<title>SolrPower Lite</title>
			<link rel="stylesheet" type="text/css" href="/css/style.css" media="screen"/>
		</head>
		<body>
			<cfinclude template='/layout/header.cfm' />
		   <div id='dvMain'>
					
</cfoutput>
<cfelseif thisTag.executionmode eq 'end'>
<cfoutput>
		<cflock name='session' type='readonly' timeout='10'>
			<cfif NOT isNull(session.admin)>
				<div id='dvUserCheck'>Logged in as admin. <a href='/logout.cfm'>[logout]</a></div>
			</cfif>
		</cflock>
		</div>
		<cfinclude template='/layout/footer.cfm' />
		</body>
	</html>
</cfoutput>
</cfif>
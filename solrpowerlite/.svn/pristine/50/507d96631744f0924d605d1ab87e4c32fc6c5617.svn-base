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

<!--- plug in an html wrapper --->
<t:htmlwrapper>
	<div>
		<h3>Create SolrPower Lite Datasource</h3> 
		<div class='expText'>
			<p>SolrPower Lite needs the CF Admin login credentials in order to create the link to the embedded database.</p>
			<p>If you prefer to create the datasource yourself, add an Apache Derby Embedded datasource pointing to the /db/solrpower folder in the application root. Do not check the box to create the database.</p>
		</div>
		<br/>		
		<form action='/setup/createDSN.cfm' method='post'>
		<table>
			<tr>
				<td>				
					<input class='input' type='text' name='username' value='admin'/>
				</td>
				<td>
					CF Admin user (will not be saved)
				</td>
			</tr>
			<tr>
				<td>						
					<input class='input' type='password' name='password'/>
				</td>
				<td> CF Admin password (will not be saved)
				</td>
			</tr>
			<tr>
				<td align='center' colspan='2'>						
				
				<input class='button' type='submit' value='Create DSN'/>
					
				</td>
			</tr>
		</table>
		</form>
	</div>
</t:htmlwrapper>
<cfabort>
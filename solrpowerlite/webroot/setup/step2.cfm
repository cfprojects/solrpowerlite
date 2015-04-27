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

<cfinclude template='getConfig.cfm'/>
<cfimport taglib='/tags' prefix='t'/>
<t:checkAdmin/>

<!--- plug in an html wrapper --->
<t:htmlwrapper>
	<div>
		<h3>Set the folder to watch</h3> 
		<div class='expText'>
			<p>SolrPower Lite provides a full-text search of a folder on the server where it runs. When you set the initial <i>folder path</i>, the system
			will index the documents in the folder with the Apache Solr search engine. This process may take a few minutes for a small number of documents, or longer for a large number of long documents. 
			If you would like the system to index and search sub-folders of the folder you choose, check the <i>recurse sub-folders setting.</i> 
			</p>
			<p>
				The <i>folder alias</i> is a setting used to make documents located outside the web root of SolrPower Lite accessible to the users of the system. If your documents are located outside the web root,
				you must set the folder alias here, and you must add the folder alias to the web site definition for Solrpower Lite in the web server, such as IIS or Apache httpd. If your documents are located inside the web root, the alias will be set for you.
			</p>
			<p>
				  Once the initial documents in the folder are indexed, SolrPower Lite watches the folder for changes and indexes new, changed, and deleted documents in near-real time. Enter the CF Admin login credentials for the server so the system can set the 
				  folder watcher program.
			</p>
		</div>
		<br/>		
		<form action='/setup/setWatchFolder.cfm' method='post'>
		<table>
			<tr>
				<td>
					<!---<input class='input' type='checkbox' name='watchFolder' value='Y'<cfif getConfig.watchfolders eq 'Y'> checked</cfif>/> Watch a Folder?<br/>--->
					<cfoutput><input class='input' type='text' name='folderName' value='#getConfig.folderName#'/>
				</td>
				<td>
					folder path
				</td>
			</tr>
			<tr>
				<td align='right'><input class='input' type='checkbox' name='recurse' value='1'<cfif val(getConfig.recurse)> checked</cfif>/> 
				</td>
				<td>recurse sub-folders
				</td>
			</tr>
			<tr>
				<td>					
					<input class='input' type='text' name='folderalias' value='#getConfig.folderalias#'/>
					<!---<input class='input' type='checkbox' name='adminapi' value='1'/> Add event watcher (requires CF Admin login)<br/>--->
				</td>
				<td valign='top'>
					folder alias
					
				</td>
			</tr>
			<tr>
				<td colspan='2'><br/></td>
			</tr>
			<tr>
				<td colspan='2'>
				Add folder watcher 
				</td>
			</tr>
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
				</cfoutput>
				<input type='button' class='button' value='Back' onclick="location.href='setup.cfm?step=1'"/> <input class='button' type='submit' value='Set Watch Folder'/>
					
				</td>
			</tr>
		</table>
		</form>
	</div>
</t:htmlwrapper>
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

<!--- check the collection --->
<cfparam name='collectionExists' default='0' />
<t:checkCollection collectionName='#getConfig.collectionName#'>

<!--- plug in an html wrapper --->
<t:htmlwrapper>
	<script language='javascript'>
		function setCP(checked){
			if(checked == true){
				document.collectionForm.collectionPath.disabled = false;
			}
			else{
				document.collectionForm.collectionPath.value = '';
				document.collectionForm.collectionPath.disabled = true;
			}
		}
		
		function validateCollection(){

			if(document.collectionForm.createCollection.checked == true && document.collectionForm.collectionPath.value == ''){
				alert('You must provide a valid path for the collection.');
			}
			else if(document.collectionForm.collectionName.value == ''){
				alert('You must provide a valid collection name.');
			}
			else{
				document.collectionForm.submit();
			}
		}
	</script>
	
	<div>
		<h3>Set the collection name</h3>
		<div class='expText'>
			<p>SolrPower Lite uses Apache Solr to index the full text of documents. Please specify the name of the <i>collection</i> that SolrPower Lite will use. The default name is solrpowerlite.</p>
			<p>The <i>path</i> setting intructs Solr where to create the collection. In a typical CF9 install, the default path is <i>&lt;coldfusion_root&gt;\solr\multicore</i>, where &lt;coldfusion_root&gt; might be 'c:\ColdFusion9' on Windows, and '/opt/coldfusion9' on Linux. 
			Make sure that the disk drive where the collection will live has free space to build its index.</p>
			
			<p>Check the <i>create collection</i> box for the setup system to create the collection for you. Note that if you ask the system to create a collection that already exists, the setup program will first delete the existing collection. 
			On Windows systems, the setup will try to restart the ColdFusion Solr Service for you. On Mac/*nix systems, you will need to restart the service yourself. Restarting the service is necessary to pick up changes in the collection configuration required by SolrPower Lite.
			</p> 			
		</div>
		<br/>
		<form name='collectionForm' action='/setup/setCollection.cfm' method='post'>
		<table>
			<tr>
				<td>
						<cfoutput><input class='input' name='collectionName' value='#getConfig.collectionName#' type='text'/></cfoutput>
				</td>
				<td>collection name</td>
			</tr>
			<tr>
				<td align='right'>
				<input class='input' type='checkbox' name='createCollection' value='1' onclick='setCP(this.checked)' <cfif NOT collectionExists> checked</cfif>/>
				</td>
				<td> create collection?</td>
			</tr>			
			<tr>
				<td>		
					<input class='input' type='text' name='collectionPath' value=''<cfif collectionExists> disabled='true'</cfif>/>
				</td>
				<td>path</td>
			</tr>

			<tr>
				<td align='center' colspan='2'><input class='button' type='button' value='Proceed' onclick='validateCollection()'/>
				</td>
				
			</tr>
		</table>
		</form>
	</div>
	
</t:htmlwrapper>
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

<cfinclude template='getConfig.cfm'/>
<cfparam name='form.folderName' default='' />
<cfparam name='form.recurse' default='0' />
<cfparam name='form.folderalias' default='' />
<cfparam name='form.watchfolder' default='Y' />
<cfset basePath = expandPath('../')/>

<cfif basePath contains "\">
	<cfset s = '\'/>
<cfelseif basePath contains "/">
	<cfset s = '/' />
</cfif>	
<cfif right(form.folderName,1) neq s>
	<cfset folder = form.folderName & s />
<cfelse>
	<cfset folder = form.folderName />	
</cfif>

<cfif len(form.username) and len(form.password)>	
	<cfscript>
		adminObj = createObject("component","cfide.adminapi.administrator");    	    
   		// Login is always required. 
		adminObj.login("#form.password#","#form.username#");
		//admin api, set the watcher 		
		//if (form.watchFolder eq 'Y'){
			evg = createObject("component","cfide.adminapi.eventgateway");	
			path = replace(expandPath('../'),'\','/','all');
			// create the config file for the directory watcher
			configPath = path & 'com' & '/solrpower'& '/util' & '/DirectoryWatcher_config.txt';
			config = fileOpen(configPath,'write');
			filewriteline(config,'directory=' & replace(form.foldername,'\','/','all'));
			filewriteline(config,'recurse=' & yesno(form.recurse));
			filewriteline(config,'interval=10000');
			fileclose(config);
			//create the gateway instance and start it
			cfcs = arraynew(1);
			cfcs[1] = path & 'com' & '/solrpower'& '/util' & '/DirectoryWatcher.cfc';
			try{
				//evg = evg.getGatewayInstances('solrPowerLite_DirectoryWatcher');
				evg.deleteGatewayInstance('solrPowerLite_DirectoryWatcher');
			}
			catch(Any e){
				
			}
			evg.setGatewayInstance('solrPowerLite_DirectoryWatcher','DirectoryWatcher',cfcs,configPath,'auto'); 
			evg.startGatewayInstance('solrPowerLite_DirectoryWatcher');
		//}
    </cfscript>

</cfif>

<cfif len(form.folderalias)>
	<cfset alias = form.folderalias/>	
<cfelse>

	<cfset mypathlen = listlen(form.folderName,s)/>
	<cfset basePathlen = listlen(basePath,s)/>
	<cfset alias = ''/>
	<cfif mypathlen gt basePathlen>
		<cfloop from='#basePathLen + 1#' to='#mypathlen#' index='i'>
			<cfset alias = listappend(alias,listgetat(form.folderName,i,s),'/')/>
		</cfloop>
	</cfif>
	
</cfif>

<cfif left(alias,1) neq '/'>
	<cfset alias = '/' & alias />
</cfif>	

<!--- update the database --->
<cfquery name='updConfig' datasource='#request.dsn#'>
	UPDATE 	config
	SET		watchfolders = <cfqueryparam cfsqltype='cf_sql_char' value='#form.watchFolder#' />,
			foldername = <cfqueryparam cfsqltype='cf_sql_varchar' value='#folder#' null='#isNo(form.watchFolder)#' />,
			folderalias = <cfqueryparam cfsqltype='cf_sql_varchar' value='#alias#' />
</cfquery>

<cfscript>
	cfcs = arraynew(1);
	cfcs[1] = path & 'com' & '/solrpower'& '/solr' & '/DirectoryIndexer.cfc';
	
	//	deleteGatewayInstance('solrPowerLite_DirectoryIndexer');
	
	//try{
		evg.setGatewayInstance(gatewayid='solrPowerLite_DirectoryIndexer',type='CFML',cfcpaths=cfcs,mode='auto', configurationpath=''); 
		evg.startGatewayInstance('solrPowerLite_DirectoryIndexer');
		sleep(1000);
	/*}
	catch(Any e){
		// already exists
	}	*/
</cfscript>

<cfset props = structnew()/>
<cfset props.folder = form.folderName />
<cfset props.recurse = form.recurse />
<cfset props.folderalias = replace(alias,"/","","all") />
<cfset props.collection = getConfig.collectionName />



<cfset SendGatewayMessage('solrPowerLite_DirectoryIndexer',props)/>
		<!---<cfindex action='refresh' collection='#props.collection#' key='#props.folder#' extensions='pdf' type='path' recurse='#props.recurse#' urlpath='#alias#'/>
--->

<cfinclude template='/setup/finished.cfm' />

<!---
<cflocation url='/index.cfm' />--->


<!--- utility functions --->

<cfscript>
	function isNo(str){
		if(str eq 'Y') return false;
		if(str eq 'N') return true;
	}
	
	function yesno(str){
		if(str eq 'Y') 
			return 'yes';
		else
			return 'no';	
	}
</cfscript>
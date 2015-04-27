<cfcomponent>
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
 */ --->	
    <cffunction name='onIncomingMessage' output='no'>
        <cfargument name='CFEvent' type='struct' required='yes'/>
		<cflog file='solrPowerLite_DirectoryIndexer' text='Collection: #cfevent.data.collection#, Folder: #cfevent.data.folder#, Recurse: #cfevent.data.recurse#, Alias: /#cfevent.data.folderalias#' />
		<cfindex action='purge' collection='#cfevent.data.collection#' />
		<cfindex action='refresh' collection='#cfevent.data.collection#' key='#cfevent.data.folder#' extensions='pdf,htm,html,doc,docx,odt,txt,ppt,xls,ods,odp,pptx,xltx,xml' type='path' recurse='#cfevent.data.recurse#' urlpath='/#cfevent.data.folderalias#'/>
    </cffunction>
</cfcomponent>
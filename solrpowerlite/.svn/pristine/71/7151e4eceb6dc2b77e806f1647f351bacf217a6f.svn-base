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

<cfcollection name='c' action='list' engine='solr' />
<cfparam name='attributes.collectionName' default='solrpowerlite' />

<cfset caller.collectionExists = listFindNoCase(valuelist(c.name),attributes.collectionName) />

<cfquery name="qoq" dbtype="query"> 
    SELECT 	path 
	FROM	c  
    WHERE 	c.name = '#attributes.collectionName#' 
</cfquery>  

<cfif qoq.recordCount>
	<cfset sep = '\'/>
	<cfif findnocase('/',qoq.path)>
		<cfset sep = '/'/>
	</cfif>
	<cfset caller.collectionPath = replace(qoq.path,'#sep##attributes.collectionName##sep#data#sep#index','')/>
</cfif>

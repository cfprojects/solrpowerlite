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
<cfparam name='startrow' default='1'/>
<cfsearch collection='#request.collection#' name='docs' criteria='#s#'/>
<cfset ROWCOUNT = 10 />
<cfset NAVSIZE = 7 />
<cfset paging = createObject("component","com.solrpower.util.Paging").init() />
<cfset pageArray = paging.getNav("search.cfm?s=#urlencodedformat(s)#",startrow,docs.recordcount,ROWCOUNT,NAVSIZE) />
<cfif startrow + ROWCOUNT - 1 gt docs.recordcount>
	<cfset endrow = docs.recordcount />
<cfelse>
	<cfset endrow = startrow + ROWCOUNT - 1/> 
</cfif>

<div id='dvResults'>
<br/>
<br/>

<div>
	<cfoutput>Found #docs.recordcount# records for <a href="#AjaxLink('search.cfm?s=#urlencodedformat(s)#')#">#s#</a></cfoutput>
<!---<cfoutput> Showing [#startrow#-#endrow#]</cfoutput>--->
</div>
<br/>
<cfoutput query='docs' startrow='#startrow#' maxrows='#ROWCOUNT#'>
<div><b><a href='#url#'>#title#</a></b></div>
<div class='highlight'>#cgi.HTTP_HOST##url#</div>
<div class='smaller'>#summary#</div>
<br/>
</cfoutput>


<cfoutput>
	<div align='center'>#paging.render(pageArray)#</div>
</cfoutput>

</div>
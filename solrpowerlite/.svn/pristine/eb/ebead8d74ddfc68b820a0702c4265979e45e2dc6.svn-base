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
<t:htmlwrapper>
		
		<script language="JavaScript">
			var previousValue = "";
			var timeout;
		    document.body.onkeyup = function (event) {
		       event = event || window.event;
			   if(document.searchForm.searchTerms.value != previousValue){
			      // if (document.searchForm.searchTerms.value.length > 1) {
				   		previousValue = document.searchForm.searchTerms.value;
			           	if(timeout) { clearTimeout(timeout); }
						timeout = setTimeout(function(){
							ColdFusion.navigate('search.cfm?s=' + document.searchForm.searchTerms.value, 'resultsWrapper');
						},200);
			       //	}
				}
		    }
		</script>


		<div>
		
		<cfform name='searchForm'>
			<input class='input' type='text' name='searchTerms' size=50 maxlength='255' tabindex="2"/>
			<cfinput class='button' tabindex="1" value="Search" name="submitSearch" type="button" onclick="ColdFusion.navigate('search.cfm?s=' + document.searchForm.searchTerms.value,'resultsWrapper');"/>
			
		</cfform>
		
		</div>
		<cfdiv id='resultsWrapper'>
		
		</cfdiv>
		<br/><br/>

</t:htmlwrapper>
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

<!--- plug in an html wrapper --->
<t:htmlwrapper>
	<div>
		<h3>Setup Finished</h3> 
		<div class='expText'>
			<p>The system setup is complete. Any documents currently in the watch folder  
			will be available in the search once the indexing process is complete.
			</p>
			<p>
				<a href='/index.cfm'>Click here to go to the search.</a>
			</p>	
		</div>
	</div>
</t:htmlwrapper>
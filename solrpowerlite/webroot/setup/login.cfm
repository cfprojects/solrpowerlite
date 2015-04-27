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

<cfinclude template='getAdmin.cfm' />
<cfimport taglib='/tags' prefix='t'/>

<!--- plug in an html wrapper --->
<t:htmlwrapper>
	
	<div>
	
	<!--- new user or logged in admin can change password --->
	<cfif not isNull(form.pwd) and not isNull(form.pwd_confirm) and (not len(getAdmin.password) or NOT isNull(session.admin))>
		<cfif form.pwd eq form.pwd_confirm>
			<cfquery name='setPwd' datasource='#request.dsn#'>
				UPDATE users
				SET		password = <cfqueryparam cfsqltype='cf_sql_varchar' value='#form.pwd#'/>
				WHERE	username = 'admin'
			</cfquery>
			<cflock name='session' type='exclusive' timeout='10'>
				<cfset session.admin = true/>
			</cflock>
			<cflocation url='/setup.cfm' addtoken='true' />
		</cfif>
		
	<cfelseif not len(getAdmin.password) or (not isNull(url.changePwd) and url.changePwd eq 'true' and not isNull(session.admin))>
	<script>
		function validate(){
			if(document.setPwd.pwd.value.length > 5 && document.setPwd.pwd.value.length < 13){
				//nothing to do
			} else{
				alert('Password must be 6-12 characters in length.');
			}
			if(document.setPwd.pwd.value == document.setPwd.pwd_confirm.value){
				document.setPwd.submit();
			}
			else{
				alert('Passwords do not match.');
			}
		}
	</script>
		<h3>Admin Login</h3>
		<div class='expText'>
		Access to the configuration for Solrpower Lite is protected. Please set the administrative password for the application. The password must be 6-12 characters in length.
		</div>
		<form action='setup/login.cfm' method='post' name='setPwd'>
				
		<table>

			<tr>
				<td>
					<cfif NOT isNull(url.referer)>
					<input type='hidden' name='referer' value='#url.referer#'/>
					</cfif>
					<input class='input' type='password' name='pwd' maxlength='12'/>
				</td><td> Password</td>
				</tr>
				<tr>
					<td>
					<input class='input' type='password' name='pwd_confirm' maxlength='12'/></td>
					<td> Password (confirm)</td>
				</tr>
				<tr>
					<td colspan='2' align='center'>
						
					<input class='button' type='button' value='Set Password' onclick='validate()'/>	
				
				</td>
			</tr>
		</table>
			</form>
		
	<cfelseif isNull(session.admin)>
			<h3>Admin Login</h3>
			<cfif NOT isNull(url.msg)>
				<cfoutput>#url.msg#</cfoutput><br/><br/>
			</cfif>
			<div class='expText'>
				Access to the configuration for Solrpower Lite is protected. Please enter the administrative password for the application in order to proceed.
			</div>
			<br/>
			<form action='/setup/doLogin.cfm' method='post'>
			<table>
				<tr>
					<td>password: </td>
					<td><input class='input' name='password' type='password'/></td>
				</tr>
				<tr>
					<td colspan='2' align='right'><input type='submit' class='button' value='Login'/></td>
				</tr>
			</table>
		
			</form>
	</cfif>

	</div>
	
</t:htmlwrapper>

<!--- You shall not pass! --->
<cfabort>
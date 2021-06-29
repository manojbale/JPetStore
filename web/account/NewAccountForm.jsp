<%--

    @   Copyright 2010-2017 the original author or authors.

       Licensed under the Apache License, Version 2.0 (the "License");
       you may not use this file except in compliance with the License.
       You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.

--%>
<%@ include file="../common/IncludeTop.jsp" %>

<div id="Catalog">

  <html:form action="/shop/newAccount.shtml" method="post">

    <html:hidden name="accountBean" property="validation" value="new"/>

    <h3>User Information</h3>

    <table>
      <tr>
        <td>User ID:</td><td><html:text name="accountBean" property="username"/></td>
      </tr><tr>
      <td>New password:</td><td><html:password name="accountBean" property="password"/></td>
    </tr><tr>
      <td>Repeat password:</td><td><html:password name="accountBean" property="repeatedPassword"/></td>
    </tr>
    </table>

    <%@ include file="IncludeAccountFields.jsp" %>

    <input type="submit" name="submit" value="Create Account"/>

  </html:form>

</div>

<%@ include file="../common/IncludeBottom.jsp" %>

<%--

       Copyright 2010-2017 the original author or authors.

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
<%@ page import="java.io.PrintWriter" %>
<%@ include file="../common/IncludeTop.jsp" %>

<logic:notPresent name="BeanActionException">
  <logic:notPresent name="message">
    <h3>Something happened...</h3>
    <b>But no further information was provided.</b>
  </logic:notPresent>
</logic:notPresent>
<p/>
<logic:present name="BeanActionException">
  <h3>Error!</h3>
  <b><bean:write name="BeanActionException" property="class.name"/></b>

  <p/>
  <bean:write name="BeanActionException" property="message"/>
</logic:present>
<p/>
<logic:present name="BeanActionException">
  <h4>Stack</h4>
  <pre>
    <%
      Exception e = (Exception) request.getAttribute("BeanActionException");
      e.printStackTrace(new PrintWriter(out));
    %>
  </pre>
</logic:present>

<%@ include file="../common/IncludeBottom.jsp" %>
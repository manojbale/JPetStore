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
<%@ include file="../common/IncludeTop.jsp" %>

<bean:define id="category" name="catalogBean" property="category"/>
<bean:define id="productList" name="catalogBean" property="productList"/>

<div id="BackLink">

  <html:link page="/shop/index.shtml">Return to Main Menu</html:link>

</div>

<div id="Catalog">

  <h2><bean:write name="category" property="name"/></h2>

  <table>
    <tr><th>Product ID</th>  <th>Name</th></tr>
    <logic:iterate id="product" name="productList">
      <tr>
        <td><html:link paramId="productId" paramName="product" paramProperty="productId" page="/shop/viewProduct.shtml">
          <bean:write name="product" property="productId"/></html:link></td>
        <td><bean:write name="product" property="name"/></td>
      </tr>
    </logic:iterate>
    <tr><td colspan="2">
      <logic:notEqual name="productList" property="firstPage" value="true">
        <a class="Button" href="switchProductListPage.shtml?pageDirection=previous">&lt;&lt; Prev</a>
      </logic:notEqual>
      <logic:notEqual name="productList" property="lastPage" value="true">
        <a class="Button" href="switchProductListPage.shtml?pageDirection=next">Next &gt;&gt;</a>
      </logic:notEqual>
    </td></tr>
  </table>

</div>

<%@ include file="../common/IncludeBottom.jsp" %>



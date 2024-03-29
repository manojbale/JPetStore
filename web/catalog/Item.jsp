<%--
@
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

<bean:define id="product" name="catalogBean" property="product"/>
<bean:define id="item" name="catalogBean" property="item"/>

<div id="BackLink">

  <html:link paramId="productId" paramName="product" paramProperty="productId" page="/shop/viewProduct.shtml">
    Return to <bean:write name="product" property="name"/></html:link>

</div>

<div id="Catalog">

  <table>
    <tr>
      <td>
        <bean:write filter="false" name="product" property="description"/>
      </td>
    </tr>
    <tr>
      <td>
        <b><bean:write name="item" property="itemId"/></b>
      </td>
    </tr><tr>
    <td>
      <b><font size="4">
        <bean:write name="item" property="attribute1"/>
        <bean:write name="item" property="attribute2"/>
        <bean:write name="item" property="attribute3"/>
        <bean:write name="item" property="attribute4"/>
        <bean:write name="item" property="attribute5"/>
        <bean:write name="item" property="product.name"/>
      </font></b>
    </td></tr>
    <tr><td>
      <bean:write name="product" property="name"/>
    </td></tr>
    <tr><td>
      <logic:lessEqual name="item" property="quantity" value="0">
        Back ordered.
      </logic:lessEqual>
      <logic:greaterEqual name="item" property="quantity" value="1">
        <bean:write name="item" property="quantity"/> in stock.
      </logic:greaterEqual>
    </td></tr>
    <tr><td>
      <bean:write name="item" property="listPrice" format="$#,##0.00"/>
    </td></tr>

    <tr><td>
      <html:link styleClass="Button" paramId="workingItemId" paramName="item" paramProperty="itemId" page="/shop/addItemToCart.shtml">
        Add to Cart</html:link>
    </td></tr>
  </table>

</div>

<%@ include file="../common/IncludeBottom.jsp" %>




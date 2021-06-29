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

<h2>My Orders</h2>

<table>
  <tr><th>Order ID</th>  <th>Date</th>  <th>Total Price</th></tr>

  <logic:iterate id="order" name="orderBean" property="orderList">
    <tr>
      <td><html:link paramId="orderId" paramName="order" paramProperty="orderId" page="/shop/viewOrder.shtml">
        <bean:write name="order" property="orderId"/></html:link></td>
      <td><bean:write name="order" property="orderDate" format="yyyy/MM/dd hh:mm:ss"/></td>
      <td><bean:write name="order" property="totalPrice" format="$#,##0.00"/></td>
    </tr>
  </logic:iterate>
</table>

<logic:notEqual name="orderBean" property="orderList.firstPage" value="true">
  <a href="switchOrderPage.shtml?pageDirection=previous">&lt;&lt; Previous</a>
</logic:notEqual>
<logic:notEqual name="orderBean" property="orderList.lastPage" value="true">
  <a href="switchOrderPage.shtml?pageDirection=next">Next &gt;&gt;</a>
</logic:notEqual>

<%@ include file="../common/IncludeBottom.jsp" %>



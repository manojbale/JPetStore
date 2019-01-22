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

<div id="Catalog">

  <html:form action="/shop/newOrder.shtml" styleId="orderBean" method="post">

    <table>
      <tr><th colspan=2>
        Shipping Address
      </th></tr>

      <tr><td>
        First name:</td><td><html:text name="orderBean" property="order.shipToFirstName"/>
      </td></tr>
      <tr><td>
        Last name:</td><td><html:text name="orderBean" property="order.shipToLastName"/>
      </td></tr>
      <tr><td>
        Address 1:</td><td><html:text size="40" name="orderBean" property="order.shipAddress1"/>
      </td></tr>
      <tr><td>
        Address 2:</td><td><html:text size="40" name="orderBean" property="order.shipAddress2"/>
      </td></tr>
      <tr><td>
        City: </td><td><html:text name="orderBean" property="order.shipCity"/>
      </td></tr>
      <tr><td>
        State:</td><td><html:text size="4" name="orderBean" property="order.shipState"/>
      </td></tr>
      <tr><td>
        Zip:</td><td><html:text size="10" name="orderBean" property="order.shipZip"/>
      </td></tr>
      <tr><td>
        Country: </td><td><html:text size="15" name="orderBean" property="order.shipCountry"/>
      </td></tr>


    </table>

    <input type="submit" name="submit" value="Continue">

  </html:form>

</div>

<%@ include file="../common/IncludeBottom.jsp" %>
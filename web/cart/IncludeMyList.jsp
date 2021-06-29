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
<bean:define id="myList" name="accountBean" property="myList"/>

<logic:present name="myList">
  <p>
    Pet Favorites
    <br/>
    Shop for more of your favorite pets here.
  </p>
  <ul>
    <logic:iterate id="product" name="myList">
      <li><html:link paramId="productId" paramName="product" paramProperty="productId" page="/shop/viewProduct.shtml">
        <bean:write name="product" property="name"/></html:link>
      (<bean:write name="product" property="productId"/>)</li>
    </logic:iterate>
  </ul>

  <p>
    <logic:notEqual name="myList" property="firstPage" value="true">
      <a href="switchMyListPage.shtml?pageDirection=previous&account.listOption=<bean:write name="accountBean"
          property="account.listOption"/>&account.bannerOption=< bean:write name="accountBean"
                                                                 property="account.bannerOption"/>">&lt;&lt;Prev</a>
    </logic:notEqual>
    <logic:notEqual name="myList" property="lastPage" value="true">
      <a href="switchMyListPage.shtml?pageDirection=next&account.listOption=<bean:write name="accountBean"
          property="account.listOption"/>&account.bannerOption=< bean:write name="accountBean"
                                                                 property="account.bannerOption"/>">Next &gt;&gt;</a>
    </logic:notEqual>
  </p>

</logic:present>





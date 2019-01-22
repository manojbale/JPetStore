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

<div id="Welcome">
  <div id="WelcomeContent">
    <logic:present name="accountBean" scope="session">
      <logic:equal name="accountBean" property="authenticated" scope="session" value="true">
        Welcome <bean:write name="accountBean" property="account.firstName"/>!
      </logic:equal>
    </logic:present>
  </div>
</div>

<div id="Main">
  <div id="Sidebar">
    <div id="SidebarContent">
      <html:link page="/shop/viewCategory.shtml?categoryId=FISH">
        <img src="../images/fish_icon.gif"/></html:link>
      <br/>
      Saltwater, Freshwater
      <br/>
      <html:link page="/shop/viewCategory.shtml?categoryId=DOGS">
        <img src="../images/dogs_icon.gif"/></html:link>
      <br/>
      Various Breeds
      <br/>
      <html:link page="/shop/viewCategory.shtml?categoryId=CATS">
        <img src="../images/cats_icon.gif"/></html:link>
      <br/>
      Various Breeds, Exotic Varieties
      <br/>
      <html:link page="/shop/viewCategory.shtml?categoryId=REPTILES">
        <img src="../images/reptiles_icon.gif"/></html:link>
      <br/>
      Lizards, Turtles, Snakes
      <br/>
      <html:link page="/shop/viewCategory.shtml?categoryId=BIRDS">
        <img src="../images/birds_icon.gif"/></html:link>
      <br/>Exotic Varieties
    </div>
  </div>

  <div id="MainImage">
    <div id="MainImageContent">
      <map name="estoremap"><area alt="Birds" coords="72,2,280,250" href="viewCategory.shtml?categoryId=BIRDS"
                                  shape="RECT"/>
        <area alt="Fish" coords="2,180,72,250" href="viewCategory.shtml?categoryId=FISH" shape="RECT"/>
        <area alt="Dogs" coords="60,250,130,320" href="viewCategory.shtml?categoryId=DOGS" shape="RECT"/>
        <area alt="Reptiles" coords="140,270,210,340" href="viewCategory.shtml?categoryId=REPTILES"
              shape="RECT"/>
        <area alt="Cats" coords="225,240,295,310" href="viewCategory.shtml?categoryId=CATS" shape="RECT"/>
        <area alt="Birds" coords="280,180,350,250" href="viewCategory.shtml?categoryId=BIRDS" shape="RECT"/>
      </map>
      <img height="355" src="../images/splash.gif" align="center" usemap="#estoremap" width="350"/>
    </div>
  </div>

  <div id="Separator">&nbsp;</div>
</div>

<%@ include file="../common/IncludeBottom.jsp" %>


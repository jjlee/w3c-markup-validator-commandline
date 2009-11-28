<!--
  Applet DTD for Voyager. The associated param
  element is defined in the object DTD.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

<!--=================== Java APPLET ==================================-->
<!--
  One of code or object attributes must be present.
  Place PARAM elements before other content.
-->
<!ELEMENT applet (#PCDATA | param | %block; | %inline; | %misc;)*>
<!ATTLIST applet
   %coreattrs;
   codebase    %URI;          #IMPLIED
   archive     CDATA          #IMPLIED
   code        CDATA          #IMPLIED
   object      CDATA          #IMPLIED
   alt         %Text;         #IMPLIED
   name        CDATA          #IMPLIED
   width       %Length;       #REQUIRED
   height      %Length;       #REQUIRED
   align       %IAlign;       #IMPLIED
   hspace      %Pixels;       #IMPLIED
   vspace      %Pixels;       #IMPLIED
   >


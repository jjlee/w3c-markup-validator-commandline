<!--
  This DTD defines miscellaneous block level elements for
  Voyager. Defines address, hr, pre, and blockquote elements

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!--=================== Address ==========================================-->

 <!ELEMENT address %Inline;> <!-- information on author -->
 <!ATTLIST address
   %attrs;
   >

 <!--=================== Horizontal Rule ==================================-->

 <!ENTITY % hr.extra "">

 <!ELEMENT hr EMPTY>
 <!ATTLIST hr
   %coreattrs;
   %events;
   %hr.extra;
   >

 <!--=================== Preformatted Text ================================-->

 <!ENTITY % pre.extra "">

 <!ELEMENT pre %Inline;>
 <!ATTLIST pre
   %attrs;
   %pre.extra;
   xml:space CDATA #FIXED "preserve"
   >

 <!--=================== Block-like Quotes ================================-->

 <!ELEMENT blockquote %Block;>
 <!ATTLIST blockquote
   %attrs;
   cite        %URI;          #IMPLIED
   >


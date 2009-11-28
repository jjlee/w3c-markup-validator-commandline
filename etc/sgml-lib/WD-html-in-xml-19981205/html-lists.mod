<!--
  This is the list DTD for Voyager. Defines ul, ol,
  li, dl, dt and dd elements.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!--=================== Lists ============================================-->

 <!-- Unordered Lists (UL) bullet styles -->
 <!ENTITY % ul.extra "">

 <!ELEMENT ul (li)+>
 <!ATTLIST ul
   %attrs;
   %ul.extra;
   >

 <!-- ordered (numbered) list -->
 <!ENTITY % ol.extra "">

 <!ELEMENT ol (li)+>
 <!ATTLIST ol
   %attrs;
   %ol.extra;
   >

 <!-- list item -->
 <!ENTITY % li.extra "">

 <!ELEMENT li %Flow;>
 <!ATTLIST li
   %attrs;
   %li.extra;
   >

 <!-- definition lists - DT for term, DD for its definition -->

 <!ENTITY % dl.extra "">

 <!ELEMENT dl (dt|dd)+>
 <!ATTLIST dl
   %attrs;
   %dl.extra;
   >

 <!ELEMENT dt %Inline;>
 <!ATTLIST dt
   %attrs;
   >

 <!ELEMENT dd %Flow;>
 <!ATTLIST dd
   %attrs;
   >


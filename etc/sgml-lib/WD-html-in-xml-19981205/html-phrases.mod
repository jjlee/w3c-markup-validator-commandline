<!--
  Font style and phrase markup, exluding span bdo and br which
  are defined in the base DTD. This is part of the Voyager
  suite of DTDs.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved.

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!--===================== Inline Elements ================================-->

 <!-- excludes span, bdo and br which are defined in the base module -->

 <!ELEMENT em %Inline;>   <!-- emphasis -->
 <!ATTLIST em %attrs;>

 <!ELEMENT strong %Inline;>   <!-- strong emphasis -->
 <!ATTLIST strong %attrs;>

 <!ELEMENT dfn %Inline;>   <!-- definitional -->
 <!ATTLIST dfn %attrs;>

 <!ELEMENT code %Inline;>   <!-- program code -->
 <!ATTLIST code %attrs;>

 <!ELEMENT samp %Inline;>   <!-- sample -->
 <!ATTLIST samp %attrs;>

 <!ELEMENT kbd %Inline;>  <!-- something user would type -->
 <!ATTLIST kbd %attrs;>

 <!ELEMENT var %Inline;>   <!-- variable -->
 <!ATTLIST var %attrs;>

 <!ELEMENT cite %Inline;>   <!-- citation -->
 <!ATTLIST cite %attrs;>

 <!ELEMENT abbr %Inline;>   <!-- abbreviation -->
 <!ATTLIST abbr %attrs;>

 <!ELEMENT acronym %Inline;>   <!-- acronym -->
 <!ATTLIST acronym %attrs;>

 <!ELEMENT q %Inline;>   <!-- inlined quote -->
 <!ATTLIST q
    %attrs;
   cite        %URI;          #IMPLIED
    >

 <!ELEMENT sub %Inline;> <!-- subscript -->
 <!ATTLIST sub %attrs;>

 <!ELEMENT sup %Inline;> <!-- superscript -->
 <!ATTLIST sup %attrs;>

 <!ELEMENT tt %Inline;>   <!-- fixed pitch font -->
 <!ATTLIST tt %attrs;>

 <!ELEMENT i %Inline;>   <!-- italic font -->
 <!ATTLIST i %attrs;>

 <!ELEMENT b %Inline;>   <!-- bold font -->
 <!ATTLIST b %attrs;>

 <!ELEMENT big %Inline;>   <!-- bigger font -->
 <!ATTLIST big %attrs;>

 <!ELEMENT small %Inline;>   <!-- smaller font -->
 <!ATTLIST small %attrs;>


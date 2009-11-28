<!--
  This is the img DTD for Voyager.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!--=================== Images ===========================================-->

 <!--
    To avoid accessibility problems for people who aren't
    able to see the image, you should provide a text
    description using the alt and longdesc attributes.
    In addition avoid the use of server-side image maps.
 -->

 <!ENTITY % img.extra "">

 <!ELEMENT img EMPTY>
 <!ATTLIST img
   %attrs;
   src         %URI;          #REQUIRED
   alt         %Text;         #REQUIRED
   longdesc    %URI;          #IMPLIED
   height      %Length;       #IMPLIED
   width       %Length;       #IMPLIED
   usemap      %URI;          #IMPLIED
   ismap       (ismap)        #IMPLIED
   author      CDATA          #IMPLIED
   copyright   CDATA          #IMPLIED
   %img.extra;
   >

 <!-- USEMAP points to a MAP element which may be in this document
   or an external document, although the latter is not widely supported -->

 <!--================== Client-side image maps ============================-->

 <!-- These can be placed in the same document or grouped in a
      separate document although this isn't yet widely supported -->

 <!ELEMENT map ((%block; | %misc;)+ | area+)>
 <!ATTLIST map
   %attrs;
   name        CDATA          #REQUIRED
   >

 <!ENTITY % area.extra "">

 <!ELEMENT area EMPTY>
 <!ATTLIST area
   %attrs;
   shape       %Shape;        "rect"
   coords      %Coords;       #IMPLIED
   href        %URI;          #IMPLIED
   nohref      (nohref)       #IMPLIED
   alt         %Text;         #REQUIRED
   tabindex    %Number;       #IMPLIED
   accesskey   %Character;    #IMPLIED
   onfocus     %Script;       #IMPLIED
   onblur      %Script;       #IMPLIED
   %area.extra;
   >


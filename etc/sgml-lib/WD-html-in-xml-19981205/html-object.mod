<!--
  DTD for the object element for Voyager.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!--==================== OBJECT ======================================-->
 <!--
   OBJECT is used to embed objects as part of HTML pages 
   PARAM elements should precede other content. Parameters
   can also be expressed as attribute/value pairs on the
   object element itself when brevity is desired.
 -->

 <!ENTITY % object.extra "">

 <!ELEMENT object (#PCDATA | param | %block; | %inline; | %misc;)*>
 <!ATTLIST object
   %attrs;
   declare     (declare)      #IMPLIED
   classid     %URI;          #IMPLIED
   codebase    %URI;          #IMPLIED
   data        %URI;          #IMPLIED
   type        %ContentType;  #IMPLIED
   codetype    %ContentType;  #IMPLIED
   archive     %URI;          #IMPLIED
   standby     %Text;         #IMPLIED
   height      %Length;       #IMPLIED
   width       %Length;       #IMPLIED
   usemap      %URI;          #IMPLIED
   name        CDATA          #IMPLIED
   tabindex    %Number;       #IMPLIED
   author      CDATA          #IMPLIED
   copyright   CDATA          #IMPLIED
   %object.extra;
   >

 <!--
   PARAM is used to supply a named property value.
   In XML it would seem natural to follow RDF and support an
   abbreviated syntax where the param elements are replaced
   by attribute value pairs on the OBJECT start tag.
 -->
 <!ELEMENT param EMPTY >
 <!ATTLIST param
   id          ID             #IMPLIED
   name        CDATA          #REQUIRED
   value       CDATA          #IMPLIED
   valuetype   (data|ref|object) "data"
   type        %ContentType;  #IMPLIED
   >


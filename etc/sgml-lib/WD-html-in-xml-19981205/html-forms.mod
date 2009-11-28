<!--
  Forms DTD for Voyager. This is expected to be
  supplanted by a new forms module providing an improved
  match to database and workflow applications.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!--================ Forms ===============================================-->
 <!ELEMENT form %Block;>   <!-- forms shouldn't be nested -->

 <!ENTITY % form.extra "">

 <!ATTLIST form
   %attrs;
   action      %URI;          #REQUIRED
   method      (get|post)     "get"
   enctype     %ContentType;  "application/x-www-form-urlencoded"
   onsubmit    %Script;       #IMPLIED
   onreset     %Script;       #IMPLIED
   accept-charset %Charsets;  #IMPLIED
   %form.extra;
   >

 <!--
   Each label must not contain more than ONE field
   Label elements shouldn't be nested.
 -->
 <!ELEMENT label %Inline;>
 <!ATTLIST label
   %attrs;
   for         IDREF          #IMPLIED
   accesskey   %Character;    #IMPLIED
   onfocus     %Script;       #IMPLIED
   onblur      %Script;       #IMPLIED
   >

 <!ENTITY % InputType
   "(text | password | checkbox |
     radio | submit | reset |
     file | hidden | image | button)"
    >

 <!-- attribute name required for all but submit & reset -->
 <!ENTITY % input.extra "">

 <!ELEMENT input EMPTY>     <!-- form control -->
 <!ATTLIST input
   %attrs;
   type        %InputType;    "text"
   name        CDATA          #IMPLIED
   value       CDATA          #IMPLIED
   checked     (checked)      #IMPLIED
   disabled    (disabled)     #IMPLIED
   readonly    (readonly)     #IMPLIED
   size        CDATA          #IMPLIED
   maxlength   %Number;       #IMPLIED
   src         %URI;          #IMPLIED
   alt         CDATA          #IMPLIED
   usemap      %URI;          #IMPLIED
   tabindex    %Number;       #IMPLIED
   accesskey   %Character;    #IMPLIED
   onfocus     %Script;       #IMPLIED
   onblur      %Script;       #IMPLIED
   onselect    %Script;       #IMPLIED
   onchange    %Script;       #IMPLIED
   accept      %ContentTypes; #IMPLIED
   %input.extra;
   >

 <!ELEMENT select (optgroup|option)+>  <!-- option selector -->
 <!ATTLIST select
   %attrs;
   name        CDATA          #IMPLIED
   size        %Number;       #IMPLIED
   multiple    (multiple)     #IMPLIED
   disabled    (disabled)     #IMPLIED
   tabindex    %Number;       #IMPLIED
   onfocus     %Script;       #IMPLIED
   onblur      %Script;       #IMPLIED
   onchange    %Script;       #IMPLIED
   >

 <!ELEMENT optgroup (option)+>   <!-- option group -->
 <!ATTLIST optgroup
   %attrs;
   disabled    (disabled)     #IMPLIED
   label       %Text;         #REQUIRED
   >

 <!ELEMENT option (#PCDATA)>     <!-- selectable choice -->
 <!ATTLIST option
   %attrs;
   selected    (selected)     #IMPLIED
   disabled    (disabled)     #IMPLIED
   label       %Text;         #IMPLIED
   value       CDATA          #IMPLIED
   >

 <!ELEMENT textarea (#PCDATA)>     <!-- multi-line text field -->
 <!ATTLIST textarea
   %attrs;
   name        CDATA          #IMPLIED
   rows        %Number;       #REQUIRED
   cols        %Number;       #REQUIRED
   disabled    (disabled)     #IMPLIED
   readonly    (readonly)     #IMPLIED
   tabindex    %Number;       #IMPLIED
   accesskey   %Character;    #IMPLIED
   onfocus     %Script;       #IMPLIED
   onblur      %Script;       #IMPLIED
   onselect    %Script;       #IMPLIED
   onchange    %Script;       #IMPLIED
   >

 <!--
   div is introduced here to enclose the contents of
   the fieldset element to avoid mixed content problems
 -->
 <!ELEMENT fieldset (legend,div)>   <!-- form control group -->
 <!ATTLIST fieldset
   %attrs;
   >

 <!ENTITY % legend.extra "">

 <!ELEMENT legend %Inline;>     <!-- fieldset label -->
 <!ATTLIST legend
   %attrs;
   accesskey   %Character;    #IMPLIED
   %legend.extra;
   >

 <!--
  Buttons shouldn't include anchors, form controls, or form elements
 --> 
 <!ELEMENT button %Flow;>  <!-- push button -->
 <!ATTLIST button
   %attrs;
   name        CDATA          #IMPLIED
   value       CDATA          #IMPLIED
   type        (button|submit|reset) "submit"
   disabled    (disabled)     #IMPLIED
   tabindex    %Number;       #IMPLIED
   accesskey   %Character;    #IMPLIED
   onfocus     %Script;       #IMPLIED
   onblur      %Script;       #IMPLIED
   >



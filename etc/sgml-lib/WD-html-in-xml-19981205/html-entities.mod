<!--
  This is the entities DTD for Voyager. It is derived from
  the HTML 4.0 strict DTD with a few changes to make it simple
  to formalize as XML. It should be included before any element
  declarations as it defines entities for the content models used
  by most elements in Voyager.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
  Date: 17th November 1998
-->

<!--================== Imported Names ====================================-->

 <!ENTITY % ContentType "CDATA">
     <!-- media type, as per [RFC2045] -->
 <!ENTITY % ContentTypes "CDATA">
     <!-- comma-separated list of media types, as per [RFC2045] -->
 <!ENTITY % Charset "CDATA">
     <!-- a character encoding, as per [RFC2045] -->
 <!ENTITY % Charsets "CDATA">
     <!-- a space separated list of character encodings, as per [RFC2045] -->
 <!ENTITY % LanguageCode "CDATA">
     <!-- a language code, as per [RFC1766] -->
 <!ENTITY % Character "CDATA">
     <!-- a single character from [ISO10646] -->
 <!ENTITY % Number "CDATA">
     <!-- one or more digits -->
 <!ENTITY % LinkTypes "CDATA">
     <!-- space-separated list of link types -->
 <!ENTITY % MediaDesc "CDATA">
     <!-- single or comma-separated list of media descriptors -->
 <!ENTITY % URI "CDATA">
     <!-- a Uniform Resource Identifier, see [RFC1808] and [RFC1738] -->

 <!ENTITY % Datetime "CDATA"> <!-- date and time information. ISO date format -->
 <!ENTITY % Script "CDATA"> <!-- script expression -->
 <!ENTITY % StyleSheet "CDATA"> <!-- style sheet data -->
 <!ENTITY % Text "CDATA"> <!-- render in this frame -->
 <!ENTITY % FrameTarget "CDATA"> <!-- render in this frame -->
 <!ENTITY % Length "CDATA"> <!-- nn for pixels or nn% for percentage length -->
 <!ENTITY % MultiLength "CDATA"> <!-- pixel, percentage, or relative -->
 <!ENTITY % MultiLengths "CDATA"> <!-- comma-separated list of MultiLength -->
 <!ENTITY % Pixels "CDATA"> <!-- integer representing length in pixels -->

 <!-- these are used for image maps -->
 <!ENTITY % Shape "(rect|circle|poly|default)">
 <!ENTITY % Coords "CDATA"> <!-- comma separated list of lengths -->

 <!--=================== Generic Attributes ===============================-->

 <!ENTITY % extra-attrs ""> <!-- for extensions -->
 
 <!-- core attributes common to most elements
   id       document-wide unique id
   class    space separated list of classes
   style    associated style info
   title    advisory title/amplification
 -->
 <!ENTITY % coreattrs
  "id          ID             #IMPLIED
   class       CDATA          #IMPLIED
   style       %StyleSheet;   #IMPLIED
   title       %Text;         #IMPLIED"
   >

 <!-- internationalization attributes
   lang        language code (backwards compatible)
   xml:lang    language code (as per XML 1.0 spec)
   dir         direction for weak/neutral text
 -->
 <!ENTITY % i18n
  "lang        %LanguageCode; #IMPLIED
   xml:lang    %LanguageCode; #IMPLIED
   dir         (ltr|rtl)      #IMPLIED"
   >

 <!-- attributes for common UI events
   onclick     a pointer button was clicked
   ondblclick  a pointer button was double clicked
   onmousedown a pointer button was pressed down
   onmouseup   a pointer button was released
   onmousemove a pointer was moved onto the element
   onmouseout  a pointer was moved away from the element
   onkeypress  a key was pressed and released
   onkeydown   a key was pressed down
   onkeyup     a key was released
 -->
 <!ENTITY % events
  "onclick     %Script;       #IMPLIED
   ondblclick  %Script;       #IMPLIED
   onmousedown %Script;       #IMPLIED
   onmouseup   %Script;       #IMPLIED
   onmouseover %Script;       #IMPLIED
   onmousemove %Script;       #IMPLIED
   onmouseout  %Script;       #IMPLIED
   onkeypress  %Script;       #IMPLIED
   onkeydown   %Script;       #IMPLIED
   onkeyup     %Script;       #IMPLIED"
   >

 <!-- attributes for elements that can get the focus
   accesskey   accessibility key character
   tabindex    position in tabbing order
   onfocus     the element got the focus
   onblur      the element lost the focus
 -->
 <!ENTITY % focus
  "accesskey   %Character;    #IMPLIED
   tabindex    %Number;       #IMPLIED
   onfocus     %Script;       #IMPLIED
   onblur      %Script;       #IMPLIED"
   >

 <!ENTITY % attrs "%coreattrs; %i18n; %events; %extra-attrs;">

 <!--=================== Text Elements =====================================-->

 <!-- use %extra.inline; to add new inline elements -->
 <!ENTITY % extra.inline "">

 <!ENTITY % media ""> <!-- override this to add media elements -->

 <!ENTITY % special
    "a | br | span | bdo %media;">

 <!-- these can occur at block or inline level -->
 <!ENTITY % misc "ins | del | script | noscript">

 <!-- core definition excludes fontstyle/phrase -->
 <!ENTITY % inline "%special; %extra.inline;">

 <!-- %Inline; covers inline or "text-level" elements -->
 <!ENTITY % Inline "(#PCDATA | %inline; | %misc;)*">

 <!--================== Block level elements ==============================-->

 <!ENTITY % heading "h1|h2|h3|h4|h5|h6">

 <!ENTITY % extra.block ""> <!-- for additions to block elements -->

 <!ENTITY % block
      "p | %heading; | div %extra.block;">

 <!ENTITY % Block "(#PCDATA | %block; | %misc;)*">

 <!-- %Flow; mixes Block and Inline and is used for list items etc. -->
 <!ENTITY % Flow "(#PCDATA | %block; | %inline; | %misc;)*">

 <!--================== HTML content models ===============================-->

 <!--
     HTML has two basic content models:

         %Inline;     character level elements and text strings
         %Block;      block-like elements e.g. paragraphs and lists
 -->

 <!-- this is used to adjust the content model for the html element -->
 <!ENTITY % html.content "head, body">


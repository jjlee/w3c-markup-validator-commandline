<!--
  Base DTD defining core HTML features for Voyager.
  This should be imported after the other Voyager DTDs.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!--=================== Document Body ====================================-->

 <!ENTITY % body.extra "">
 <!ENTITY % body.content "%Block;">

 <!ELEMENT body %body.content;>
 <!ATTLIST body
   %attrs;
   onload          %Script;   #IMPLIED
   onunload        %Script;   #IMPLIED
   %body.extra;
   >

 <!ELEMENT div %Flow;>  <!-- generic language/style container -->
 <!ATTLIST div
   %attrs;
   >

 <!--===================== Inline Elements ================================-->

 <!ELEMENT span %Inline;> <!-- generic language/style container -->
 <!ATTLIST span
   %attrs;
   >

 <!ELEMENT bdo %Inline;>  <!-- I18N BiDi over-ride -->
 <!ATTLIST bdo
   %coreattrs;
   lang        %LanguageCode; #IMPLIED
   dir         (ltr|rtl)      #REQUIRED
   >

 <!ENTITY % br.extra "">

 <!ELEMENT br EMPTY>   <!-- forced line break -->
 <!ATTLIST br
   %coreattrs;
   %br.extra;
   >

 <!--================== The Anchor Element ================================-->

 <!ENTITY % a.extra "">

 <!ELEMENT a %Inline;>  <!-- anchors shouldn't be nested -->
 <!ATTLIST a
   %attrs;
   charset     %Charset;      #IMPLIED
   type        %ContentType;  #IMPLIED
   name        CDATA          #IMPLIED
   href        %URI;          #IMPLIED
   hreflang    %LanguageCode; #IMPLIED
   rel         %LinkTypes;    #IMPLIED
   rev         %LinkTypes;    #IMPLIED
   accesskey   %Character;    #IMPLIED
   shape       %Shape;        "rect"
   coords      %Coords;       #IMPLIED
   tabindex    %Number;       #IMPLIED
   onfocus     %Script;       #IMPLIED
   onblur      %Script;       #IMPLIED
   xml:link    CDATA          #FIXED  "simple"
   %a.extra;
   >

 <!--================== The LINK Element ==================================-->

 <!--
   Relationship values can be used in principle:

    a) for document specific toolbars/menus when used
       with the LINK element in document head e.g.
         start, contents, previous, next, index, end, help
    b) to link to a separate style sheet (rel=stylesheet)
    c) to make a link to a script (rel=script)
    d) by stylesheets to control how collections of
       html nodes are rendered into printed documents
    e) to make a link to a printable version of this document
       e.g. a postscript or pdf version (rel=alternate media=print)
 -->

 <!ELEMENT link EMPTY>
 <!ATTLIST link
   %attrs;
   charset     %Charset;      #IMPLIED
   href        %URI;          #IMPLIED
   hreflang    %LanguageCode; #IMPLIED
   type        %ContentType;  #IMPLIED
   rel         %LinkTypes;    #IMPLIED
   rev         %LinkTypes;    #IMPLIED
   media       %MediaDesc;    #IMPLIED
   target      %FrameTarget;  #IMPLIED
   >

 <!--=================== Paragraphs =======================================-->

 <!ENTITY % p.extra "">

 <!ELEMENT p %Inline;>
 <!ATTLIST p
   %attrs;
   %p.extra;
   >

 <!--=================== Headings =========================================-->

 <!--
   There are six levels of headings from H1 (the most important)
   to H6 (the least important).
 -->

 <!ENTITY % headings.extra "">

 <!ELEMENT h1  %Inline;>
 <!ATTLIST h1
    %attrs;
    %headings.extra;
    >

 <!ELEMENT h2 %Inline;>
 <!ATTLIST h2
    %attrs;
    %headings.extra;
    >

 <!ELEMENT h3 %Inline;>
 <!ATTLIST h3
    %attrs;
    %headings.extra;
    >

 <!ELEMENT h4 %Inline;>
 <!ATTLIST h4
    %attrs;
    %headings.extra;
    >

 <!ELEMENT h5 %Inline;>
 <!ATTLIST h5
    %attrs;
    %headings.extra;
    >

 <!ELEMENT h6 %Inline;>
 <!ATTLIST h6
    %attrs;
    %headings.extra;
    >

 <!--=================== Inserted/Deleted Text ============================-->


 <!--
   INS/DEL are allowed in block and inline content, but its
   inappropriate to include block content within an ins element
   occurring in inline content.
 -->
 <!ELEMENT ins %Flow;>
 <!ATTLIST ins
   %attrs;
   cite        %URI;          #IMPLIED
   datetime    %Datetime;     #IMPLIED
   >

 <!ELEMENT del %Flow;>
 <!ATTLIST del
   %attrs;
   cite        %URI;          #IMPLIED
   datetime    %Datetime;     #IMPLIED
   >

 <!--================ Document Head =======================================-->

 <!ELEMENT head (title, base?, (script|style|meta|link)*)>
 <!ATTLIST head
   %i18n;
   profile     %URI;          #IMPLIED
   >

 <!-- The TITLE element is not considered part of the flow of text.
        It should be displayed, for example as the page header or
        window title. Exactly one title is required per document.
     -->
 <!ELEMENT title (#PCDATA)>
 <!ATTLIST title %i18n;>

 <!-- document base URI -->

 <!ENTITY % base.extra "">

 <!ELEMENT base EMPTY>
 <!ATTLIST base
   href        %URI;          #IMPLIED
   %base.extra;
   >

 <!-- generic metainformation -->
 <!ELEMENT meta EMPTY>
 <!ATTLIST meta
   %i18n;
   http-equiv  CDATA          #IMPLIED
   name        CDATA          #IMPLIED
   content     CDATA          #REQUIRED
   scheme      CDATA          #IMPLIED
   >
 
 <!-- style info, which may include CDATA sections -->
 <!ELEMENT style (#PCDATA)>
 <!ATTLIST style
   %i18n;
   type        %ContentType;  #REQUIRED
   media       %MediaDesc;    #IMPLIED
   title       %Text;         #IMPLIED
   xml:space   CDATA          #FIXED     "preserve"
   >
 
 <!-- script statements, which may include CDATA sections -->
 <!ELEMENT script (#PCDATA)>
 <!ATTLIST script
   charset     %Charset;      #IMPLIED
   type        %ContentType;  #REQUIRED
   language    CDATA          #IMPLIED
   src         %URI;          #IMPLIED
   defer       (defer)        #IMPLIED
   xml:space   CDATA          #FIXED     "preserve"
   >

 <!-- alternate content container for non script-based rendering -->

 <!ENTITY % noscript.content "%Block;">

 <!ELEMENT noscript %noscript.content;>
 <!ATTLIST noscript
   %attrs;
   >

 <!--================ Document Structure ==================================-->

<!-- the namespace URI designates the document profile -->
 <!ELEMENT html (%html.content;)>
 <!ATTLIST html
   %i18n;
   xmlns       %URI;          #REQUIRED
   >


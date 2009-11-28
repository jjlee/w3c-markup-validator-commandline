<!--
  DTD for table elements for Voyager.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>

  Table tags present rendering problems for small displays
  and voice browsers. As a result, W3C hopes to provide an
  alternative tag set that makes the data model for tabular
  data explicit, thereby making it easier to provide renderings
  appropriate to device capabilities, e.g. as expanding lists.
-->

 <!--======================= Tables =======================================-->

 <!-- Derived from IETF HTML table standard, see [RFC1942] -->

 <!--
  The BORDER attribute sets the thickness of the frame around the
  table. The default units are screen pixels.

  The FRAME attribute specifies which parts of the frame around
  the table should be rendered. The values are not the same as
  CALS to avoid a name clash with the VALIGN attribute.

  The value "border" is included for backwards compatibility with
  <TABLE BORDER> which yields frame=border and border=implied
  For <TABLE BORDER=1> you get border=1 and frame=implied. In this
  case, it is appropriate to treat this as frame=border for backwards
  compatibility with deployed browsers.
 -->
 <!ENTITY % TFrame "(void|above|below|hsides|lhs|rhs|vsides|box|border)">

 <!--
  The RULES attribute defines which rules to draw between cells:

  If RULES is absent then assume:
      "none" if BORDER is absent or BORDER=0 otherwise "all"
 -->

 <!ENTITY % TRules "(none | groups | rows | cols | all)">
   
 <!-- horizontal placement of table relative to document -->
 <!ENTITY % TAlign "(left|center|right)">

 <!-- horizontal alignment attributes for cell contents

   char        alignment char, e.g. char=':'
   charoff     offset for alignment char
 -->
 <!ENTITY % cellhalign
   "align      (left|center|right|justify|char) #IMPLIED
    char       %Character;    #IMPLIED
    charoff    %Length;       #IMPLIED"
   >

 <!-- vertical alignment attributes for cell contents -->
 <!ENTITY % cellvalign
   "valign     (top|middle|bottom|baseline) #IMPLIED"
   >

 <!ELEMENT table
      (caption?, (col*|colgroup*), ((thead?, tfoot?, tbody+)|(tr+)))>
 <!ELEMENT caption  %Inline;>
 <!ELEMENT thead    (tr)+>
 <!ELEMENT tfoot    (tr)+>
 <!ELEMENT tbody    (tr)+>
 <!ELEMENT colgroup (col)*>
 <!ELEMENT col      EMPTY>
 <!ELEMENT tr       (th|td)+>
 <!ELEMENT th       %Flow;>
 <!ELEMENT td       %Flow;>

 <!ATTLIST table
   %attrs;
   summary     %Text;         #IMPLIED
   width       %Length;       #IMPLIED
   border      CDATA          #IMPLIED
   frame       %TFrame;       #IMPLIED
   rules       %TRules;       #IMPLIED
   cellspacing %Length;       #IMPLIED
   cellpadding %Length;       #IMPLIED
   >

 <!ENTITY % CAlign "(top|bottom|left|right)">
 <!ENTITY % caption.extra "">

 <!ATTLIST caption
   %attrs;
   %caption.extra;
   >

 <!--
 COLGROUP groups a set of COL elements. It allows you to group
 several semantically related columns together.
 -->
 <!ATTLIST colgroup
   %attrs;
   span        %Number;       "1"
   width       %MultiLength;  #IMPLIED
   %cellhalign;
   %cellvalign;
   >

 <!--
  COL elements define the alignment properties for cells in
  one or more columns.

  The WIDTH attribute specifies the width of the columns, e.g.

      width=64        width in screen pixels
      width=0.5*      relative width of 0.5

  The SPAN attribute causes the attributes of one
  COL element to apply to more than one column.
 -->
 <!ATTLIST col
   %attrs;
   span        %Number;       "1"
   width       %MultiLength;  #IMPLIED
   %cellhalign;
   %cellvalign;
   >

 <!--
     Use THEAD to duplicate headers when breaking table
     across page boundaries, or for static headers when
     TBODY sections are rendered in scrolling panel.

     Use TFOOT to duplicate footers when breaking table
     across page boundaries, or for static footers when
     TBODY sections are rendered in scrolling panel.

     Use multiple TBODY sections when rules are needed
     between groups of table rows.
 -->
 <!ATTLIST thead
   %attrs;
   %cellhalign;
   %cellvalign;
   >

 <!ATTLIST tfoot
   %attrs;
   %cellhalign;
   %cellvalign;
   >

 <!ATTLIST tbody
   %attrs;
   %cellhalign;
   %cellvalign;
   >

 <!ATTLIST tr
   %attrs;
   %cellhalign;
   %cellvalign;
   >


 <!-- Scope is simpler than axes attribute for common tables -->
 <!ENTITY % Scope "(row|col|rowgroup|colgroup)">

 <!-- TH is for headers, TD for data, but for cells acting as both use TD -->

 <!ATTLIST th
   %attrs;
   abbr        %Text;         #IMPLIED
   axis        CDATA          #IMPLIED
   headers     IDREFS         #IMPLIED
   scope       %Scope;        #IMPLIED
   rowspan     %Number;       "1"
   colspan     %Number;       "1"
   %cellhalign;
   %cellvalign;
   >

 <!ATTLIST td
   %attrs;
   abbr        %Text;         #IMPLIED
   axis        CDATA          #IMPLIED
   headers     IDREFS         #IMPLIED
   scope       %Scope;        #IMPLIED
   rowspan     %Number;       "1"
   colspan     %Number;       "1"
   %cellhalign;
   %cellvalign;
   >


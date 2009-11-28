<!--
  Common presentation entity and element declarations
  for Voyager. This should be imported before element
  declarations.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!-- a color using sRGB: #RRGGBB as Hex values -->
 <!ENTITY % Color "CDATA">

 <!-- There are also 16 widely known color names with their sRGB values:

     Black  = #000000    Green  = #008000
     Silver = #C0C0C0    Lime   = #00FF00
     Gray   = #808080    Olive  = #808000
     White  = #FFFFFF    Yellow = #FFFF00
     Maroon = #800000    Navy   = #000080
     Red    = #FF0000    Blue   = #0000FF
     Purple = #800080    Teal   = #008080
     Fuchsia= #FF00FF    Aqua   = #00FFFF
 -->

 <!ENTITY % body.extra "
   background  %URI;          #IMPLIED
   bgcolor     %Color;        #IMPLIED
   text        %Color;        #IMPLIED
   link        %Color;        #IMPLIED
   vlink       %Color;        #IMPLIED
   alink       %Color;        #IMPLIED
   ">

 <!ENTITY % body.content "%Flow;">

 <!ENTITY % noscript.content "%Flow;">

 <!ENTITY % br.extra "
   clear       (left|all|right|none) 'none'
   ">

 <!ENTITY % IAlign "(top|middle|bottom|left|right)">

 <!ENTITY % img.extra "
   align       %IAlign;       #IMPLIED
   border      %Length;       #IMPLIED
   hspace      %Pixels;       #IMPLIED
   vspace      %Pixels;       #IMPLIED
   ">

 <!ENTITY % object.extra "
   align       %IAlign;       #IMPLIED
   border      %Length;       #IMPLIED
   hspace      %Pixels;       #IMPLIED
   vspace      %Pixels;       #IMPLIED
   ">

 <!ENTITY % hr.extra "
   align       (left|center|right) #IMPLIED
   noshade     (noshade)      #IMPLIED
   size        %Pixels;       #IMPLIED
   width       %Length;       #IMPLIED
   ">

 <!-- default is left for ltr paragraphs, right for rtl -->
 <!ENTITY % p.extra "
   align       (left|center|right) #IMPLIED
   ">

 <!-- default is left for ltr headings, right for rtl -->
 <!ENTITY % headings.extra "
   align       (left|center|right) #IMPLIED
   ">

 <!ENTITY % pre.extra "
   width       %Number;      #IMPLIED
   ">

 <!-- Unordered Lists (UL) bullet styles -->
 <!ENTITY % ULStyle "(disc|square|circle)">

 <!ENTITY % ul.extra "
   type        %ULStyle;     #IMPLIED
   compact     (compact)     #IMPLIED
   ">

 <!-- Ordered lists (OL) Numbering style

     1   arablic numbers     1, 2, 3, ...
     a   lower alpha         a, b, c, ...
     A   upper alpha         A, B, C, ...
     i   lower roman         i, ii, iii, ...
     I   upper roman         I, II, III, ...

     The style is applied to the sequence number which by default
     is reset to 1 for the first list item in an ordered list.
 -->
 <!ENTITY % OLStyle "CDATA">

 <!ENTITY % ol.extra "
   type        %OLStyle;      #IMPLIED
   compact     (compact)      #IMPLIED
   start       %Number;       #IMPLIED
   ">

 <!ENTITY % dl.extra "
   compact     (compact)      #IMPLIED
   ">

 <!-- LIStyle is constrained to: "(%ULStyle;|%OLStyle;)" -->
 <!ENTITY % LIStyle "CDATA">

 <!ENTITY % li.extra "
   type        %LIStyle;      #IMPLIED
   value       %Number;       #IMPLIED
   ">

 <!ENTITY % CAlign "(top|bottom|left|right)">
 <!ENTITY % caption.extra "
   align       %CAlign;       #IMPLIED
   ">

 <!ENTITY % base.extra "
   target      %FrameTarget;  #IMPLIED
   ">

 <!ENTITY % a.extra "
   target      %FrameTarget;  #IMPLIED
   ">

 <!ENTITY % area.extra "
   target      %FrameTarget;  #IMPLIED
   ">

 <!ENTITY % form.extra "
   target      %FrameTarget;  #IMPLIED
   ">

 <!ENTITY % input.extra "
   align       %IAlign;       #IMPLIED
   ">

 <!ENTITY % LAlign "(top|bottom|left|right)">

 <!ENTITY % legend.extra "
   align       %LAlign;       #IMPLIED
   ">

 <!-- underline -->
 <!ELEMENT u %Inline;>
 <!ATTLIST u %attrs;>

 <!-- strike-through -->
 <!ELEMENT s %Inline;>
 <!ATTLIST s %attrs;>

 <!-- base font size -->
 <!ELEMENT basefont EMPTY>
 <!ATTLIST basefont
   id          ID             #IMPLIED
   size        CDATA          #REQUIRED
   color       %Color;        #IMPLIED
   face        CDATA          #IMPLIED
   >

 <!-- local change to font -->
 <!ELEMENT font %Inline;>
 <!ATTLIST font
   %coreattrs;
   %i18n;
   size        CDATA          #IMPLIED
   color       %Color;        #IMPLIED
   face        CDATA          #IMPLIED
   >

 <!-- center content -->
 <!ELEMENT center %Flow;>
 <!ATTLIST center
   %coreattrs;
   %i18n;
   >

 <!-- redefined for frameset docs -->
 <!ENTITY % noframes.content "%Flow;">

 <!-- alternate content container for non frame-based rendering -->
 <!ELEMENT noframes %noframes.content;>
 <!ATTLIST noframes
   %attrs;
   >


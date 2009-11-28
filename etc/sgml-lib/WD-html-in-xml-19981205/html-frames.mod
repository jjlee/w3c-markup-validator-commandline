<!--
  Frameset DTD for Voyager.

  Copyright (c) 1998 W3C (MIT, INRIA, Keio), All Rights Reserved. 

  Author: Dave Raggett  <dsr@w3.org>
-->

 <!--======================= Frames =======================================-->

 <!-- only one noframes element permitted per document -->

 <!ELEMENT frameset (frameset|frame|noframes)*>
 <!ATTLIST frameset
   %coreattrs;
   rows        %MultiLengths; #IMPLIED
   cols        %MultiLengths; #IMPLIED
   onload      %Script;       #IMPLIED
   onunload    %Script;       #IMPLIED
   >

 <!-- reserved frame names start with "_" otherwise starts with letter -->

 <!-- tiled window within frameset -->
 <!ELEMENT frame EMPTY>
 <!ATTLIST frame
   %coreattrs;
   longdesc    %URI;          #IMPLIED
   name        CDATA          #IMPLIED
   frameborder (1|0)          "1"
   marginwidth %Pixels;       #IMPLIED
   marginheight %Pixels;      #IMPLIED
   noresize    (noresize)     #IMPLIED
   scrolling   (yes|no|auto)  "auto"
   >

 <!-- inline subwindow -->
 <!ELEMENT iframe %Flow;>
 <!ATTLIST iframe
   %coreattrs;
   longdesc    %URI;          #IMPLIED
   name        CDATA          #IMPLIED
   src         %URI;          #IMPLIED
   frameborder (1|0)          "1"
   marginwidth %Pixels;       #IMPLIED
   marginheight %Pixels;      #IMPLIED
   scrolling   (yes|no|auto)  "auto"
   align       %IAlign;       #IMPLIED
   height      %Length;       #IMPLIED
   width       %Length;       #IMPLIED
   >


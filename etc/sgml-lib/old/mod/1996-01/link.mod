<!-- $Id: link.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->

<!ENTITY % linkType "NAMES">

<!ENTITY % linkExtraAttributes
        "REL %linkType #IMPLIED
        REV %linkType #IMPLIED
        URN CDATA #IMPLIED
        TITLE CDATA #IMPLIED
        METHODS NAMES #IMPLIED
        CHARSET NAME #IMPLIED
        ">

<![ %HTML.Recommended [
        <!ENTITY % A.content   "(%text)*"
        -- <H1><a name="xxx">Heading</a></H1>
                is preferred to
           <a name="xxx"><H1>Heading</H1></a>
        -->
]]>

<!ENTITY % A.content   "(%heading|%text)*">

<!ELEMENT A     - - %A.content -(A)>
<!ATTLIST A
        %attrs;
        HREF CDATA #IMPLIED
        NAME CDATA #IMPLIED
        %linkExtraAttributes;
        %SDAPREF; "<Anchor: #AttList>"
        >
<!-- <A>                Anchor; source/destination of link      -->
<!-- <A NAME="...">     Name of this anchor                     -->
<!-- <A HREF="...">     Address of link destination             -->
<!-- <A URN="...">      Permanent address of destination        -->
<!-- <A REL=...>        Relationship to destination             -->
<!-- <A REV=...>        Relationship of destination to this     -->
<!-- <A TITLE="...">    Title of destination (advisory)         -->
<!-- <A METHODS="...">  Operations on destination (advisory)    -->
<!-- <A CHARSET="...">  Charset of destination (advisory)       -->

<!-- End of link.module -->

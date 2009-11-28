<!-- $Id: struct.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->

<!ELEMENT HTML O O (HEAD, BODY) >
<!ENTITY % version.attr "VERSION CDATA #FIXED '%HTML.Version;'">

<!ATTLIST HTML
        %attrs;
        %version.attr;
        %SDAFORM; "Book"
        >

<!-- <HTML>                     HTML Document   -->

<!-- End of struct.module -->

<!-- $Id: headings.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->

<!ELEMENT HR    - O EMPTY>
<!ATTLIST HR
        DIR  (ltr|rtl) #IMPLIED
	%hr-align-attrs;
        %SDAPREF; "&#RE;&#RE;"
        >

<!-- <HR>       Horizontal rule -->

<!ELEMENT ( %heading )  - -  (%text;)*>
<!ATTLIST H1
        %attrs;
        %just;
        %SDAFORM; "H1"
        >
<!ATTLIST H2
        %attrs;
        %just;
        %SDAFORM; "H2"
        >
<!ATTLIST H3
        %attrs;
        %just;
        %SDAFORM; "H3"
        >
<!ATTLIST H4
        %attrs;
        %just;
        %SDAFORM; "H4"
        >
<!ATTLIST H5
        %attrs;
        %just;
        %SDAFORM; "H5"
        >
<!ATTLIST H6
        %attrs;
        %just;
        %SDAFORM; "H6"
        >

<!-- <H1>       Heading, level 1 -->
<!-- <H2>       Heading, level 2 -->
<!-- <H3>       Heading, level 3 -->
<!-- <H4>       Heading, level 4 -->
<!-- <H5>       Heading, level 5 -->
<!-- <H6>       Heading, level 6 -->

<!-- End of headings.module -->

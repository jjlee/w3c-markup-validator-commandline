<!-- $Id: body.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->


<![ %HTML.Recommended [
        <!ENTITY % body.content "(%heading|%block|HR|ADDRESS|IMG)*"
        -- <h1>Heading</h1>
           <p>Text ...
                is preferred to
           <h1>Heading</h1>
           Text ...
        -->
]]>

<!ELEMENT BODY O O  %body.content>
<!ATTLIST BODY
        %attrs;
	%body-color-attrs;
        >

<!-- <BODY>     Document body   -->

<!ELEMENT BLOCKQUOTE - - %body.content>
<!ATTLIST BLOCKQUOTE
        %attrs;
        %just;
        %SDAFORM; "BQ"
        >

<!-- <BLOCKQUOTE>       Quoted passage  -->

<!ELEMENT ADDRESS - - (%text|P)*>
<!ATTLIST  ADDRESS
        %attrs;
        %just;
        %SDAFORM; "Lit"
        %SDAPREF; "Address:&#RE;"
        >

<!-- <ADDRESS>  Address, signature, or byline   -->

<!-- End of body.module -->

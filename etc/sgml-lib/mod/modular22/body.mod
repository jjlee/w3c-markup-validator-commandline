<!-- ............................................................ -->
<!-- HTML DTD Document Body Module .............................. -->
<!-- File body.mod ............................................. -->

<!ENTITY % body.module.status %HTML.status; >
<!ENTITY % body.module.expires %HTML.expires; >
<!ENTITY % body.module.version 
        "-//IETF//ELEMENTS HTML V2.2 Document Body//EN" >

<![ %HTML.Recommended [
        <!ENTITY % body.content "(%heading|%block|HR|ADDRESS|IMG)*"
        -- <h1>Heading</h1>
           <p>Text ...
                is preferred to
           <h1>Heading</h1>
           Text ...
        -->
]]>

<!ENTITY % body.content "(%heading | %text | %block |
                                 HR | ADDRESS)*">

<!ELEMENT BODY O O  %body.content>
<!ATTLIST BODY
        %attrs;
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

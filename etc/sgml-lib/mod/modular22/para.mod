<!-- ............................................................ -->
<!-- HTML DTD Paragraphs Module ................................. -->
<!-- File para.mod ............................................. -->

<!ENTITY % paragraphs.module.status %HTML.status; >
<!ENTITY % paragraphs.module.expires %HTML.expires; >
<!ENTITY % paragraphs.module.version 
        "-//IETF//ELEMENTS HTML V2.2 Paragraphs//EN" >

<!ELEMENT P     - O (%text)*>
<!ATTLIST P
        %attrs;
        %just;
        %SDAFORM; "Para"
        >

<!-- <P>        Paragraph       -->

<!-- End of para.module -->

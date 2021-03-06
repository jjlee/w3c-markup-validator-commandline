<!-- ............................................................ -->
<!-- HTML DTD Images Module ...................................... -->
<!-- File images.mod ............................................. -->

<!ENTITY % images.module.status %HTML.status; >
<!ENTITY % images.module.expires %HTML.expires; >
<!ENTITY % images.module.version 
        "-//IETF//ELEMENTS HTML V2.2 Images//EN" >

<!ELEMENT IMG    - O EMPTY>
<!ATTLIST IMG
        %attrs;
        SRC CDATA  #REQUIRED
        ALT CDATA #IMPLIED
        ALIGN (top|middle|bottom) #IMPLIED
        ISMAP (ISMAP) #IMPLIED
        %SDAPREF; "<Fig><?SDATrans Img: #AttList>#AttVal(Alt)</Fig>"
        >

<!-- <IMG>              Image; icon, glyph or illustration      -->
<!-- <IMG SRC="...">    Address of image object                 -->
<!-- <IMG ALT="...">    Textual alternative                     -->
<!-- <IMG ALIGN=...>    Position relative to text               -->
<!-- <IMG ISMAP>        Each pixel can be a link                -->

<!-- End of images.module -->

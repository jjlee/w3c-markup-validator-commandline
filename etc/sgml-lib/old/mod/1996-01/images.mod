<!-- $id$ -->

<!ELEMENT IMG    - O EMPTY>

<!entity % image-reference "
        SRC CDATA  #REQUIRED
	">

<!ATTLIST IMG
        %attrs;
	%image-reference
        ALT CDATA #IMPLIED
	%image-align.attrs;
        ISMAP (ISMAP) #IMPLIED
        %SDAPREF; "<Fig><?SDATrans Img: #AttList>#AttVal(Alt)</Fig>"
        >

<!-- <IMG>              Image; icon, glyph or illustration      -->
<!-- <IMG SRC="...">    Address of image object                 -->
<!-- <IMG ALT="...">    Textual alternative                     -->
<!-- <IMG ALIGN=...>    Position relative to text               -->
<!-- <IMG ISMAP>        Each pixel can be a link                -->

<!-- End of images.module -->

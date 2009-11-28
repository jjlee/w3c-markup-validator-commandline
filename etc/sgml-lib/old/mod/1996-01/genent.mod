<!-- $Id: genent.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->

<!-- Imported Names ................................... -->

<!ENTITY % URI "CDATA" -- @@ need to use this in appropriate places -->

<!ENTITY % Content-Type "CDATA"
        -- meaning an internet media type
           (aka MIME content type, as per RFC1521)
        -->

<!ENTITY % HTTP-Method "GET | POST"
        -- as per HTTP specification, in progress
        -->

<!-- DTD "Macros" ..................................... -->

<!ENTITY % heading " H1 | H2 | H3 | H4 | H5 | H6 ">

<!ENTITY % list " UL | OL | DIR | MENU " >

<!ENTITY % id-class.attrs
       "id      ID       #IMPLIED  -- element identifier --
        class   NAMES    #IMPLIED  -- for subclassing elements --
	">

<!ENTITY % attrs "
        %id-class.attrs
	%style.attrs
	%i18n.attrs
	">

<!-- End of genent.module -->

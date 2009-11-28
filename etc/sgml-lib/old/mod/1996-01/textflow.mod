<!-- $Id: textflow.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->

<!ENTITY % preformatted "PRE">

<!ENTITY % block "P | %list | DL | BLOCK
        | %preformatted
        | FORM
	| CENTER
	| TABLE
        | BLOCKQUOTE
	">
        

<!ENTITY % flow "(%text|%block)*">

<!ENTITY % pre.content "#PCDATA | A | HR | BR | SPAN | BDO">
<!ELEMENT PRE - - (%pre.content)*>
<!ATTLIST PRE
        %attrs;
        WIDTH NUMBER #implied
        %SDAFORM; "Lit"
        >

<!-- <PRE>              Preformatted text               -->
<!-- <PRE WIDTH=...>    Maximum characters per line     -->

<!ENTITY % body.content "(%heading | %text | %block |
                                 HR | ADDRESS)*">


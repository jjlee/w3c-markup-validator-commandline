<!-- ............................................................ -->
<!-- HTML DTD Text Flows Module ................................. -->
<!-- File textflow.mod ......................................... -->

<!ENTITY % textflows.module.status %HTML.status; >
<!ENTITY % textflows.module.expires %HTML.expires; >
<!ENTITY % textflows.module.version 
        "-//IETF//ELEMENTS HTML V2.2 Text Flows//EN" >


<![ %forms.module [
        <!ENTITY % block.forms "BLOCKQUOTE | FORM | ISINDEX">
]]>

<!ENTITY % block.forms "BLOCKQUOTE">

<!ENTITY % preformatted "PRE">

<!ENTITY % block "P | %list | DL
        | %preformatted
        | %block.forms">
        
<![ %tables.module [
        <!ENTITY % block "P | %list | DL
        | %preformatted
        | %block.forms
        | TABLE">
]]>        

<!ENTITY % block "P | %list | DL
        | %preformatted
        | %block.forms">

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

<!-- End of textflows.module -->

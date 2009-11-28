<!-- ............................................................ -->
<!-- HTML DTD Character Mnemonics Module ........................ -->
<!-- File char.mod .............................................. -->

<!ENTITY % char.module.status   %HTML.status; >
<!ENTITY % char.module.expires  %HTML.expires; >
<!ENTITY % char.module.version 
        "-//IETF//ENTITIES HTML V2.2 Character Mnemonics//EN" >
        
<!--    Character Set
        The adoption of the UCS-2 (ISO xxx) document 
        character set implies a change in the SGML 
        declaration specified in the HTML 2.0 specification
        (section 9.5 of HTML-2/RFC 1866 [RFC1866]). The 
        updated SGML declaration is included with the 
        HTML V2.2 release.
-->

<!-- Character mnemonic entities .......................-->
<!ENTITY % ISOlat1 PUBLIC
        "ISO 8879-1986//ENTITIES Added Latin 1 v.mod22//EN//HTML" >
%ISOlat1;
<!-- the 'v.mod22' above was added by Gerald Oskoboiny to distinguish -->
<!-- it from the other stuff with the same name in my catalog. -->

<!-- Entities for markup significant characters ........-->
<!ENTITY amp CDATA "&#38;"     -- ampersand             -->
<!ENTITY gt CDATA "&#62;"      -- greater than          -->
<!ENTITY lt CDATA "&#60;"      -- less than             -->
<!ENTITY quot CDATA "&#34;"    -- double quote          -->

<!-- Entities for language-dependent presentation 
     (BIDI and contextual analysis) ....................-->
<!ENTITY zwnj CDATA "&#8204;"  -- zero width non-joiner -->
<!ENTITY zwj  CDATA "&#8205;"  -- zero width joiner     -->
<!ENTITY lrm  CDATA "&#8206;"  -- left-to-right mark    -->
<!ENTITY rlm  CDATA "&#8207;"  -- right-to-left mark    -->

<!-- End of char.module -->

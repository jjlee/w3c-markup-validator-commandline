<!-- $Id: text.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->

<!ENTITY % font " TT | B | I ">

<!ENTITY % phrase "EM | STRONG | CODE | SAMP | KBD | VAR | CITE">

<!ENTITY % text "#PCDATA | A | IMG | INSERT | BR | %phrase | %font |
                  SPAN | Q | BDO | SUP | SUB">

<!ELEMENT (%font;|%phrase) - O (%text)* -- @@ allow ommitted end tag? -->
<!ATTLIST ( TT | CODE | SAMP | KBD | VAR )
        %attrs;
        %SDAFORM; "Lit"
        >
<!ATTLIST ( B | STRONG )
        %attrs;
        %SDAFORM; "B"
        >
<!ATTLIST ( I | EM | CITE )
        %attrs;
        %SDAFORM; "It"
        >

<!-- <TT>       Typewriter text                         -->
<!-- <B>        Bold text                               -->
<!-- <I>        Italic text                             -->
<!-- <EM>       Emphasized phrase                       -->
<!-- <STRONG>   Strong emphasis                         -->
<!-- <CODE>     Source code phrase                      -->
<!-- <SAMP>     Sample text or characters               -->
<!-- <KBD>      Keyboard phrase, e.g. user input        -->
<!-- <VAR>      Variable phrase or substituable         -->
<!-- <CITE>     Name or title of cited work             -->

<!ENTITY % pre.content "#PCDATA | A | HR | BR | %font | %phrase |
                         SPAN | BDO">
                          
<!-- @@Should the BDO element have an SDAFORM attr.?  Which? -->
<!ELEMENT BDO - - (%text)+>
<!ATTLIST BDO
        LANG   NAME      #IMPLIED
        DIR    (ltr|rtl) #REQUIRED
        >

<!-- <BDO>     Control bidirectional text             -->

<!ELEMENT BR    - O EMPTY>
<!ATTLIST BR
        %SDAPREF; "&#RE;"
        >

<!-- <BR>       Line break      -->

<!-- Should the SPAN element have an SDAFORM attr.?  Which? -->
<!ELEMENT SPAN - - (%text)*>
<!ATTLIST SPAN
        %attrs;
>

<!-- <SPAN>     Generic container        -->

<!ELEMENT Q - - (%text)*>
<!ATTLIST Q
        %attrs;
        %SDAFORM; "It"  -- to be verified --
        >

<!-- <Q>        Short quotation                         -->

<!ELEMENT (SUP|SUB) - - (#PCDATA)>
<!ATTLIST (SUP|SUB)
        %attrs;
        >

<!-- <SUP>      Superscript              -->
<!-- <SUB>      Subscript                -->

<!-- End of text.module -->

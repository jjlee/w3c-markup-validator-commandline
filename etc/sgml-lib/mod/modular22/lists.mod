<!-- ............................................................ -->
<!-- HTML DTD Lists Module ...................................... -->
<!-- File lists.mod ............................................. -->

<!ENTITY % lists.module.status %HTML.status; >
<!ENTITY % lists.module.expires %HTML.expires; >
<!ENTITY % lists.module.version 
        "-//IETF//ELEMENTS HTML V2.2 Lists//EN" >

<!ELEMENT DL    - -  (DT | DD)+>
<!ATTLIST DL
        %attrs;
        COMPACT (COMPACT) #IMPLIED
        %SDAFORM; "List"
        %SDAPREF; "Definition List:"
        >

<!ELEMENT DT    - O (%text)*>
<!ATTLIST DT
        %attrs;
        %SDAFORM; "Term"
        >

<!ELEMENT DD    - O %flow>
<!ATTLIST DD
        %attrs;
        %SDAFORM; "LItem"
        >

<!-- <DL>               Definition list, or glossary    -->
<!-- <DL COMPACT>       Compact style list              -->
<!-- <DT>               Term in definition list         -->
<!-- <DD>               Definition of term              -->

<!ELEMENT (OL|UL) - -  (LI)+>
<!ATTLIST OL
        %attrs;
        %just;
        COMPACT (COMPACT) #IMPLIED
        %SDAFORM; "List"
        >
<!ATTLIST UL
        %attrs;
        %just;
        COMPACT (COMPACT) #IMPLIED
        %SDAFORM; "List"
        >
<!-- <UL>               Unordered list                  -->
<!-- <UL COMPACT>       Compact list style              -->
<!-- <OL>               Ordered, or numbered list       -->
<!-- <OL COMPACT>       Compact list style              -->


<!ELEMENT (DIR|MENU) - -  (LI)+ -(%block)>
<!ATTLIST DIR
        %attrs;
        %just;
        COMPACT (COMPACT) #IMPLIED
        %SDAFORM; "List"
        %SDAPREF; "<LHead>Directory</LHead>"
        >
<!ATTLIST MENU
        %attrs;
        %just;
        COMPACT (COMPACT) #IMPLIED
        %SDAFORM; "List"
        %SDAPREF; "<LHead>Menu</LHead>"
        >

<!-- <DIR>              Directory list                  -->
<!-- <DIR COMPACT>      Compact list style              -->
<!-- <MENU>             Menu list                       -->
<!-- <MENU COMPACT>     Compact list style              -->

<!ELEMENT LI    - O %flow>
<!ATTLIST LI
        %attrs;
        %just;
        %SDAFORM; "LItem"
        >

<!-- <LI>               List item                       -->

<!-- End of lists.module -->

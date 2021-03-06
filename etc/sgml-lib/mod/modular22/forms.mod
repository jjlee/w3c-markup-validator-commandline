<!-- ............................................................ -->
<!-- HTML DTD Forms Module ...................................... -->
<!-- File forms.mod ............................................. -->

<!ENTITY % forms.module.status %HTML.status; >
<!ENTITY % forms.module.expires %HTML.expires; >
<!ENTITY % forms.module.version 
        "-//IETF//ELEMENTS HTML V2.2 Forms//EN" >

<!ELEMENT FORM - - %body.content -(FORM) +(INPUT|SELECT|TEXTAREA)>
<!ATTLIST FORM
        %attrs;
        ACTION CDATA #IMPLIED
        METHOD (%HTTP-Method) GET
        ENCTYPE %Content-Type; "application/x-www-form-urlencoded"
        ACCEPT-CHARSET CDATA #IMPLIED
        %SDAPREF; "<Para>Form:</Para>"
        %SDASUFF; "<Para>Form End.</Para>"
        >

<!-- <FORM>                     Fill-out or data-entry form     -->
<!-- <FORM ACTION="...">        Address for completed form      -->
<!-- <FORM METHOD=...>          Method of submitting form       -->
<!-- <FORM ENCTYPE="...">       Representation of form data     -->

<!ENTITY % InputType "(TEXT | PASSWORD | CHECKBOX |
                        RADIO | SUBMIT | RESET |
                        IMAGE | HIDDEN | FILE )">
<!ELEMENT INPUT - O EMPTY>
<!ATTLIST INPUT
        %attrs;

        TYPE %InputType TEXT
        NAME CDATA #IMPLIED
        VALUE CDATA #IMPLIED
        SRC CDATA #IMPLIED
        CHECKED (CHECKED) #IMPLIED
        SIZE CDATA #IMPLIED
        MAXLENGTH NUMBER #IMPLIED
        ALIGN (top|middle|bottom) #IMPLIED
        ACCEPT CDATA #IMPLIED --list of content types --
        %SDAPREF; "Input: "
        >

<!-- <INPUT>                    Form input datum                -->
<!-- <INPUT TYPE=...>           Type of input interaction       -->
<!-- <INPUT NAME=...>           Name of form datum              -->
<!-- <INPUT VALUE="...">        Default/initial/selected value  -->
<!-- <INPUT SRC="...">          Address of image                -->
<!-- <INPUT CHECKED>            Initial state is "on"           -->
<!-- <INPUT SIZE=...>           Field size hint                 -->
<!-- <INPUT MAXLENGTH=...>      Data length maximum             -->
<!-- <INPUT ALIGN=...>          Image alignment                 -->

<!ELEMENT SELECT - - (OPTION+) -(INPUT|SELECT|TEXTAREA)>
<!ATTLIST SELECT
        %attrs;
        NAME CDATA #REQUIRED
        SIZE NUMBER #IMPLIED
        MULTIPLE (MULTIPLE) #IMPLIED
        %SDAFORM; "List"
        %SDAPREF;
        "<LHead>Select #AttVal(Multiple)</LHead>"
        >

<!-- <SELECT>                   Selection of option(s)          -->
<!-- <SELECT NAME=...>          Name of form datum              -->
<!-- <SELECT SIZE=...>          Options displayed at a time     -->
<!-- <SELECT MULTIPLE>          Multiple selections allowed     -->

<!ELEMENT OPTION - O (#PCDATA)*>
<!ATTLIST OPTION
        %attrs;
        SELECTED (SELECTED) #IMPLIED
        VALUE CDATA #IMPLIED
        %SDAFORM; "LItem"
        %SDAPREF;
        "Option: #AttVal(Value) #AttVal(Selected)"
        >

<!-- <OPTION>                   A selection option              -->
<!-- <OPTION SELECTED>          Initial state                   -->
<!-- <OPTION VALUE="...">       Form datum value for this option-->

<!ELEMENT TEXTAREA - - (#PCDATA)* -(INPUT|SELECT|TEXTAREA)>
<!ATTLIST TEXTAREA
        %attrs;
        NAME CDATA #REQUIRED
        ROWS NUMBER #REQUIRED
        COLS NUMBER #REQUIRED
        %SDAFORM; "Para"
        %SDAPREF; "Input Text -- #AttVal(Name): "
        >

<!-- <TEXTAREA>            An area for text input -->
<!-- <TEXTAREA NAME=...>   Name of form datum     -->
<!-- <TEXTAREA ROWS=...>   Height of area         -->
<!-- <TEXTAREA COLS=...>   Width of area          -->

<!-- End of forms.module -->

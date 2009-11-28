<!entity % if-layout "INCLUDE">

<!entity % style.attrs "
	style CDATA #IMPLIED
	"
	-- notation is taken from STYLE element  @@see style draft --
	>

<!entity % length "CDATA" --@@ change to numtoken, make % a name char? -->

<!entity % image-align.attrs "
        ALIGN (top|middle|bottom|left|right) #IMPLIED
	border NUMBER #IMPLIED
	height %length #IMPLIED
	width %length #IMPLIED
	HSPACE %length #IMPLIED
	VSPACE %length #IMPLIED
	">

<!ENTITY % just -- an attribute for text justification --
         "ALIGN  (left|right|center|justify)  #IMPLIED">

<!entity % hr-align-attrs "
	%just;
	SIZE %length #IMPLIED
	">

<!element center - - ANY -- @@ deprecated: use DIV align=center or P align=center-->


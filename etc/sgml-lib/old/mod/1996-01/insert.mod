<!-- $Id: insert.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->

<!-- Feature Test Entities -->
<!ENTITY % if-insert "INCLUDE">
<!ENTITY % no-insert "IGNORE">


<!entity % params "(param|alias)*">

<!element insert - - (%params, body)>

<!entity % oop.attrs
"	data %URI #IMPLIED
	code %URI #IMPLIED
	classid %URI #IMPLIED"
	>

<!entity % advisory "#IMPLIED"
	-- optional, and not authoratative
	e.g. @@blah blah blah
	-->


<!entity % ismap.attrs "
	ISMAP (ISMAP) #IMPLIED
	">

<!entity % usemap.attrs "
	USEMAP %URI #IMPLIED
	">

<!attlist insert
	type %Content-Type %advisory
	%attrs;
	%oop.attrs;
	%image-align.attrs;
	%ismap.attrs;
	%usemap.attrs;
	>


<!element param - O EMPTY>
<!attlist param
	name CDATA #REQUIRED -- names may be case sensitive in some systems --
	value CDATA #IMPLIED
	valueref %URI #IMPLIED
		-- generally, one of value and valueref should
			be supplied --
	>


<!element alias - - (%params)>

<!attlist alias
	%id-class.attrs
	%oop.attrs
	>


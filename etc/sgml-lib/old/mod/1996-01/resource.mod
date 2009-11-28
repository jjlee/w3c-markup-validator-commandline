<!-- $Id: resource.mod,v 1.1.1.1 2004/09/19 12:34:08 ralph Exp $ -->

<!ELEMENT RESOURCE - -  (title?, (link | meta | resource)*)>
	<!-- @@ do we really want the title as an element? Why not an attribute? -->
	<!-- @@ danger of reusing link, meta elements in unexpected contexts? -->
	<!-- more short-hand attributes? -->
<!ATTLIST RESOURCE
	HREF	%URI	#REQUIRED
	%attrs;
	>

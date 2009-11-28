<!-- ............................................................ -->
<!-- HTML DTD Document Head Module .............................. -->
<!-- File head.mod .............................................. -->

<!ENTITY % head.module.status %HTML.status; >
<!ENTITY % head.module.expires %HTML.expires; >
<!ENTITY % head.module.version 
        "-//IETF//ELEMENTS HTML V2.2 Document Head//EN" >

<![ %HTML.Recommended [
        <!ENTITY % head.extra "">
]]>
<!ENTITY % head.extra "& NEXTID?">

<!ENTITY % head.content "TITLE & ISINDEX? & BASE? %head.extra">

<!ELEMENT HEAD O O  (%head.content) +(META|LINK)>
<!ATTLIST HEAD
        %attrs;           >

<!-- <HEAD>     Document head   -->

<!ELEMENT TITLE - -  (#PCDATA)* -(META|LINK)>
<!ATTLIST TITLE
        %attrs;
        %SDAFORM; "Ti"    >

<!-- <TITLE>    Title of document -->

<!ELEMENT LINK - O EMPTY>
<!ATTLIST LINK
        %attrs;
        HREF CDATA #REQUIRED
        %linkExtraAttributes;
        %SDAPREF; "Linked to : #AttVal (TITLE) (URN) (HREF)>"    >

<!-- <LINK>             Link from this document                 -->
<!-- <LINK HREF="...">  Address of link destination             -->
<!-- <LINK URN="...">   Lasting name of destination             -->
<!-- <LINK REL=...>     Relationship to destination             -->
<!-- <LINK REV=...>     Relationship of destination to this     -->
<!-- <LINK TITLE="..."> Title of destination (advisory)         -->
<!-- <LINK CHARSET="..."> Charset of destination (advisory)     -->
<!-- <LINK METHODS="..."> Operations allowed (advisory)         -->

<!ELEMENT ISINDEX - O EMPTY>
<!ATTLIST ISINDEX
        %attrs;
        %SDAPREF;
   "<Para>[Document is indexed/searchable.]</Para>">

<!-- <ISINDEX>          Document is a searchable index          -->

<!ELEMENT BASE - O EMPTY>
<!ATTLIST BASE
        HREF CDATA #REQUIRED     >

<!-- <BASE>             Base context document                   -->
<!-- <BASE HREF="...">  Address for this document               -->

<!ELEMENT NEXTID - O EMPTY>
<!ATTLIST NEXTID
        N CDATA #REQUIRED     >

<!-- <NEXTID>           Next ID to use for link name            -->
<!-- <NEXTID N=...>     Next ID to use for link name            -->

<!ELEMENT META - O EMPTY>
<!ATTLIST META
        HTTP-EQUIV  NAME    #IMPLIED
        NAME        NAME    #IMPLIED
        CONTENT     CDATA   #REQUIRED
        >

<!-- <META>                     Generic Meta-information        -->
<!-- <META HTTP-EQUIV=...>      HTTP response header name       -->
<!-- <META NAME=...>            Meta-information name           -->
<!-- <META CONTENT="...">       Associated information          -->

<!-- End of head.module -->

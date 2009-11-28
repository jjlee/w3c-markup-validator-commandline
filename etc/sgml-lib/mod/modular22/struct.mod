<!-- ............................................................ -->
<!-- HTML DTD Document Structure Module ......................... -->
<!-- File struct.mod ............................................ -->

<!ENTITY % structure.module.status %HTML.status; >
<!ENTITY % structure.module.expires %HTML.expires; >
<!ENTITY % structure.module.version 
        "-//IETF//ELEMENTS HTML V2.2 Document Structure//EN" >

<!ELEMENT HTML O O "HEAD, BODY" >
<!ENTITY % version.attr "VERSION CDATA #FIXED '%HTML.Version;'">

<!ATTLIST HTML
        %attrs;
        %version.attr;
        %SDAFORM; "Book"
        >

<!-- <HTML>                     HTML Document   -->

<!-- End of struct.module -->

<!-- ............................................................ -->
<!-- HTML DTD General Entities Module ........................... -->
<!-- File genent.mod ............................................ -->

<!ENTITY % genent.module.status %HTML.status; >
<!ENTITY % genent.module.expires %HTML.expires; >
<!ENTITY % genent.module.version 
        "-//IETF//ELEMENTS HTML V2.2 General Entities//EN" >

<!-- Imported Names ................................... -->

<!ENTITY % Content-Type "CDATA"
        -- meaning an internet media type
           (aka MIME content type, as per RFC1521)
        -->

<!ENTITY % HTTP-Method "GET | POST"
        -- as per HTTP specification, in progress
        -->

<!-- DTD "Macros" ..................................... -->

<!ENTITY % heading " H1 | H2 | H3 | H4 | H5 | H6 ">

<!ENTITY % list " UL | OL | DIR | MENU " >

<!ENTITY % attrs -- common attributes for elements --
         "LANG  NAME      #IMPLIED  -- RFC 1766 language tag    --
          DIR  (ltr|rtl)  #IMPLIED  -- text directionality      --
          ID      ID      #IMPLIED  -- element identifier       --
          CLASS   NAMES   #IMPLIED  -- for subclassing elements --">

<!ENTITY % just -- an attribute for text justification --
         "ALIGN  (left|right|center|justify)  #IMPLIED">

<!-- End of genent.module -->

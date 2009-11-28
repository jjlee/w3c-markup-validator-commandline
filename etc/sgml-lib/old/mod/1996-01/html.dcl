   <!SGML  "ISO 8879:1986"
   --
           SGML Declaration for HyperText Markup Language
   --

   CHARSET
            BASESET  "ISO Registration Number 176//CHARSET
                      ISO/IEC 10646-1:1993 UCS-2 with
                      implementation level 3//ESC 2/5 2/15 4/5"
            DESCSET  0   9     UNUSED
                     9   2     9
                     11  2     UNUSED
                     13  1     13
                     14  18    UNUSED
                     32  95    32
                     127 1     UNUSED
                     128 32    UNUSED
                     160 65376 160

   CAPACITY        SGMLREF
                   TOTALCAP        150000
                   GRPCAP          150000
                   ENTCAP          150000

   SCOPE    DOCUMENT
   SYNTAX

            SHUNCHAR CONTROLS 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
                    17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 127
            BASESET  "ISO 646:1983//CHARSET
                      International Reference Version
                      (IRV)//ESC 2/5 4/0"
            DESCSET  0 128 0

            FUNCTION
                     RE            13
                     RS            10
                     SPACE         32
                     TAB SEPCHAR    9

            NAMING   LCNMSTRT ""
                     UCNMSTRT ""
                     LCNMCHAR ".-"
                     UCNMCHAR ".-"
                     NAMECASE GENERAL YES
                              ENTITY  NO
            DELIM    GENERAL  SGMLREF
                     SHORTREF SGMLREF
            NAMES    SGMLREF
            QUANTITY SGMLREF
                     ATTSPLEN 999999
                     LITLEN   999999
                     NAMELEN  72    -- somewhat arbitrary; taken from
                                   internet line length conventions --
                     PILEN    999999
                     TAGLVL   100
                     TAGLEN   999999
                     GRPGTCNT 150
                     GRPCNT   64

   FEATURES
     MINIMIZE
       DATATAG  NO
       OMITTAG  YES
       RANK     NO
       SHORTTAG YES
     LINK
       SIMPLE   NO
       IMPLICIT NO
       EXPLICIT NO
     OTHER
       CONCUR   NO
       SUBDOC   NO
       FORMAL   YES
     APPINFO    "SDA"  -- conforming SGML Document Access application

                       --
   >

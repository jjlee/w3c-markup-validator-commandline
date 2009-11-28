<!-- ............................................................ -->
<!-- HTML DTD Tables Module ..................................... -->
<!-- File tables.mod ............................................ -->

<!ENTITY % tables.module.status "Internet-Draft" >
<!ENTITY % tables.module.expires "22-Jun-1996" >
<!ENTITY % tables.module.version 
        "-//W3C//ELEMENTS HTML V2.0-Based Extension Tables V0.3//EN" >

<!--    [W3C] WD-table-951222

        The HTML3 Table Model:  W3C Working Draft 22-Dec-95

        This version: http://www.w3.org/pub/WWW/TR/WD-table-951222.html
        Latest version:  http://www.w3.org/pub/WWW/TR/WD-table.html
        Editor:  Dave Raggett <dsr@w3.org>
-->

<!--    Content model entities imported from parent DTD:

        %body.content; allows table cells to contain headers, paras,
        lists, form elements and even arbitrarily nested tables.

        %text; is text characters, including character entities and
        character emphasis elements, IMG and anchors
-->

<!ENTITY % attrs
       "id      ID       #IMPLIED  -- element identifier --
        class   NAMES    #IMPLIED  -- for subclassing elements --
        style   CDATA    #IMPLIED  -- rendering annotation --
        lang    NAME     #IMPLIED  -- as per RFC 1766 --
        dir   (ltr|rtl)  #IMPLIED  -- I18N text direction --">

<!--
        The BORDER attribute sets the thickness of the frame around the
        table. The default units are screen pixels.

        The FRAME attribute specifies which parts of the frame around
        the table should be rendered. The values are not the same as
        CALS to avoid a name clash with the VALIGN attribute.

        The value "border" is included for backwards compatibility with
        <TABLE BORDER> which yields frame=border and border=implied For
        <TABLE BORDER=1> you get border=1 and frame=implied. In this
        case, its appropriate to treat this as frame=border for
        backwards compatibility with deployed browsers.
-->

<!ENTITY % Frame "(void|above|below|hsides|lhs|rhs|vsides|box|border)">

<!--
        The RULES attribute defines which rules to draw between cells:

        If RULES is absent then assume:
        "none" if BORDER is absent or BORDER=0 otherwise "all"
-->

<!ENTITY % Rules "(none | groups | rows | cols | all)">

<!-- horizontal placement of table relative to window -->

<!ENTITY % Where "(left|center|right)">

<!-- horizontal alignment attributes for cell contents -->

<!ENTITY % cell.halign
        "align  (left|center|right|justify|char) #IMPLIED
         char    CDATA   #IMPLIED -- alignment char, e.g. char=':' --
         charoff CDATA   #IMPLIED -- offset for alignment char --"
        >

<!-- vertical alignment attributes for cell contents -->

<!ENTITY % cell.valign
        "valign  (top|middle|bottom|baseline)  #IMPLIED"
        >

<!ELEMENT table - - (caption?, colgroup*, thead?, tfoot?, tbody+)>
<!ELEMENT caption - - (%text;)+>
<!ELEMENT thead - O (tr+)>
<!ELEMENT tfoot - O (tr+)>
<!ELEMENT tbody O O (tr+)>
<!ELEMENT colgroup - O (col*)>
<!ELEMENT col - O EMPTY>
<!ELEMENT tr - O (th|td)+>
<!ELEMENT (th|td) - O %body.content>

<!ATTLIST table                    -- table element --
        %attrs;                    -- id, lang, style, dir and class --
        align   %Where;  #IMPLIED  -- table position relative to window --
        width   CDATA    #IMPLIED  -- table width relative to window --
        cols    NUMBER   #IMPLIED  -- used for immediate display mode --
        border  CDATA    #IMPLIED  -- controls frame width around table --
        frame   %Frame;  #IMPLIED  -- which parts of table frame to include --
        rules   %Rules;  #IMPLIED  -- rulings between rows and cols --
        cellspacing CDATA #IMPLIED -- spacing between cells --
        cellpadding CDATA #IMPLIED -- spacing within cells --
        >

<!-- ALIGN is used here for compatibility with deployed browsers -->

<!ENTITY % Caption "(top|bottom|left|right)">

<!ATTLIST caption                  -- table caption --
        %attrs;                    -- id, lang, style, dir and class --
        align  %Caption; #IMPLIED  -- relative to table --
        >

<!--
        COLGROUP groups a set of COL elements. It allows you to group
        several columns together.
-->

<!ATTLIST colgroup
        %attrs;                    -- id, lang, style, dir and class --
        span    NUMBER   1         -- default number of columns in group --
        width   CDATA    #IMPLIED  -- default width for enclosed COLs --
        %cell.halign;              -- horizontal alignment in cells --
        %cell.valign;              -- vertical alignment in cells --
        >

<!--
        COL elements define the alignment properties for cells in a
        given column or spanned columns. The WIDTH attribute specifies
        the width of the columns, e.g.

            width=64        width in screen pixels
            width=0.5*      relative width of 0.5
-->

<!ATTLIST col                      -- column groups and properties --
        %attrs;                    -- id, lang, style, dir and class --
        span    NUMBER   1         -- number of columns spanned by group --
        width   CDATA    #IMPLIED  -- column width specification --
        %cell.halign;              -- horizontal alignment in cells --
        %cell.valign;              -- vertical alignment in cells --
        >

<!--
        Use THEAD to duplicate headers when breaking table
        across page boundaries, or for static headers when
        body sections are rendered in scrolling panel.

        Use TFOOT to duplicate footers when breaking table
        across page boundaries, or for static footers when
        body sections are rendered in scrolling panel.

        Use multiple TBODY sections when rules are needed
        between groups of table rows.
-->

<!ATTLIST (thead|tbody|tfoot)      -- table section --
        %attrs;                    -- id, lang, style, dir and class --
        %cell.halign;              -- horizontal alignment in cells --
        %cell.valign;              -- vertical alignment in cells --
        >

<!ATTLIST tr                       -- table row --
        %attrs;                    -- id, lang, style, dir and class --
        %cell.halign;              -- horizontal alignment in cells --
        %cell.valign;              -- vertical alignment in cells --
        >

<!ATTLIST (th|td)                  -- header or data cell --
        %attrs;                    -- id, lang, style, dir and class --
        axis    CDATA    #IMPLIED  -- defaults to cell content --
        axes    CDATA    #IMPLIED  -- list of axis names --
        nowrap (nowrap)  #IMPLIED  -- suppress word wrap --
        rowspan NUMBER   1         -- number of rows spanned by cell --
        colspan NUMBER   1         -- number of cols spanned by cell --
        %cell.halign;              -- horizontal alignment in cells --
        %cell.valign;              -- vertical alignment in cells --
        >

<!-- End of tables.module -->


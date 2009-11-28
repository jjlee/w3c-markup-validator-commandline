<!-- ...................................................................... -->
<!-- SMIL 2.0 Common Attributes Module  ................................... -->
<!-- file: smil-attribs-1.mod

     This is SMIL 2.0.
     Copyright 2000 W3C (MIT, INRIA, Keio), All Rights Reserved.
     Revision: $Id: smil-attribs-1.mod,v 1.1.1.1 2004/09/19 12:34:07 ralph Exp $

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ENTITIES SMIL 2.0 Common Attributes 1.0//EN"
     SYSTEM "smil-attribs-1.mod"

     ...................................................................... -->

<!-- Common Attributes

     This module declares the common attributes for the SMIL DTD Modules.
-->

<!ENTITY % SMIL.pfx "">

<!ENTITY % Id.attrib
 "%SMIL.pfx;id           ID                       #IMPLIED"
>

<!ENTITY % Class.attrib
 "%SMIL.pfx;class        CDATA                    #IMPLIED"
>

<!ENTITY % Title.attrib
 "%SMIL.pfx;title        %Text.datatype;                   #IMPLIED"
>

<!ENTITY % Longdesc.attrib
 "%SMIL.pfx;longdesc     %URI.datatype;                    #IMPLIED"
>

<!ENTITY % Alt.attrib
 "%SMIL.pfx;alt          %Text.datatype;                   #IMPLIED"
>

<!ENTITY % Accessibility.attrib "
 %Longdesc.attrib;
 %Alt.attrib;
">

<!ENTITY % Core.extra.attrib "" >
<!ENTITY % Core.attrib "
  xml:base %URI.datatype; #IMPLIED
  %Id.attrib;
  %Class.attrib;
  %Title.attrib;
  %Accessibility.attrib;
  %Core.extra.attrib;
">

<!ENTITY % I18n.extra.attrib "" >
<!ENTITY % I18n.attrib "
  xml:lang %LanguageCode.datatype; #IMPLIED
  %I18n.extra.attrib;"
>

<!ENTITY % Description.attrib "
 %SMIL.pfx;abstract        %Text.datatype;   #IMPLIED
 %SMIL.pfx;author          %Text.datatype;   #IMPLIED
 %SMIL.pfx;copyright       %Text.datatype;   #IMPLIED
">

<!ENTITY % Tabindex.attrib "
 %SMIL.pfx;tabindex        %Number.datatype;   #IMPLIED
">

<!-- ================== BasicLayout ======================================= -->
<!ENTITY % Region.attrib "
 %SMIL.pfx;region         CDATA #IMPLIED
">

<!ENTITY % Fill.attrib "
 %SMIL.pfx;fill (remove|freeze|hold|transition|auto|default) 'default'
">

<!ENTITY % FillDefault.attrib "
 %SMIL.pfx;fillDefault (remove|freeze|hold|transition|auto|inherit) 'inherit'
">

<!-- ================== HierarchicalLayout ================================ -->
<!ENTITY % BackgroundColor.attrib "
 %SMIL.pfx;backgroundColor     CDATA    #IMPLIED
">
<!ENTITY % BackgroundColor-deprecated.attrib "
 %SMIL.pfx;background-color     CDATA    #IMPLIED
">

<!ENTITY % Sub-region.attrib "
 %SMIL.pfx;top     CDATA    'auto'
 %SMIL.pfx;bottom  CDATA    'auto'
 %SMIL.pfx;left    CDATA    'auto'
 %SMIL.pfx;right   CDATA    'auto'
 %SMIL.pfx;height  CDATA    'auto'
 %SMIL.pfx;width   CDATA    'auto'
 %SMIL.pfx;z-index CDATA    #IMPLIED
">

<!ENTITY % Fit.attrib "
 %SMIL.pfx;fit            (hidden|fill|meet|scroll|slice)   #IMPLIED 
">

<!-- ================ Registration Point attribute for media elements ============ -->
<!-- integrating language using HierarchicalLayout must include regPoint   -->
<!-- attribute on media elements for regPoint elements to be useful        -->

<!ENTITY % RegPoint.attrib "
 %SMIL.pfx;regPoint  CDATA    #IMPLIED
">

<!ENTITY % RegAlign.attrib "
 %SMIL.pfx;regAlign  (topLeft|topMid|topRight|midLeft|center|
                     midRight|bottomLeft|bottomMid|bottomRight) #IMPLIED
">

<!ENTITY % RegistrationPoint.attrib "
 %RegPoint.attrib;
 %RegAlign.attrib;
">

<!--=================== Content Control =======================-->
<!-- customTest Attribute -->
<!ENTITY % CustomTest.attrib "
        %SMIL.pfx;customTest              IDREF           #IMPLIED
">

<!-- ========================= SkipContentControl Module ========================= -->
<!ENTITY % SkipContent.attrib "
	%SMIL.pfx;skip-content		(true|false)	'true'
">

<!-- Content Control Test Attributes --> 

<!ENTITY % Test.attrib "
        %SMIL.pfx;systemBitrate                	CDATA		#IMPLIED
	%SMIL.pfx;systemCaptions		(on|off)	#IMPLIED
	%SMIL.pfx;systemLanguage		CDATA		#IMPLIED
	%SMIL.pfx;systemOverdubOrSubtitle	(overdub|subtitle) #IMPLIED
	%SMIL.pfx;systemRequired		CDATA		#IMPLIED
	%SMIL.pfx;systemScreenSize		CDATA		#IMPLIED
	%SMIL.pfx;systemScreenDepth		CDATA		#IMPLIED
	%SMIL.pfx;systemAudioDesc		(on|off)	#IMPLIED
	%SMIL.pfx;systemOperatingSystem		NMTOKEN		#IMPLIED
	%SMIL.pfx;systemCPU			NMTOKEN		#IMPLIED
	%SMIL.pfx;systemComponent		CDATA		#IMPLIED

	%SMIL.pfx;system-bitrate		CDATA		#IMPLIED
	%SMIL.pfx;system-captions		(on|off)	#IMPLIED
	%SMIL.pfx;system-language		CDATA		#IMPLIED
	%SMIL.pfx;system-overdub-or-caption	(overdub|caption) #IMPLIED
	%SMIL.pfx;system-required		CDATA		#IMPLIED
	%SMIL.pfx;system-screen-size		CDATA		#IMPLIED
	%SMIL.pfx;system-screen-depth		CDATA		#IMPLIED
">

<!-- SMIL Animation Module  ================================================ -->
<!ENTITY % BasicAnimation.attrib "
  %SMIL.pfx;values     CDATA #IMPLIED
  %SMIL.pfx;from       CDATA #IMPLIED
  %SMIL.pfx;to         CDATA #IMPLIED
  %SMIL.pfx;by         CDATA #IMPLIED
">

<!-- SMIL Timing Module  =================================================== -->
<!ENTITY % BasicInlineTiming.attrib "
  %SMIL.pfx;dur                       %TimeValue.datatype; #IMPLIED
  %SMIL.pfx;repeatCount               %TimeValue.datatype; #IMPLIED
  %SMIL.pfx;repeatDur                 %TimeValue.datatype; #IMPLIED
  %SMIL.pfx;begin                     %TimeValue.datatype; #IMPLIED
  %SMIL.pfx;end                       %TimeValue.datatype; #IMPLIED
">

<!ENTITY % MinMaxTiming.attrib "
  %SMIL.pfx;min                       %TimeValue.datatype; '0'
  %SMIL.pfx;max                       %TimeValue.datatype; 'indefinite'
">

<!ENTITY % BasicInlineTiming-deprecated.attrib "
  %SMIL.pfx;repeat                   %TimeValue.datatype; #IMPLIED
">

<!ENTITY % Endsync.attrib "
  %SMIL.pfx;endsync               CDATA 'last'
">

<!-- endsync has a different default when applied to media elements -->
<!ENTITY % Endsync.media.attrib "
  %SMIL.pfx;endsync               CDATA 'media'
">

<!ENTITY % TimeContainerAttributes.attrib "
  %SMIL.pfx;timeAction            CDATA #IMPLIED
  %SMIL.pfx;timeContainer         CDATA #IMPLIED
">

<!ENTITY % RestartTiming.attrib "
  %SMIL.pfx;restart (always|whenNotActive|never|default) 'default'
">

<!ENTITY % RestartDefaultTiming.attrib "
  %SMIL.pfx;restartDefault (inherit|always|never|whenNotActive) 'inherit'
">

<!ENTITY % SyncBehavior.attrib "
  %SMIL.pfx;syncBehavior (canSlip|locked|independent|default) 'default'
  %SMIL.pfx;syncTolerance %TimeValue.datatype;                'default'
">

<!ENTITY % SyncBehaviorDefault.attrib "
  %SMIL.pfx;syncBehaviorDefault (canSlip|locked|independent|inherit) 'inherit'
  %SMIL.pfx;syncToleranceDefault  %TimeValue.datatype;               'inherit'
">

<!ENTITY % SyncMaster.attrib "
  %SMIL.pfx;syncMaster    (true|false)                 'false'
">

<!-- ================== Time Manipulations ================================= -->
<!ENTITY % TimeManipulations.attrib "
  %SMIL.pfx;accelerate		%Number.datatype; '0'
  %SMIL.pfx;decelerate		%Number.datatype; '0'
  %SMIL.pfx;speed		%Number.datatype; '1.0'
  %SMIL.pfx;autoReverse         (true|false)      'false'
">

<!-- ================== Media Objects ====================================== -->
<!ENTITY % MediaClip.attrib "
  %SMIL.pfx;clipBegin      CDATA   #IMPLIED
  %SMIL.pfx;clipEnd        CDATA   #IMPLIED
">
<!ENTITY % MediaClip.attrib.deprecated "
  %SMIL.pfx;clip-begin     CDATA   #IMPLIED
  %SMIL.pfx;clip-end       CDATA   #IMPLIED
">

<!-- ================== Streaming Media ==================================== -->
<!ENTITY % Streaming-media.attrib "
  %SMIL.pfx;port                  CDATA   #IMPLIED
  %SMIL.pfx;rtpformat             CDATA   #IMPLIED
  %SMIL.pfx;transport             CDATA   #IMPLIED
">

<!ENTITY % Streaming-timecontainer.attrib "
  %SMIL.pfx;control               CDATA   #IMPLIED
">

<!-- ================== Transitions Media ================================== -->
<!ENTITY % Transition.attrib "
 %SMIL.pfx;transIn                CDATA        #IMPLIED
 %SMIL.pfx;transOut               CDATA        #IMPLIED
">

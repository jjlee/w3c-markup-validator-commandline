<!-- ======================================================================  -->
<!-- SMIL 2.0 Document Model Module =======================================  -->
<!-- file: smil-model-1.mod

     This is SMIL 2.0.
     Copyright 1998-2000 W3C (MIT, INRIA, Keio), All Rights Reserved.

     This DTD module is identified by the PUBLIC and SYSTEM identifiers:

     PUBLIC "-//W3C//ENTITIES SMIL 2.0 Document Model 1.0//EN"
     SYSTEM "smil-model-1.mod"

     Author: Warner ten Kate, Jacco van Ossenbruggen, Aaron Cohen
     Revision: $Id: smil-model-1.mod,v 1.1.1.1 2004/09/19 12:34:07 ralph Exp $
     ======================================================================= -->

<!--
        This file defines the SMIL 2.0 Language Document Model.
        All attributes and content models are defined in the second
        half of this file.  We first start with some utility definitions.
        These are mainly used to simplify the use of Modules in the
        second part of the file.

-->

<!-- ================== Util: Head ========================================= -->
<!ENTITY % head-meta.content       "metadata">
<!ENTITY % head-layout.content     "layout|switch">
<!ENTITY % head-control.content    "customAttributes">
<!ENTITY % head-transition.content "transition+">

<!--=================== Util: Body - Content Control ======================= -->
<!ENTITY % content-control "switch|prefetch">
<!ENTITY % content-control-attrs "%Test.attrib; %CustomTest.attrib; %SkipContent.attrib;">

<!--=================== Util: Body - Animation ========================= -->
<!ENTITY % animation.elements "animate|set|animateMotion|animateColor">

<!--=================== Util: Body - Media ========================= -->

<!ENTITY % media-object "audio|video|animation|text|img|textstream|ref|brush
                               |%animation.elements;">

<!--=================== Util: Body - Timing ================================ -->
<!ENTITY % BasicTimeContainers.class "par|seq">
<!ENTITY % ExclTimeContainers.class "excl">
<!ENTITY % timecontainer.class
 "%BasicTimeContainers.class;|%ExclTimeContainers.class;">
<!ENTITY % timecontainer.content
 "%timecontainer.class;|%media-object;|%content-control;|a">

<!ENTITY % smil-basictime.attrib "
 %BasicInlineTiming.attrib;
 %BasicInlineTiming-deprecated.attrib;
 %MinMaxTiming.attrib;
">

<!ENTITY % timecontainer.attrib "
 %BasicInlineTiming.attrib;
 %BasicInlineTiming-deprecated.attrib;
 %MinMaxTiming.attrib;
 %RestartTiming.attrib;
 %RestartDefaultTiming.attrib;
 %SyncBehavior.attrib;
 %SyncBehaviorDefault.attrib;
 %FillDefault.attrib;
">

<!-- ====================================================================== -->
<!-- ====================================================================== -->
<!-- ====================================================================== -->

<!-- 
     The actual content model and attribute definitions for each module 
     sections follow below.
-->

<!-- ================== Content Control =================================== -->
<!ENTITY % BasicContentControl.module  "INCLUDE">
<!ENTITY % CustomTestAttributes.module "INCLUDE">
<!ENTITY % PrefetchControl.module      "INCLUDE">
<!ENTITY % SkipContentControl.module   "INCLUDE">

<!ENTITY % switch.content "((%timecontainer.class;|%media-object;|
		           %content-control;|a|area|anchor)*|layout*)">

<!ENTITY % switch.attrib            "%Test.attrib; %CustomTest.attrib;">
<!ENTITY % prefetch.attrib "
 %timecontainer.attrib; 
 %MediaClip.attrib; 
 %MediaClip.attrib.deprecated; 
 %Test.attrib; 
 %CustomTest.attrib; 
 %SkipContent.attrib; 
">

<!ENTITY % customAttributes.attrib  "%Test.attrib; %SkipContent.attrib;">
<!ENTITY % customTest.attrib        "%SkipContent.attrib;">

<!-- ================== Animation ========================================= -->
<!ENTITY % BasicAnimation.module "INCLUDE">

<!-- choose targetElement or XLink: -->
<!ENTITY % animation-targetElement "INCLUDE">
<!ENTITY % animation-XLinkTarget   "IGNORE">

<!ENTITY % animate.content "EMPTY">
<!ENTITY % animateColor.content "EMPTY">
<!ENTITY % animateMotion.content "EMPTY">
<!ENTITY % set.content "EMPTY">

<!ENTITY % animate.attrib        "%SkipContent.attrib; %CustomTest.attrib;">
<!ENTITY % animateColor.attrib   "%SkipContent.attrib; %CustomTest.attrib;">
<!ENTITY % animateMotion.attrib  "%SkipContent.attrib; %CustomTest.attrib;">
<!ENTITY % set.attrib            "%SkipContent.attrib; %CustomTest.attrib;">

<!-- ================== Layout ============================================ -->
<!ENTITY % BasicLayout.module        "INCLUDE">
<!ENTITY % AudioLayout.module        "INCLUDE">
<!ENTITY % MultiWindowLayout.module  "INCLUDE">
<!ENTITY % HierarchicalLayout.module "INCLUDE">

<!ENTITY % layout.content "(region|topLayout|root-layout|regPoint)*">
<!ENTITY % region.content "(region)*">
<!ENTITY % topLayout.content "(region)*">
<!ENTITY % rootlayout.content "EMPTY">
<!ENTITY % regPoint.content "EMPTY">

<!ENTITY % layout.attrib          "%Test.attrib; %CustomTest.attrib;">
<!ENTITY % rootlayout.attrib      "%content-control-attrs;">
<!ENTITY % topLayout.attrib       "%content-control-attrs;">
<!ENTITY % region.attrib          "%content-control-attrs;">
<!ENTITY % regPoint.attrib        "%content-control-attrs;">

<!-- ================== Linking =========================================== -->
<!ENTITY % LinkingAttributes.module "INCLUDE">
<!ENTITY % BasicLinking.module      "INCLUDE">
<!ENTITY % ObjectLinking.module   "INCLUDE">

<!ENTITY % a.content      "(%timecontainer.class;|%media-object;|
                            %content-control;)*">
<!ENTITY % area.content	  "(animate|set)*">
<!ENTITY % anchor.content "(animate|set)*">

<!ENTITY % a.attrib      "%smil-basictime.attrib; %Test.attrib; %CustomTest.attrib;">
<!ENTITY % area.attrib   "%smil-basictime.attrib; %content-control-attrs;"> 
<!ENTITY % anchor.attrib "%smil-basictime.attrib; %content-control-attrs;"> 

<!-- ================== Media  ============================================ -->
<!ENTITY % BasicMedia.module                     "INCLUDE">
<!ENTITY % MediaClipping.module                  "INCLUDE">
<!ENTITY % MediaClipping.deprecated.module       "INCLUDE">
<!ENTITY % MediaClipMarkers.module               "INCLUDE">
<!ENTITY % MediaParam.module                     "INCLUDE">
<!ENTITY % BrushMedia.module                     "INCLUDE">
<!ENTITY % MediaAccessibility.module             "INCLUDE">

<!ENTITY % media-object.content "(%animation.elements;|switch|anchor|area
                                  |param)*">
<!ENTITY % media-object.attrib "
  %BasicInlineTiming.attrib;
  %BasicInlineTiming-deprecated.attrib;
  %MinMaxTiming.attrib;
  %RestartTiming.attrib;
  %RestartDefaultTiming.attrib;
  %SyncBehavior.attrib;
  %SyncBehaviorDefault.attrib;
  %Endsync.media.attrib;
  %Fill.attrib;
  %FillDefault.attrib;
  %Test.attrib;
  %CustomTest.attrib;
  %Region.attrib;
  %Transition.attrib;
  %BackgroundColor.attrib;
  %BackgroundColor-deprecated.attrib;
  %Sub-region.attrib;
  %RegistrationPoint.attrib;
  %Fit.attrib;
  %Tabindex.attrib;
">

<!ENTITY % brush.attrib        "%SkipContent.attrib;">
<!ENTITY % param.attrib        "%content-control-attrs;">

<!-- ================== Metadata ========================================== -->
<!ENTITY % meta.content     "EMPTY">
<!ENTITY % meta.attrib      "%SkipContent.attrib;">

<!ENTITY % metadata.content "EMPTY">
<!ENTITY % metadata.attrib  "%SkipContent.attrib;">

<!-- ================== Structure ========================================= -->
<!ENTITY % Structure.module "INCLUDE">
<!ENTITY % smil.content "(head?,body?)">
<!ENTITY % head.content "(
	 meta*,
	 ((%head-control.content;),   meta*)?,
	 ((%head-meta.content;),      meta*)?,
	 ((%head-layout.content;),    meta*)?,
	 ((%head-transition.content;),meta*)?
)">
<!ENTITY % body.content "(%timecontainer.class;|%media-object;|
                          %content-control;|a)*">

<!ENTITY % smil.attrib "%Test.attrib;">
<!ENTITY % body.attrib "
	%timecontainer.attrib; 
	%Description.attrib;
	%Fill.attrib;
">

<!-- ================== Transitions ======================================= -->
<!ENTITY % BasicTransitions.module        "INCLUDE">
<!ENTITY % TransitionModifiers.module     "INCLUDE">
<!ENTITY % InlineTransitions.module       "IGNORE">

<!ENTITY % transition.content "EMPTY">
<!ENTITY % transition.attrib "%content-control-attrs;">

<!-- ================== Timing ============================================ -->
<!ENTITY % BasicInlineTiming.module      "INCLUDE">
<!ENTITY % SyncbaseTiming.module         "INCLUDE">
<!ENTITY % EventTiming.module            "INCLUDE">
<!ENTITY % WallclockTiming.module        "INCLUDE">
<!ENTITY % MultiSyncArcTiming.module     "INCLUDE">
<!ENTITY % MediaMarkerTiming.module      "INCLUDE">
<!ENTITY % MinMaxTiming.module           "INCLUDE">
<!ENTITY % BasicTimeContainers.module    "INCLUDE">
<!ENTITY % ExclTimeContainers.module     "INCLUDE">
<!ENTITY % PrevTiming.module             "INCLUDE">
<!ENTITY % RestartTiming.module          "INCLUDE">
<!ENTITY % SyncBehavior.module           "INCLUDE">
<!ENTITY % SyncBehaviorDefault.module    "INCLUDE">
<!ENTITY % RestartDefault.module         "INCLUDE">
<!ENTITY % FillDefault.module            "INCLUDE">

<!ENTITY % par.attrib "
	%Endsync.attrib; 
        %Fill.attrib;
	%timecontainer.attrib; 
	%Test.attrib; 
	%CustomTest.attrib; 
	%Region.attrib;
">
<!ENTITY % seq.attrib "
        %Fill.attrib;
	%timecontainer.attrib; 
	%Test.attrib; 
	%CustomTest.attrib; 
	%Region.attrib;
">
<!ENTITY % excl.attrib "
	%Endsync.attrib; 
        %Fill.attrib;
	%timecontainer.attrib; 
	%Test.attrib; 
	%CustomTest.attrib; 
	%Region.attrib; 
        %SkipContent.attrib;
">
<!ENTITY %  par.content "(%timecontainer.content;)*">
<!ENTITY %  seq.content "(%timecontainer.content;)*">
<!ENTITY % excl.content "((%timecontainer.content;)*|priorityClass+)">

<!ENTITY % priorityClass.attrib  "%content-control-attrs;">
<!ENTITY % priorityClass.content "(%timecontainer.content;)*">

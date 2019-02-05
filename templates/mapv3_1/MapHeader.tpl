{*
 * $Revision: 1264 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{* {literal}
<style type="text/css">
a {ldelim}overflow: hidden;{rdelim}
a:hover {ldelim} outline: none; {rdelim}
</style>
{/literal} *}

{assign var=barPosition value="`$mapv3.ThumbBarPos`"}

{include file="modules/mapv3/includes/GoogleMap.css"}
<!-- Google Maps script -->
{if isset($mapv3.googleMapKey) and $mapv3.googleMapKey neq 'f'}
<script src="//maps.googleapis.com/maps/api/js?file=api&amp;v=3&amp;key={$mapv3.googleMapKey}"
            type="text/javascript"></script>

<script src="{g->url href="modules/mapv3/GoogleMap.js"}" type="text/javascript"></script>
<!-- This is mostly boilerplate code from Google. See: http://www.google.com/apis/maps/documentation/ -->

<script type="text/javascript">
    //<![CDATA[

    var DEBUGINFO = 1; //set to 1 to view the Glog, 0 otherwise

    {if $mapv3.mode eq "Normal" and isset($mapv3.ThumbBarPos) and $barPosition neq "0" and $mapv3.fullScreen neq 3}
    /* initialize some variable for the sidebar */
    var sidebarheight = {$mapv3.ThumbHeight+4};
    {* Should this be ThumbWidth? *}
    var sidebarwidth = {$mapv3.ThumbHeight+4};
    {/if}
    var sidebarhtml = '';
    var sidebarsize = 0;

    //Create the Map variable to be used to store the map infos
    var map;
    //Variable for the google map so that we can get it translated
    var _mSiteName = '{g->text text="Google Local" forJavascript=true}';
    var _mZoomIn = '{g->text text="Zoom In" forJavascript=true}';
    var _mZoomOut = '{g->text text="Zoom Out" forJavascript=true}';
    var _mZoomSet = '{g->text text="Click to set zoom level" forJavascript=true}';
    var _mZoomDrag = '{g->text text="Drag to zoom" forJavascript=true}';
    var _mPanWest = '{g->text text="Go left" forJavascript=true}';
    var _mPanEast = '{g->text text="Go right" forJavascript=true}';
    var _mPanNorth = '{g->text text="Go up" forJavascript=true}';
    var _mPanSouth = '{g->text text="Go down" forJavascript=true}';
    var _mLastResult = '{g->text text="Return to the last result" forJavascript=true}';
    var _mGoogleCopy = '{g->text text="(c)2007 Google" forJavascript=true}';
    var _mDataCopy = '{g->text text="Map data (c)2007 " forJavascript=true}';
    var _mNavteq = '{g->text text="NAVTEQ(tm)" forJavascript=true}';
    var _mTeleAtlas = '{g->text text="Tele Atlas" forJavascript=true}';
    var _mZenrin = '{g->text text="ZENRIN" forJavascript=true}';
    var _mZenrinCopy = '{g->text text="Map (c)2007 " forJavascript=true}';
    var _mNormalMap = '{g->text text="Map" forJavascript=true}';
    var _mNormalMapShort = '{g->text text="Map" hint="Short form for Map" forJavascript=true}';
    var _mHybridMap = '{g->text text="Hybrid" forJavascript=true}';
    var _mHybridMapShort = '{g->text text="Hyb" hint="Short form for Hybrid" forJavascript=true}';
    var _mNew = '{g->text text="New!" forJavascript=true}';
    var _mTerms = '{g->text text="Terms of Use" forJavascript=true}';
    var _mKeyholeMap = '{g->text text="Satellite" forJavascript=true}';
    var _mKeyholeMapShort = '{g->text text="Sat" hint="Short form for Satellite" forJavascript=true}';
    var _mKeyholeCopy = '{g->text text="Imagery (c)2007 " forJavascript=true}';
    var _mScale = '{g->text text="Scale at the center of the map" forJavascript=true}';
    var _mKilometers = '{g->text text="km" forJavascript=true}';
    var _mMiles = '{g->text text="mi" forJavascript=true}';
    var _mMeters = '{g->text text="m" forJavascript=true}';
    var _mFeet = '{g->text text="ft" forJavascript=true}';
    var _mDecimalPoint = '{g->text text="." hint="Decimal point" forJavascript=true}';
    var _mThousandsSeparator = '{g->text text="," hint="Thousands separator" forJavascript=true}';
    var _mMapErrorTile = "{g->text text="We are sorry, but we don't have maps at this zoom level for this region. Try zooming out for a broader look." forJavascript=true}";
    var _mKeyholeErrorTile = "{g->text text="We are sorry, but we don't have imagery at this zoom level for this region. Try zooming out for a broader look." forJavascript=true}";
    var _mTermsURL = '{g->text text="https://www.google.com/intl/en_ALL/help/terms_local.html" forJavascript=true}';
    var _mStaticPath = '{g->text text="https://www.google.com/intl/en_ALL/mapfiles/" forJavascript=true}';
    var _mDomain = '{g->text text="google.com" forJavascript=true}';
    var _mApiBadKey = '{g->text text="The Google Maps API key used on this web site was registered for a different web site. You can generate a new key for this web site at http://www.google.com/apis/maps/" forJavascript=true}';

    var _divhistorytext = '{g->text text="Move history" forJavascript=true}:'
    var _movetext = '{g->text text="move" forJavascript=true}';
    var _zoomtext = '{g->text text="zoom" forJavascript=true}';
    var _starttext = '{g->text text="start" forJavascript=true}';
    var _windowtext = '{g->text text="window" forJavascript=true}';

    /*
    *
    * Global functions
    *
    * */

    // ===== Show and Hide markers =====
    function markerDisplay(number,show,type) {ldelim}
      if (type != 'Regroup'){ldelim}
        if ((show) && (!markers[number].onmap)) {ldelim}
           if (DEBUGINFO) console.debug('Normal Icon,show,'+number);
           markers[number].onmap = true;
           markers[number].setMap(map);
        {rdelim}
        if ((!show) && (markers[number].onmap)) {ldelim}
           if (DEBUGINFO) console.debug('Normal Icon,hide,'+number);
           markers[number].onmap = false;
           markers[number].setMap(null);
        {rdelim}
      {rdelim}else{ldelim}
        if ((show) && (!Rmarkers[number].onmap)) {ldelim}
           if (DEBUGINFO) console.debug('Regroup Icon,show,'+number);
           Rmarkers[number].onmap = true;
           Rmarkers[number].setMap(map);
        {rdelim}
        if ((!show) && (Rmarkers[number].onmap)) {ldelim}
           if (DEBUGINFO) console.debug('Regroup Icon,hide,'+number);
           Rmarkers[number].onmap = false;
           Rmarkers[number].setMap(null);
        {rdelim}
      {rdelim}
    {rdelim}

    {* Calculate the width and weight of the map div, it permits the use of percentages or fixed pixel size *}
    var myWidth = {$mapv3.mapWidth};
    {if $mapv3.mode eq "Normal"}var minusW = {if $mapv3.sidebar eq 1 and $mapv3.fullScreen eq 0}210{else}20{/if}{if ($mapv3.LegendPos eq 'right' and $mapv3.LegendFeature neq '0' and ($mapv3.AlbumLegend or $mapv3.PhotoLegend or (isset($mapv3.regroupItems) and $mapv3.regroupItems))) or ($mapv3.FilterFeature neq '0' and isset($mapv3.ShowFilters) and $mapv3.ShowFilters eq "right")}+155{/if};{/if}
    {if $barPosition eq "3" or $barPosition eq "4"}
      minusW +={$mapv3.ThumbHeight}+30;
    {/if}
    {if $mapv3.mode eq "Pick"} var minusW = 410; {/if}
    {if $mapv3.WidthFormat eq "%"} myWidth = getmapwidth(myWidth,minusW); {/if}

    var myHeight = {$mapv3.mapHeight};
    {if $mapv3.mode eq "Normal"}var minusH = 150{if $mapv3.fullScreen eq 2}-120{/if}{if $mapv3.ShowFilters eq "top" or $mapv3.ShowFilters eq "bottom"}+25{/if}{if $mapv3.LegendPos eq 'top' or $mapv3.LegendPos eq 'bottom'}+90{/if}{if $barPosition eq "1" or $barPosition eq "2"}+{$mapv3.ThumbHeight}+25{/if};{/if}
    {if $mapv3.mode eq "Pick"} var minusH = 155; {/if}
    {if $mapv3.HeightFormat eq "%"} myHeight = getmapheight(myHeight,minusH); {/if}

    var myZoom = {$mapv3.zoomLevel};

    var markers = [];
    var Rmarkers = [];
    var arrowmarker;
    var bounds = new google.maps.LatLngBounds();
    var maxZoom = 10; // default to somewhat zoomed-out

    {if $mapv3.fullScreen neq 3}
    /* functions related to the Thumbnail bar */
    function show_arrow(number,xcoord,ycoord,type){ldelim}
      if (DEBUGINFO) console.debug('Show '+number+','+type);
      if (DEBUGINFO) console.debug('Hiding the Icon');
      markerDisplay(number,0,type);
      var icon = {ldelim}{rdelim};
      icon.url = "{g->url href="modules/mapv3/images/arrow.png"}";
      icon.size = new google.maps.Size(20, 30);
      icon.anchor = new google.maps.Point(10, 30);
      // icon.infoWindowAnchor = new google.maps.Point(9, 2);
      var point = new google.maps.LatLng(xcoord, ycoord);
      var newarrow = new google.maps.Marker({ldelim} position: point, icon: icon.url{rdelim});
      arrow = newarrow;
      newarrow.setMap(map);
    {rdelim}

    function hide_arrow(number,type){ldelim}
      var marker = markers[number];
      if (type != 'normal') marker = Rmarkers[number];
      if (DEBUGINFO) console.debug('hide: '+number+','+type+';myzoom:'+myZoom+'; low:'+marker.showLow+',high:'+marker.showHigh);
      if (myZoom <= marker.showLow && myZoom >= marker.showHigh) {ldelim}
        if (DEBUGINFO) console.debug('Showing the Icon');
        markerDisplay(number,1,type); //marker.display(true);
      {rdelim}
      arrow.setMap(null);
    {rdelim}
    {/if} {* end $mapv3.fullscreen neq 3 *}

    function ShowMeTheMap(){ldelim}

     if (DEBUGINFO) console.debug('Initializing Map');
     var marker_num = 0;
     var Rmarker_num = 0;

    if (DEBUGINFO) console.debug('Create the Map');
    //Google Map implementation
    map = new google.maps.Map(document.getElementById("map"));

   // ================= infoOpened LISTENER ===========
    {* todo: InfoWindow listeners
    {literal}
    google.maps.event.addListener(referenceToInfoWindow, 'domready', function(){
        console.log("Pending implementation of listener");
    };

    GEvent.addListener(map, "infowindowopen", function()  {ldelim}
    infoOpened = true;	// set infoOpened to true to change the history text
    {rdelim});
    // ================= infoClosed LISTENER ===========
    GEvent.addListener(map, "infowindowclose", function()  {ldelim}
    infoOpened = false;	// set infoOpened to false
    {rdelim});
    {/literal}
    *}

    //Initialize the zoom and center of the map where it need to be and the Map Type
    if (DEBUGINFO) console.debug('Set the center, zoom and map type');
    if (DEBUGINFO) console.debug("{$mapv3.centerLongLat} "+myZoom+" {$mapv3.mapType}");
    var point = new google.maps.LatLng ({$mapv3.centerLongLat});
    map.setCenter(point);
    map.setZoom(myZoom);
    map.setMapTypeId("{$mapv3.mapType}");

    {if $mapv3.mode eq "Pick"}

    var center_marker = new google.maps.Marker(
        {ldelim}
            position: point,
            clickable: false,
            map: map
        {rdelim});
    {/if}

    if (DEBUGINFO) console.debug('done!');

    if (DEBUGINFO) console.debug('TODO: Creating the tooltip div');
    {* todo: Tooltip {literal}
        See for an example at
        https://developers.google.com/maps/documentation/javascript/examples/overlay-popup
    {/literal}
    *}
    tooltip = document.createElement("div");
    tooltip.id = "map-tooltip";
        {* todo: Tooltip {literal}
        map.getPane(G_MAP_FLOAT_PANE).appendChild(tooltip);
        // Add tooltip to the dom
            {/literal}
        *}
    tooltip.style.visibility="hidden";
    if (DEBUGINFO) console.debug('done!');

    {literal}
    function setMapCenter(map, position){
        map.setCenter(position);
    }
    {/literal}
    {if $mapv3.fullScreen eq 3}
    {* todo: Resize {literal}
        see https://stackoverflow.com/questions/12030443/google-maps-api-v3-resize-event
    if (document.all&&window.attachEvent) {ldelim} // IE-Win
      window.attachEvent("onresize", function() {ldelim}this.map.onResize(){rdelim} );
    {rdelim} else if (window.addEventListener) {ldelim} // Others
      window.addEventListener("resize", function() {ldelim}this.map.onResize(){rdelim}, false );
    {rdelim}
    {/literal}
    *}
    {/if}

    {if $mapv3.mode eq "Normal"}

    function fromLatLngToPoint(latLng, map) {ldelim}
        var topRight = map.getProjection().fromLatLngToPoint(map.getBounds().getNorthEast());
        var bottomLeft = map.getProjection().fromLatLngToPoint(map.getBounds().getSouthWest());
        var scale = Math.pow(2, map.getZoom());
        var worldPoint = map.getProjection().fromLatLngToPoint(latLng);
        return new google.maps.Point((worldPoint.x - bottomLeft.x) * scale, (worldPoint.y - topRight.y) * scale);
    {rdelim}

    function showTooltip(marker) {ldelim}
      tooltip.innerHTML = marker.tooltip;
      var point = map.getCenter();
      var offset = fromLatLngToPoint(marker.position, map);
      var anchor = marker.anchorPoint;
      {* // TODO var width = marker.getIcon().size.width; *}
      var height = tooltip.clientHeight;

      tooltip.style.visibility="visible";
    {rdelim}

    var BaseIcon = {ldelim}{rdelim};
    BaseIcon.size = new google.maps.Size({$mapv3.MarkerSizeX},{$mapv3.MarkerSizeY});
    BaseIcon.anchor = new google.maps.Point(6, 20);
    BaseIcon.infoWindowAnchor = new google.maps.Point(5, 1);

    {if (isset($mapv3.regroupItems) and $mapv3.regroupItems)}
    var replaceIcon = {ldelim}{rdelim};
    replaceIcon.size = new google.maps.Size({$mapv3.ReplaceMarkerSizeX},{$mapv3.ReplaceMarkerSizeY});
    replaceIcon.anchor = new google.maps.Point({$mapv3.replaceAnchorPos});
    replaceIcon.url = "{g->url href="modules/mapv3/images/multi/`$mapv3.regroupIcon`.png"}";

    function CreateRegroup(lat,lon, showLow, showHigh, nbDirect, nbItems, nbGroups){ldelim}
      var point = new google.maps.LatLng(lat,lon);
      {if !isset($mapv3.Filter) or (isset($mapv3.Filter) and ($mapv3.Filter|truncate:5:"" neq 'Route'))}bounds.extend(point);{/if}
      var marker = new google.maps.Marker(point,replaceIcon)
      marker.onmap = true;
      marker.showHigh = showHigh;
      marker.showLow = showLow;
      GEvent.addListener(marker,"mouseover", function() {ldelim}
        showTooltip(marker);
      {rdelim});
      GEvent.addListener(marker,"mouseout", function() {ldelim}
	    tooltip.style.visibility="hidden";
      {rdelim});
      GEvent.addListener(marker, "click", function() {ldelim}
        tooltip.style.visibility="hidden";
        map.setCenter(point,showLow+1);
      {rdelim});
      var directText = nbDirect>0 ? ""+nbDirect+" items and "+ (nbItems-nbDirect) +" more " : "";
      var subgroupText = nbGroups>0 ? " ("+directText+"in "+nbGroups+" subgroups)" : "";
      var title = ''+nbItems+' elements here'+subgroupText+'. Click to zoom in.';
      marker.tooltip = '<div class="tooltip">'+title+'<\/div>';
      marker.type = 'Regroup';
      Rmarkers[Rmarker_num] = marker;
      Rmarker_num++;
      marker.setMap(map);
    {rdelim}
    {/if}
    {literal}
    function CreateMarker(lat, lon, itemLink, title, thumbLink, created, zoomlevel, thw, thh, summary, description, icon, showLow, showHigh, hide, type) {
    {/literal}
        var htmls = [{foreach from=$mapv3.infowindows item=infowindow key=num}{if $num >0},{/if}{$infowindow}{/foreach}];
        var labels = [{foreach from=$mapv3.Labels item=Labels key=num}{if $num >0}, {/if}"{$Labels}"{/foreach}];
        var point = new google.maps.LatLng(lat, lon);
        {if !isset($mapv3.Filter) or (isset($mapv3.Filter) and ($mapv3.Filter|truncate:5:"" neq 'Route'))}
        bounds.extend(point);
        maxZoom = Math.max(maxZoom, zoomlevel);
        {/if}
        {literal}
        var marker = new google.maps.Marker({position: point, icon: icon.url});
        marker.onmap = true;
        marker.showHigh = showHigh;
        marker.showLow = showLow;
        marker.addListener("mouseover", function () {
            showTooltip(marker);
        });
        marker.addListener("mouseout", function () {
            tooltip.style.visibility = "hidden";
        });
        marker.addListener("click", function () {
            tooltip.style.visibility = "hidden";
            if (htmls.length > 2) {
                htmls[0] = '<div style="width:' + htmls.length * 88 + 'px">' + htmls[0] + '<\/div>';
            }
            var info_content = htmls.join();
            var infowindow = new google.maps.InfoWindow({content: info_content});
            infowindow.open(map, marker);
            setMapCenter(map, point);
            var thumb = document.querySelector('#thumb'+this.num);
            if (thumb){
                var thumbPrevious = document.querySelector('.thumbbar .active');
                if (thumbPrevious) {
                    thumbPrevious.classList.remove('active');
                }
                thumb.scrollIntoView({behavior: 'smooth', block: 'center', inline: 'center'});
                thumb.classList.toggle('active');
            }
        });
        marker.tooltip = '<div class="tooltip">' + title + '<\/div>';
        marker.num = marker_num;
        marker.type = type;
        markers[marker_num] = marker;
        marker_num++;

        marker.setMap(map);

        if (hide == 1) markerDisplay(marker_num - 1, 0, 'normal');
    } /* function CreateMarker */
        {/literal}

   //Create the base for all icons
   var base_icon = {ldelim}{rdelim};
   base_icon.size = new google.maps.Size({$mapv3.MarkerSizeX},{$mapv3.MarkerSizeY});
   base_icon.anchor = new google.maps.Point(6, 20);
   base_icon.infoWindowAnchor = new google.maps.Point(5, 1);

   var default_photo_icon = {ldelim}{rdelim};
   default_photo_icon.url = "{g->url href="modules/mapv3/images/markers/`$mapv3.useMarkerSet`/marker_`$mapv3.defaultphotocolor`.png"}";
   default_photo_icon.size = new google.maps.Size({$mapv3.MarkerSizeX},{$mapv3.MarkerSizeY});
   default_photo_icon.anchor = new google.maps.Point({$mapv3.MarkerSizeX}/2, {$mapv3.MarkerSizeY});

   var default_album_icon = {ldelim}{rdelim};
   default_album_icon.url = "{g->url href="modules/mapv3/images/markers/`$mapv3.useAlbumMarkerSet`/marker_`$mapv3.defaultalbumcolor`.png"}";
   default_album_icon.size = new google.maps.Size({$mapv3.AlbumMarkerSizeX},{$mapv3.AlbumMarkerSizeY});
   default_album_icon.anchor = new google.maps.Point({$mapv3.AlbumMarkerSizeX}/2,{$mapv3.AlbumMarkerSizeY});

   var default_group_icon = {ldelim}{rdelim};
   default_group_icon.url = "{g->url href="modules/mapv3/images/markers/`$mapv3.useGroupMarkerSet`/marker_`$mapv3.defaultgroupcolor`.png"}";
   default_group_icon.size = new google.maps.Size({$mapv3.GroupMarkerSizeX},{$mapv3.GroupMarkerSizeY});
   default_group_icon.anchor = new google.maps.Point({$mapv3.GroupMarkerSizeX}/2,{$mapv3.GroupMarkerSizeY});

    /* Loop over gallery items that have GPS coordinates
        and output code to add them to the map. */
    {if (!empty($mapv3.mapPoints))}
    {counter name="num" start=-1 print=false}
    {counter name="num1" start=-1 print=false}
    {counter name="num2" start=-1 print=false}
    {counter name="num3" start=-1 print=false}
    {counter name="num4" start=-1 print=false}
    /* creates the Thumbnail bar as we go */
    {foreach from=$mapv3.mapPoints item=point}
      {if $barPosition neq "0" and $mapv3.fullScreen neq 3}
      {* //map.setCenter(new google.maps.Point({$point.gps})); *}
      sidebarhtml += '' +
          '<a id="thumb{counter name="num3"}" ' +
          'href="#" ' +
          'onclick="new google.maps.event.trigger(markers[{counter name="num2"}], \'click\' ); return false;" ' +
          'onmouseover="show_arrow({counter name="num"},{$point.gps},\'normal\');" ' +
          'onmouseout="hide_arrow({counter name="num1"},\'normal\');">' +
          '<img style="\
            {strip}{if $barPosition eq "3" or $barPosition eq "4"}width{else}height
            {/if}:{$mapv3.ThumbHeight}px;"{/strip}' +
        'src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" class="lazyload" data-src="{$point.thumbLink}"/>{if $barPosition eq "3" or $barPosition eq "4"}<br/>{/if}<\/a>';
      sidebarsize +={if $barPosition eq "3" or $barPosition eq "4"}{$point.thumbbarHeight}{else}{$point.thumbbarWidth}{/if}+2;
      {/if}
      {if $point.type eq "GalleryAlbumItem"}
       {assign var=itemType value="album"}
       {assign var=markerSet value="`$mapv3.useAlbumMarkerSet`"}
       {assign var=markerColor value="`$mapv3.defaultalbumcolor`"}
      {elseif $point.type eq "GoogleMapGroup"}
       {assign var=itemType value="group"}
       {assign var=markerSet value="`$mapv3.useGroupMarkerSet`"}
       {assign var=markerColor value="`$mapv3.defaultgroupcolor`"}
      {else}
       {assign var=itemType value="photo"}
       {assign var=markerSet value="`$mapv3.useMarkerSet`"}
       {assign var=markerColor value="`$mapv3.defaultphotocolor`"}
      {/if}
      {assign var=iconDef value="default_"}
      {if $point.color neq "default"}
      var {$itemType}_icon = JSON.parse(JSON.stringify(default_{$itemType}_icon));
      {assign var=iconDef value=""}{* Clear the "Default" and flag that we declared the variable *}
      {assign var=markerColor value="`$point.color`"}
      {$itemType}_icon.url = "{g->url href="modules/mapv3/images/markers/`$markerSet`/marker_`$point.color`.png"}";
      {/if}
      {* quick hacky fix for missing numbered markers *}
      {if $mapv3.EnableRouteNumber}
      {foreach from=$mapv3.routeitem key=name item=items}
       {foreach from=$items item=id key=num}
        {if $point.id == $id}
         {if $iconDef eq "default_"}{* variable hasn't been declared yet *}
          {assign var=iconDef value=""}{* Clear the "Default" text *}
          var {$itemType}_icon = JSON.parse(JSON.stringify(default_{$itemType}_icon));
         {/if}
         {$itemType}_icon.url = "{g->url href="modules/mapv3/images/routes/`$name`/`$num+1`-marker_`$markerColor`.png"}";
        {/if}
       {/foreach}
      {/foreach}
      {/if}
      {if $point.id|truncate:1:"" neq 'T'}
        {strip}
        CreateMarker({$point.gps},
            "{$point.itemLink}",
            "{$point.title|markup|escape:"javascript"}",
            "{$point.thumbLink}",
            "{$point.created}",
            {$point.zoomlevel},
            {$point.thumbWidth},
            {$point.thumbHeight},
            {if $mapv3.showItemSummaries && !empty($point.summary)}
                "{$point.summary|markup|escape:"javascript"}"
            {else}
                ""
            {/if},
            {if $mapv3.showItemDescriptions && !empty($point.description)}
                "{$point.description|markup|escape:"javascript"}"
            {else}
                ""
            {/if},
          {$iconDef}{$itemType}_icon,
          {$point.regroupShowLow},
          {$point.regroupShowHigh},
          0,
          "{$point.type}");
        {/strip}
      {/if}
    {/foreach}

    {if isset($barPosition) and $barPosition neq 0 and $mapv3.fullScreen neq 3}
    var thumbdiv = document.getElementById("thumbs");
    thumbdiv.innerHTML = sidebarhtml;
    var mapdiv = document.getElementById("map");

    {if $barPosition eq "1" or $barPosition eq "2"}
    if (sidebarsize+1 > myWidth)  sidebarheight = {$mapv3.ThumbHeight+25};
    thumbdiv.style.height = sidebarheight+"px";
    {else}
    {* Should this be $mapv3.ThumbWidth? *}
    if (sidebarsize+1 > myHeight)  sidebarwidth = {$mapv3.ThumbWeight+25};
    thumbdiv.style.width = sidebarwidth+"px";
    {/if}

    {/if}

    {/if}

    /* Loop over routes if any and display them */
    {if (!empty($mapv3.Routes))}
    var point;
    {foreach from=$mapv3.Routes item=routes}
      var points = [];
      {if $routes.5 eq "Yes"}
      {foreach from=$routes[7] item=point}
         point = new google.maps.LatLng({$point[0]},{$point[1]});
         points.push(point);
         {if (isset($mapv3.Filter) and (($mapv3.Filter|truncate:5:"" eq 'Route')))}bounds.extend(point);{/if}
      {/foreach}
      var poly = new google.maps.Polyline({ldelim}
          path: points,
          strokeColor: "{$routes[2]}",
          strokeWeight: {$routes[3]},
          strokeOpacity: {$routes[4]}
      {rdelim});
      poly.setMap(map);
      {/if}
    {/foreach}
    {/if}

    {if $mapv3.AutoCenterZoom and (!isset($mapv3.Filter) or (isset($mapv3.Filter) and (($mapv3.Filter|truncate:5:"" eq 'Route') or ($mapv3.Filter|truncate:5:"" eq 'Album') or ($mapv3.Filter|truncate:5:"" eq 'Group'))))}
        map.fitBounds(bounds);
    {/if}

    {* set the correct zoom slide notch and show/hide the regrouped item *}
    zoom = map.getZoom();
    myZoom = 19-zoom;

    for (var i=0; i < markers.length; i++) {ldelim} //Updating the normal items
        var marker = markers[i];
        if (zoom <= marker.showLow && zoom >= marker.showHigh) {ldelim}
          markerDisplay(i,1,'normal'); //marker.display(true);
          var CorrectA = document.getElementById('thumb'+i);
          if (CorrectA != null ) CorrectA.style.display = "inline";
        {rdelim}
        else {ldelim}
          markerDisplay(i,0,'normal'); //marker.display(false);
          var CorrectA = document.getElementById('thumb'+i);
          if (CorrectA != null) CorrectA.style.display = "none";
        {rdelim}
    {rdelim}
    for (var i=0; i < Rmarkers.length; i++) {ldelim} //Updating the normal items
        var marker = Rmarkers[i];
        if (zoom <= marker.showLow && zoom >= marker.showHigh) {ldelim}
          markerDisplay(i,1,'Regroup'); //marker.display(true);
        {rdelim}
        else {ldelim}
          markerDisplay(i,0,'Regroup'); //marker.display(false);
        {rdelim}
    {rdelim}

    {/if}

    {if $mapv3.mode eq "Pick"}
        map.addListener('center_changed', function() {ldelim}
        var center = map.getCenter();
        center_marker.setPosition(center);
        var latLngStr = center.toUrlValue(6);
        document.getElementById("message_id").innerHTML = '(' + latLngStr + ')';
        document.getElementById("coord").value = latLngStr;
        {rdelim});

        map.addListener('click', function(event) {ldelim}
            var point = event.latLng;
            var latitude = point.lat();
            var longitude = point.lng();
            console.log( latitude + ', ' + longitude );

           if (point) {ldelim}
            center_marker.position = point;
            map.panTo(point);
            var latLngStr = point.toUrlValue(6);
            document.getElementById("message_id").innerHTML = '(' + latLngStr + ')';
            document.getElementById("coord").value = latLngStr;
          {rdelim}
        {rdelim});

        map.addListener('zoom_changed', function(event) {ldelim}
            var oldZoomLevel = map.zoom;
            var newZoomLevel = map.getZoom();

          var center = '' + newZoomLevel;
          document.getElementById("zoom_id").innerHTML = center;
        {rdelim});
    {/if}
    {rdelim} /* end ShowMeTheMap() */

    {if $mapv3.mode eq "Normal" and $mapv3.fullScreen neq 3}
    function togglealbumlegend()
    {ldelim}
        if (document.getElementById) {ldelim} // standard
            var displaystyle = document.getElementById("albumlegend").style.display;
            document.getElementById("albumlegend").style.display = (displaystyle == "none" ? "block":"none");
        {rdelim} else if (document.all){ldelim} // old msie versions
            var displaystyle = document.all["albumlegend"].style.display;
            document.all["albumlegend"].style.display = (displaystyle == "none" ? "block":"none");
        {rdelim} else if (document.layers){ldelim} // nn4
            var displaystyle = document.layers["albumlegend"].style.display;
            document.layers["albumlegend"].style.display = (displaystyle == "none" ? "block":"none");
        {rdelim}
        var imgsrc = document.albumarrow.id;
        document.albumarrow.src = (imgsrc  == "down" ? "{g->url href="modules/mapv3/images/up.png"}":"{g->url href="modules/mapv3/images/down.png"}");
        document.albumarrow.id = (imgsrc == "down" ? "up":"down");
    {rdelim}

    function togglephotolegend()
    {ldelim}
        if (document.getElementById) {ldelim} // standard
            var displaystyle = document.getElementById("photolegend").style.display;
            document.getElementById("photolegend").style.display = (displaystyle == "none" ? "block":"none");
        {rdelim} else if (document.all){ldelim} // old msie versions
            var displaystyle = document.all["photolegend"].style.display;
            document.all["photolegend"].style.display = (displaystyle == "none" ? "block":"none");
        {rdelim} else if (document.layers){ldelim} // nn4
            var displaystyle = document.layers["photolegend"].style.display;
            document.layers["photolegend"].style.display = (displaystyle == "none" ? "block":"none");
        {rdelim}
        var imgsrc = document.photoarrow.id;
        document.photoarrow.src = (imgsrc  == "down" ? "{g->url href="modules/mapv3/images/up.png"}":"{g->url href="modules/mapv3/images/down.png"}");
        document.photoarrow.id = (imgsrc == "down" ? "up":"down");
    {rdelim}

    function strLeft(kstr,kchar)
    {ldelim}
      var retVal = "-1";

      if (kstr.indexOf (kchar) > -1)
        retVal =
          kstr.substring (0, kstr.indexOf(kchar));
      return(retVal);

    {rdelim}
    function strRight(kstr, kchar)
    {ldelim}
      var   retVal = "-1";

      if (kstr.indexOf(kchar) > -1 )
        retVal =
          kstr.substring(kstr.indexOf(kchar) + kchar.length,
              kstr.length);
      return(retVal);
    {rdelim}

    function togglemarkers(number)
    {ldelim}
      if (DEBUGINFO) console.debug('Entering Toggle Marker');
      var markercolor;
      var thetd = document.getElementById(number);
      var Itype = number.substring(0,1);
      if (Itype=="A") var thetype = "GalleryAlbumItem";
      else var thetype = "GalleryPhotoItem";
      var thecheckbox = document.getElementsByName("C"+number);
      var clickedcolor = strRight(strLeft(thetd.innerHTML,".png"),"marker_");
      var zoom = map.getZoom();
      if (DEBUGINFO) {ldelim}
         console.debug(clickedcolor+' '+thetype+' '+zoom);
         if (thecheckbox.item(0).checked) console.debug('Showing');
         else console.debug('Hiding');
      {rdelim}
      for (var i=0; i<markers.length; i++) {ldelim}
       var checktype = (markers[i]["type"] == "GalleryAlbumItem") ? "GalleryAlbumItem":"GalleryPhotoItem";
       markercolor = strRight(strLeft(markers[i].getIcon().image,".png"),"marker_");
       if (DEBUGINFO) console.debug('Marker: '+markers[i]["type"]+' '+markercolor+' '+markers[i].showLow+' '+markers[i].showHigh);
       if (markercolor == clickedcolor && (checktype == thetype || markers[i]['type'] == "Regroup")){ldelim}
         if (thecheckbox.item(0).checked && zoom <= markers[i].showLow && zoom >= markers[i].showHigh) markerDisplay(i,1,'normal'); //markers[i].display(true);
         else
         {ldelim}
           if (DEBUGINFO) console.debug('Hiding');
           markerDisplay(i,0,'normal'); //markers[i].display(false);
         {rdelim}
       {rdelim}

      {rdelim}
    {rdelim}
    {/if}

    google.maps.event.addDomListener(window, 'load', ShowMeTheMap);

    var GoogleMap = true;

    //]]>
</script>
{/if}

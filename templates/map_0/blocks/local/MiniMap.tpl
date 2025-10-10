{*
 * $Revision: 1264 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{* Set defaults *}
{if !isset($item)}{assign var=item value=$theme.item}{/if}
{if !isset($mapHeight)}{assign var=mapHeight value=150}{/if}
{if !isset($mapWidth)}{assign var=mapWidth value="100%"}{/if}
{if !isset($mapType)}{assign var=mapType value=3}{/if}
{if !isset($showControls)}{assign var=showControls value=false}{/if}

{g->callback type="map.MiniMap" itemId=$item.id albumMarker=$albumMarker|default:true albumItems=$albumItems|default:2 useParentCoords=$useParentCoords|default:false}
{if !empty($block.map.MiniMap) and $block.map.MiniMap.APIKey neq '' and !(empty($block.map.MiniMap.mapCenter) and empty($block.map.MiniMap.markers))}
<div class="{$class} clearfix">
{if $block.map.MiniMap.blockNum == 1}{* Only include Google Maps script once *}
<script src="//maps.google.com/maps?file=api&amp;v=2.x&amp;key={$block.map.MiniMap.APIKey}"
	type="text/javascript"></script>
{/if}
<script type="text/javascript">
//<![CDATA[
{* Append the blockNum to the function name to make it unique in the document *}
function load_map_{$block.map.MiniMap.blockNum}() {ldelim}
if (GBrowserIsCompatible()) {ldelim}
    var map = new GMap2(document.getElementById("minimap-{$block.map.MiniMap.blockNum}"),
    	{ldelim}mapTypes:[{if $mapType eq 1}G_NORMAL_MAP{elseif $mapType eq 2}G_SATELLITE_MAP{else}G_HYBRID_MAP{/if}]{rdelim});
    {if !empty($block.map.MiniMap.mapCenter)}{* already have a valid mapCenter *}
    map.setCenter(new GLatLng({$block.map.MiniMap.mapCenter}), {$block.map.MiniMap.mapZoom});
    {else}
    map.setCenter(new GLatLng(0,0));{* Will reset to auto center after adding markers *}
    {/if}
    {* Set up all the icons for the markers *}
    {foreach from=$block.map.MiniMap.markerIcons key=iconName item=icon}
    var {$iconName} = new GIcon();
    {$iconName}.image = "{$icon.imgUrl}";
    {$iconName}.shadow = "{$icon.shadowUrl}";
    {$iconName}.iconSize = new GSize({$icon.width}, {$icon.height});
    {$iconName}.shadowSize = new GSize({$icon.width}+15, {$icon.height});
    {$iconName}.iconAnchor = new GPoint({$icon.width}/2, {$icon.height});
    {/foreach}
    {* Now create and add the markers to the map *}
    var markerCoords;
    {if empty($block.map.MiniMap.mapCenter)}
    var autoCenterBounds = new GLatLngBounds();
    var maxZoom = 0;
    {/if}
    {foreach from=$block.map.MiniMap.markers item=marker}
    markerCoords = new GLatLng({$marker.GPS});
    {if empty($block.map.MiniMap.mapCenter)}
    {if isset($marker.ZoomLevel)}
    {* Get the maximum zoom to prevent a useless super-zoomed-in view. *}
    maxZoom = Math.max(maxZoom, {$marker.ZoomLevel});
    {/if}
    autoCenterBounds.extend(markerCoords);
    {/if}
    map.addOverlay(new GMarker(markerCoords,{ldelim}clickable:false,title:"{$marker.title|escape:'javascript'}",icon:{$marker.icon}{rdelim}));
    {/foreach}
    {if empty($block.map.MiniMap.mapCenter)}{* Auto center and zoom based on markers to be shown *}
    map.setCenter(autoCenterBounds.getCenter(), Math.min(map.getBoundsZoomLevel(autoCenterBounds), maxZoom));
    {/if}
    {if $showControls}
    map.addControl(new GSmallMapControl(false, false));
    {else}
    map.disableDragging();
    {/if}
{rdelim}
{rdelim}
//<!-- Weird workaround onLoad hack for IE; Mozilla doesn't need this extra code -->
function init_map_{$block.map.MiniMap.blockNum}() {ldelim}
if (arguments.callee.done) return;
arguments.callee.done = true;
load_map_{$block.map.MiniMap.blockNum}();
{rdelim}
if (document.addEventListener) {ldelim}
/* for Safari/Mozilla */
window.addEventListener('load', init_map_{$block.map.MiniMap.blockNum}, false);
window.addEventListener('unload', GUnload, false);
{rdelim} else if (window.attachEvent) {ldelim}
/* for Internet Explorer */
window.attachEvent('onload', init_map_{$block.map.MiniMap.blockNum});
window.attachEvent('onunload', GUnload);
{rdelim} else {ldelim}
/* for other browsers */
var oldonload{$block.map.MiniMap.blockNum} = window.onload;
var oldunload = window.onunload;
if (typeof window.onload != 'function') {ldelim}
    window.onload = init_map_{$block.map.MiniMap.blockNum};
{rdelim} else {ldelim}
    window.onload = function() {ldelim}
        if (oldonload{$block.map.MiniMap.blockNum}) {ldelim}
            oldonload{$block.map.MiniMap.blockNum}();
        {rdelim}
        init_map_{$block.map.MiniMap.blockNum}();
    {rdelim}
{rdelim}
{if $block.map.MiniMap.blockNum == 1}{* Only need to call GUnload once, not for every block *}
if (typeof window.onunload != 'function') {ldelim}
    window.onunload = GUnload;
{rdelim} else {ldelim}
    window.onunload = function() {ldelim}
        if (oldonunload) {ldelim}
            oldonunload();
        {rdelim}
        GUnload();
    {rdelim}
{rdelim}
{/if}
{rdelim}
//]]>
</script>
<style>
.gallery-google-map-wrapper {ldelim}
    max-width: {$mapWidth};
    width: auto;
{rdelim}
.gallery-google-map-container {ldelim}
    border:1px solid black;
    height: {$mapHeight}px;
    max-height: 100%;
{rdelim}
</style>
<div class="gallery-google-map-wrapper">
<div class="block-expandable-header"><h3>{g->text text="%s Location Map" arg1=$block.map.MiniMap.ItemType}</h3></div>
<div id="minimap-{$block.map.MiniMap.blockNum}" class="MiniGMap block-expandable-content gallery-google-map-container"></div>
</div>
</div>
{/if}
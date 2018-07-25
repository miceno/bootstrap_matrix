{*
 * $Revision: 16349 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{if isset($theme.params.aboveFoldImages)}
    {assign var="aboveFoldImages" value=$theme.params.aboveFoldImages}
{else}
    {assign var="aboveFoldImages" value=8}
{/if}

<div class="theme-body panel panel-default gcBackground1 ">
    {* <div class="theme-content"> *}
    {*  <div id="gsContent" class="container-fluid"> *}

    <div class="gHeader panel-heading clearfix">
        {if !empty($theme.item.title)}
            <div class="album-header-wrapper">
            {g->block type="core.BreadCrumb"}
            {strip}
            <h2 class="visible-xs-inline collapsed visible-sm-inline visible-md-inline visible-lg-inline panel-title"
                data-toggle="collapse" data-target="#description-{$theme.item.id}">
                <span class="album-title">{$theme.item.title|markup}</span>
                <i class="indicator glyphicon glyphicon-chevron-up"></i>
            </h2>
            {/strip}
            {if !empty($theme.params.sidebarBlocks)}
                {g->theme include="sidebar.tpl"}
            {/if}
            </div>
        {/if}

        <div id="description-{$theme.item.id}" class="description-wrapper collapse">
            {if !empty($theme.item.description)}
                <div class="giDescription">
                    {$theme.item.description|markup}
                </div>
            {/if}
            {g->block type="core.ItemInfo"
            item=$theme.item
            showDate=false
            showSize=true
            showOwner=false
            class="giInfo"}
        </div> {* description *}
    </div> {* gHeader *}

    {if !count($theme.children)}
        {* TODO: Empty album *}
        <div class="gbBlock giDescription gbEmptyAlbum row">
            <h3 class="emptyAlbum">
                {g->text text="This album is empty."}
                {if isset($theme.permissions.core_addDataItem)}
                    <br/>
                    <a href="{g->url arg1="view=core.ItemAdmin" arg2="subView=core.ItemAdd" arg3="itemId=`$theme.item.id`"}"> {g->text text="Add a photo!"} </a>
                {/if}
            </h3>
        </div>
    {else} {* panel-body *}
        <div class="gbBlock panel-body">
            {*               *}
            {* Top navigator *}
            {*               *}
            {if !empty($theme.navigator)}
                {g->block type="core.Navigator" navigator=$theme.navigator reverseOrder=false}
            {/if}
            {*               *}
            {* Image matrix  *}
            {*               *}
            <div id="gsThumbMatrix" class="row-fluid clearfix">
                {foreach from=$theme.children item=child name=child}

                    <div class="{strip}
                    {if $child.canContainChildren}
                        giAlbumCell {* empty *}
                    {else}
                        giItemCell {* empty *}
                    {/if}
                    col-xs-12 col-sm-6 col-md-4 col-lg-3"
                            {* style="width: {$theme.columnWidthPct}%" *}
                            {/strip}>
                        {if ($child.canContainChildren || $child.entityType == 'GalleryLinkItem')}
                            {assign var=frameType value="albumFrame"}
                            {capture assign=linkUrl}{g->url arg1="view=core.ShowItem" arg2="itemId=`$child.id`"}{/capture}
                        {else}
                            {assign var=frameType value="itemFrame"}
                            {capture assign=linkUrl}{strip}
                                {if $theme.params.dynamicLinks == 'jump'}
                                    {g->url arg1="view=core.ShowItem" arg2="itemId=`$child.id`"}
                                {else}
                                    {g->url params=$theme.pageUrl arg1="itemId=`$child.id`"}
                                {/if}
                            {/strip}{/capture}
                        {/if}
                        <div class="thumbnail-wrapper">
                            {if isset($theme.params.$frameType) && isset($child.thumbnail)}
                                {g->container type="imageframe.ImageFrame" frame=$theme.params.$frameType
                            width=$child.thumbnail.width height=$child.thumbnail.height}
                                <a href="{$linkUrl}">
                                    {g->image id="%ID%" item=$child image=$child.thumbnail
                                    class="%CLASS% giThumbnail"}
                                </a>
                            {/g->container}
                            {elseif isset($child.thumbnail)}
                                {assign var="lazyLoad" value=false}
                                {if $smarty.foreach.child.index+1 > $aboveFoldImages}
                                    {assign var="lazyLoad" value="true"}
                                {/if}
                                <a href="{$linkUrl}" class="thumbnail link-{$child.entityType}">
                                    {g->image item=$child image=$child.thumbnail class="giThumbnail" lazyload=$lazyLoad}
                                </a>
                            {else}
                                <a href="{$linkUrl}" class="thumbnail giMissingThumbnail">
                                    <img src="/install/images/background.png" class="giThumbnail gcPhotoImage"
                                         title="{g->text text="No Thumbnail"}" alt='{g->text text="No Thumbnail"}'/>
                                </a>
                            {/if}
                            <div class="thumbnail-description-wrapper opensans">
                                {if !empty($child.title)}
                                    <p class="giTitle collapsed" data-toggle="collapse"
                                       data-target="#description-{$smarty.foreach.child.index}">
                                        {if $child.canContainChildren && (!isset($theme.params.albumFrame)
                                        || $theme.params.albumFrame == $theme.params.itemFrame)}
                                            {* Add prefix for albums unless imageframe will differentiate *}
                                            {g->text text="Album: %s" arg1=$child.title|markup}
                                        {else}
                                            {$child.title|markup}
                                        {/if}
                                        <i class="indicator glyphicon glyphicon-chevron-up pull-right"></i>
                                    </p>
                                {/if}

                                <div id="description-{$smarty.foreach.child.index}" class="collapse">
                                    {if !empty($child.summary)}
                                        <p class="giDescription">
                                            {$child.summary|markup|entitytruncate:256}
                                        </p>
                                    {/if}

                                    {if ($child.canContainChildren && $theme.params.showAlbumOwner) ||
                                    (!$child.canContainChildren && $theme.params.showImageOwner)}
                                        {assign var="showOwner" value=true}
                                    {else}
                                        {assign var="showOwner" value=false}
                                    {/if}
                                    {g->block type="core.ItemInfo"
                                    item=$child
                                    showDate=false
                                    showOwner=$showOwner
                                    showSize=true
                                    showViewCount=false
                                    showSummaries=false
                                    showKeywords=true
                                    class="giInfo"}
                                </div> {* collapse *}

                            </div>{* thumbnail-description-wrapper *}
                            {g->block type="core.ItemLinks" useDropdown=false onlyIcons=true item=$child links=$child.itemLinks}
                        </div> {* thumbnail-wrapper *}
                        <!-- Add the extra clearfix for only the required viewport -->

                    </div>
                    {* giCell *}
                {/foreach}
            </div> {* gsThumbMatrix *}

            {*                  *}
            {* Bottom navigator *}
            {*                  *}
            {if !empty($theme.navigator)}
                {g->block type="core.Navigator" navigator=$theme.navigator reverseOrder=false}
            {/if}
        </div>
        <!-- gbBlock panel-body -->
    {/if} {* endif theme.children *}

    <div class="panel-footer">
        {g->block type="core.GuestPreview" class="gbBlock"}
        {* Our emergency edit link, if the user removes all blocks containing edit links *}
        {g->block type="core.EmergencyEditItemLink" class="gbBlock" checkBlocks="sidebar,album"}

        {* Show any other album blocks (comments, etc) *}
        {foreach from=$theme.params.albumBlocks item=block}
            {g->block type=$block.0 params=$block.1}
        {/foreach}
    </div>

    {*       </div> gsContent *}
    {*    </div> theme-content *}
</div> {* theme-body *}

<!-- {if !empty($theme.params.sidebarBlocks)}
      <script type="text/javascript">
         {* hide the sidebar if there-s nothing in it *}
         // <![CDATA[
         var el = document.getElementById("gsSidebarCol");
         var text = el.innerText;  // IE
         if (!text) text = el.textContent; // Firefox
         if (!text || !text.match(/\S/)) el.style.display = 'none';
         // ]]>
      </script>
      {/if}
-->
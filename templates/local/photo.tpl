{*
 * $Revision: 16387 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{if !empty($theme.imageViews)}
    {assign var="image" value=$theme.imageViews[$theme.imageViewsIndex]}
{/if}
{if !empty($theme.navigator)}
    {assign var="navigator" value=$theme.navigator}
{/if}

<div>
{if !isset($theme.params.boxesLayout) || !empty($theme.params.boxesLayout)}
    {assign var="boxesLayout" value=$theme.params.boxesLayout}
{/if}
</div>
<div class="theme-photo-wrapper">

    <div class="photo-container {if $boxesLayout == "right" }col-xs-12 col-sm-8{/if}">

        <div id="gsImageView" class="photo-overlay">
            {strip}
                {if !empty($theme.item.title)}
                    {g->block type="core.BreadCrumb"}
                {/if}
            {/strip}
            <div class="item-position hidden-xs hidden-sm">
                {$theme.itemPosition+1} {g->text text="of"} {$theme.totalItems}
            </div>
            <div class="gbNavigator nav-arrow previous">
                {strip}
                <div class="arrow">
                    {if isset($navigator.back)}
                        <a href="{g->url params=$navigator.back.urlParams}" aria-label="{g->text text="previous"}"
                        class="previous">
                    {else}
                        <span>
                    {/if}
                    <span class="sr-only">{g->text text="previous"}</span>
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    {if isset($navigator.back)}</a>
                    {else}
                        </span>
                    {/if}
                </div>
                {/strip}
            </div>

            <div class="gbNavigator nav-arrow next">
                {strip}
                <div class="arrow">
                    {if isset($navigator.next)}
                        <a href="{g->url params=$navigator.next.urlParams}" aria-label="{g->text text="next"}"
                        class="next">
                    {else}
                        <span>
                    {/if}
                    <span class="sr-only">{g->text text="next"}</span>
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    {if isset($navigator.next)}</a>
                    {else}
                        </span>
                    {/if}
                </div>
                {/strip}
            </div>
        </div>
        {if !empty($theme.imageViews)}
            {capture name="fallback"}
                <span class="h1 center-block">
                    {g->text text="Download %s" arg1=$theme.sourceImage.itemTypeName.1}
                </span>
                <a href="{g->url arg1="view=core.DownloadItem" arg2="itemId=`$theme.item.id`"
                forceFullUrl=true forceSessionId=true}" class="text-center link-{$theme.sourceImage.entityType}">
                    <h2>
                    {if !empty($theme.item.title)}
                        {$theme.item.title|markup}
                    {else}
                        {g->text text="Download %s" arg1=$theme.sourceImage.itemTypeName.1}
                    {/if}
                    </h2>
                </a>
            {/capture}

            {if $image.viewInline}
                {if count($theme.imageViews) > 1}
                    {capture assign="imageViewLink"}
                        {if $theme.imageViewsIndex==1 && count($theme.imageViews)==2}
                            <a href="{g->url params=$theme.pageUrl arg1="itemId=`$theme.item.id`"}">
                        {else}
                            {assign var="imageViewsLink" value=$theme.imageViewsIndex+1}
                            {if $imageViewsLink==count($theme.imageViews)}
                                {assign var="imageViewsLink" value=$theme.imageViewsIndex-1}
                            {/if}
                            <a href="{g->url params=$theme.pageUrl arg1="itemId=`$theme.item.id`"
                        arg2="imageViewsIndex=`$imageViewsLink`"}">
                        {/if}
                    {/capture}
                {/if}
                {if isset($theme.photoFrame)}
                    {g->container type="imageframe.ImageFrame" frame=$theme.photoFrame
                width=$image.width height=$image.height}
                    {if isset($imageViewLink)}{$imageViewLink}{/if}
                    {g->image id="%ID%" item=$theme.item image=$image
                fallback=$smarty.capture.fallback class="%CLASS%"}
                    {if isset($imageViewLink)}</a>{/if}
                {/g->container}
                {else}
                    {if isset($imageViewLink)}{$imageViewLink}{/if}
                    {g->image class="photo" item=$theme.item image=$image fallback=$smarty.capture.fallback}
                    {if isset($imageViewLink)}</a>{/if}
                {/if}
            {else}
                {$smarty.capture.fallback}
            {/if}
        {else}
            {g->text text="There is nothing to view for this item."}
        {/if}

    </div>
    {if $boxesLayout == "right" }
    {* Show any other photo blocks (comments, exif etc) *}
    <div class="sidebar-{$boxesLayout} col-xs-12 col-sm-4 ">
        <div class="photo-blocks ">
            {* Download link for item in original format *}
            {if !empty($theme.sourceImage) && $theme.sourceImage.mimeType != $theme.item.mimeType}
                <div class="gbBlock">
                    <a href="{g->url arg1="view=core.DownloadItem" arg2="itemId=`$theme.item.id`"}">
                        {g->text text="Download %s in original format" arg1=$theme.sourceImage.itemTypeName.1}
                    </a>
                </div>
            {/if}
            {foreach from=$theme.params.photoBlocks item=block}
                {g->block class="gbBlock col-xs-12 col-md-12 col-lg-12" type=$block.0 params=$block.1}
            {/foreach}
        </div>
    </div>
    {/if}
    {if $theme.pageUrl.view != 'core.ShowItem' && $theme.params.dynamicLinks == 'jumplink'}
        <div class="gbBlock">
            <a href="{g->url arg1="view=core.ShowItem" arg2="itemId=`$theme.item.id`"}">
                {g->text text="View in original album"}
            </a>
        </div>
    {/if}


</div>
{* Footer *}
<div class="container-fluid">
    <div class="giTitle-wrapper row-fluid clearfix">
        <div class="giTitle col-xs-12 col-sm-8">
            {if !empty($theme.item.title)}
                <h2> {$theme.item.title|markup} </h2>
            {/if}
            {if !empty($theme.item.description)}
                <p class="giDescription">
                    {$theme.item.description|markup}
                </p>
            {/if}
        </div>
        <div class="giInfo-wrapper hidden-xs pull-right">
            {g->block type="core.ItemInfo"
            item=$theme.item
            showDate=true
            showOwner=$theme.params.showImageOwner
            class="giInfo"}
            {g->block type="core.PhotoSizes" class="giInfo"}
        </div>

    </div>
    {if $boxesLayout == "bottom" }
        {* Show any other photo blocks (comments, exif etc) *}
        <div class="row-fluid sidebar-bottom">
            <div class="photo-blocks sidebar-{$boxesLayout}">
                {foreach from=$theme.params.photoBlocks item=block}
                    {g->block class="gbBlock col-xs-12 col-md-6 col-lg-3" type=$block.0 params=$block.1}
                {/foreach}
            </div>
        </div>
    {/if}

</div>
<div class="row-fluid">
    {g->block type="core.GuestPreview" class="gbBlock col-xs-12"}
</div>
{* Our emergency edit link, if the user removes all blocks containing edit links *}
{g->block type="core.EmergencyEditItemLink" class="gbBlock row-fluid" checkBlocks="sidebar,photo"}

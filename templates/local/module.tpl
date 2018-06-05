{*
 * $Revision: 16235 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}

<div class="theme-body panel panel-default gcBackground1 ">
    <div class="gHeader panel-heading clearfix">
        {$theme.header}
    </div>
    <div class="gbBlock panel-body">
        {if !empty($theme.params.sidebarBlocks)}
        <div class="col-xs-12 col-sm-12 col-md-2">
            <div id="gsSidebarCol">
                {g->theme include="sidebar.tpl"}
            </div>
        </div>
        {/if}

        <div class="col-xs-12 col-sm-12 col-md-10">
            {include file="gallery:`$theme.moduleTemplate`" l10Domain=$theme.moduleL10Domain}
        </div>
    </div>
</div>


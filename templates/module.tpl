{*
 * $Revision: 16235 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}

<div class="module-body panel panel-default gcBackground1 ">
    <div class="gbBlock panel-body">
{* {literal}
        {if !empty($theme.params.sidebarBlocks)}
        <div class="col-xs-12 col-sm-12 col-md-2">
            <div id="gsSidebarCol">
                {g->theme include="sidebar.tpl"}
            </div>
        </div>
        {/if}
{/literal} *}

        <div class="col-xs-12">
            {include file="gallery:`$theme.moduleTemplate`" l10Domain=$theme.moduleL10Domain}
        </div>
    </div>
</div>


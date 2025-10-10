{*
 * $Revision: 17075 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<div id="gsSidebar" class="btn-group pull-right">
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
          aria-haspopup="true" aria-expanded="false">
    <span class="sr-only">Toggle navigation</span>
    <span class="">{g->text text="Actions"}</span>
  </button>

  <ul class="dropdown-menu dropdown-actions">
  {* Show the sidebar blocks chosen for this theme *}
  {foreach from=$theme.params.sidebarBlocks item=block}
    {g->block type=$block.0 params=$block.1 class="gbBlock"}
  {/foreach}
  </ul>
</div>
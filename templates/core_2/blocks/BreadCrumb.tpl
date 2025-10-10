<div class="{$class} btn-group">
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <span class="glyphicon glyphicon-home"></span>
  </button>
  <ul class="dropdown-menu">
      {strip}
    {foreach name=parent from=$theme.parents item=parent}
    <li>
    <a href="{g->url params=$parent.urlParams}" class="BreadCrumb-{counter name="BreadCrumb"}">{$parent.title|markup:strip|default:$parent.pathComponent}</a>
    </li>
    {if isset($separator)} {$separator} {/if}
    {/foreach}
  {if ($theme.pageType == 'admin' || $theme.pageType == 'module')}
  <a href="{g->url arg1="view=core.ShowItem"
		   arg2="itemId=`$theme.item.id`"}" class="BreadCrumb-{counter name="BreadCrumb"}">
     {$theme.item.title|markup:strip|default:$theme.item.pathComponent}</a>
  {else}
  <li><a href="#" class="BreadCrumb-{counter name="BreadCrumb"} disabled">
     {$theme.item.title|markup:strip|default:$theme.item.pathComponent}</a></li>
  {/if}
  {/strip}
  </ul>
</div>

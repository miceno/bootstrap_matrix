{*
 * $Revision: 16297 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{if !isset($showCloud) }{assign var=showCloud value=false}{/if}
{if !isset($showHeader) }{assign var=showHeader value=true}{/if}
{if !isset($forItem) }{assign var=forItem value=true}{/if}
{if $forItem} {* Links for keywords of current item *}
{if empty($item)} {assign var=item value=$theme.item} {/if}

{if !empty($item.keywords)}
{g->callback type="keyalbum.SplitKeywords" keywords=$item.keywords}
<div class="{$class}">
    {if isset($showHeader) && $showHeader}
        <div class="block-expandable-header">
            <span class="glyphicon glyphicon-tags" aria-hidden="true"></span>
            <span class="hidden-xs">{g->text text="Keywords" l10Domain="themes_bootstrap_matrix"}</span>
        </div>
    {/if}
    <div class="block-expandable-content">
  {foreach from=$block.keyalbum.keywords key=rawKeyword item=keyword name=keywords}
    {strip}
        <a href="{g->url arg1="view=keyalbum.KeywordAlbum" arg2="keyword=$rawKeyword"|ireplace:'/':'_'
    arg3="highlightId=`$item.id`"}" class="link-keyword">
        <span class="label label-primary">{$keyword}</span>
        </a>
    {/strip}
  {/foreach}
    </div>
</div>
{/if}

{else} {* Select box or cloud for all available keywords *}
{g->callback type="keyalbum.LoadKeywords"
	     onlyPublic=$onlyPublic|default:true sizeLimit=$sizeLimit|default:0
	     maxCloudFontEnlargement=$maxCloudFontEnlargement|default:3
	     includeFrequency=$showCloud}

{if !empty($block.keyalbum.keywords)}
<div class="{$class}">
    <div class="block-expandable-header">
    {g->text text="Keyword cloud" l10Domain="themes_bootstrap_matrix"}
    </div>
  {if $showCloud}
    {foreach from=$block.keyalbum.keywords item=keyword}
      &nbsp;<a href="{g->url arg1="view=keyalbum.KeywordAlbum" arg2="keyword=`$keyword.raw`"}"{if
	     !empty($keyword.weight)} style="font-size: {$keyword.weight}em;"{/if}>
	  {$keyword.name}
      </a>&nbsp;
    {/foreach}
  {else}
  <select onchange="if (this.value) {ldelim} var newLocation = this.value; this.options[0].selected = true; location.href = newLocation; {rdelim}">
    <option value="">
      {g->text text="&laquo; Keyword Album &raquo;" l10Domain="themes_bootstrap_matrix"}
    </option>
    {foreach from=$block.keyalbum.keywords item=keyword}
      <option value="{g->url arg1="view=keyalbum.KeywordAlbum" arg2="keyword=`$keyword.name`"}">
	{$keyword.name}
      </option>
    {/foreach}
  </select>
  {/if}
</div>
{/if}
{/if}

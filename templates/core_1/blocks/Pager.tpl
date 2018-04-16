{*
 * $Revision: 16235 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}

<script language="JavaScript" type="text/JavaScript">
    {literal}
    <!--
    function MM_jumpMenu(targ, selObj, restore) {
        eval(targ + ".location='" + selObj.options[selObj.selectedIndex].value + "'");
        if (restore) selObj.selectedIndex = 0;
    }

    -->
    {/literal}
</script>


{* <nav class="{$class}" aria-label="{g->text text="Page navigation"}"> *}
{* {g->text text="Page:"} *}
{assign var="lastPage" value=0}
{foreach name=jumpRange from=$theme.jumpRange item=page}
    {if ($page - $lastPage >= 2)}
        <li>
            {if ($page - $lastPage == 2)}
                <a href="{g->url params=$theme.pageUrl arg1="page=`$page-1`"}">{$page-1}</a>
            {else}
                ...
            {/if}
        </li>
    {/if}
    <li><span>
    {if ($theme.currentPage == $page)}
        <form name="form" class="form-inline">
          {assign var="page" value=1}
            <select class="form-control" name="jumpMenu" onchange="MM_jumpMenu('parent',this,0)">
              {section name=selectPage loop=$theme.totalPages}
                  <option value="{g->url params=$theme.pageUrl arg1="page=$page"}"
                          {if $page==$theme.currentPage}selected="selected"{/if}>{$page}</option>
                  {assign var="page" value=$page+1}
              {/section}
            </select>
        </form>

{else}

        <a href="{g->url params=$theme.pageUrl arg1="page=$page"}">{$page}</a>
    {/if}
  </span></li>
    {assign var="lastPage" value=$page}
{/foreach}
{* </nav> *}


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


<li class="active">
<span class="jump-pager">
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
</span>
</li>

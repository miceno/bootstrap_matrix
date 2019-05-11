{*
 * $Revision: 17380 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<div class="gbBlock gcBackground1">
    <h2> {g->text text="Delete Items"} </h2>
</div>

{if (isset($status.deleted))}
    <div class="gbBlock">
        {if ($status.deleted.count == 0)}
        <h2 class="giError">
            {g->text text="No items were selected for deletion"}
            {else}
            <h2 class="giSuccess">
                {g->text one="Successfully deleted %d item" many="Successfully deleted %d items"
                count=$status.deleted.count arg1=$status.deleted.count}
                {/if}
            </h2>
    </div>
{/if}

{capture assign="form_buttons"}
    <div class="gbBlock form-buttons">
        <input type="button" class="btn btn-default" onclick="setCheck(1)"
               name="{g->formVar var="form[action][checkall]"}" value="{g->text text="Check All"}"/>
        <input type="button" class="btn btn-default" onclick="setCheck(0)"
               name="{g->formVar var="form[action][checknone]"}" value="{g->text text="Check None"}"/>
        <input type="button" class="btn btn-default" onclick="invertCheck()"
               name="{g->formVar var="form[action][invert]"}" value="{g->text text="Invert"}"/>

        {if ($ItemDelete.page > 1)}
            <input type="submit" class="btn btn-default"
                   name="{g->formVar var="form[action][previous]"}" value="{g->text text="Previous Page"}"/>
        {/if}
        {if ($ItemDelete.page < $ItemDelete.numPages)}
            <input type="submit" class="btn btn-default"
                   name="{g->formVar var="form[action][next]"}" value="{g->text text="Next Page"}"/>
        {/if}
    </div>
    <div class="gbBlock">
        <input type="submit" class="btn btn-danger"
               name="{g->formVar var="form[action][delete]"}" value="{g->text text="Delete"}"/>
        {if $ItemDelete.canCancel}
        <input type="submit" class="btn btn-default"
               name="{g->formVar var="form[action][cancel]"}" value="{g->text text="Cancel"}"/>
        {/if}
    </div>
{/capture}

<div class="gbBlock">
    {if empty($ItemDelete.peers)}
    <p class="giDescription">
        {g->text text="This album contains no items to delete"}
    </p>
    {else}
    <p class="giDescription">
        {g->text text="Choose the items you want to delete"}
        {if ($ItemDelete.numPages > 1) }
            {g->text text="(page %d of %d)" arg1=$ItemDelete.page arg2=$ItemDelete.numPages}
            <br/>
            {g->text text="Items selected here will remain selected when moving between pages."}
            {if !empty($ItemDelete.selectedIds)}
                <br/>
                {g->text one="One item selected on other pages." many="%d items selected on other pages."
            count=$ItemDelete.selectedIdCount arg1=$ItemDelete.selectedIdCount}
            {/if}
        {/if}
    </p>

    <input type="hidden" name="{g->formVar var="page"}" value="{$ItemDelete.page}"/>
    <input type="hidden" name="{g->formVar var="form[formname]"}" value="DeleteItem"/>

    <script type="text/javascript">
        // <![CDATA[
        function setCheck(val) {ldelim}
            var frm = document.getElementById('itemAdminForm');
            {foreach from=$ItemDelete.peers item=peer}
            frm.elements['g2_form[selectedIds][{$peer.id}]'].checked = val;
            {/foreach}
            {rdelim}

        function invertCheck(val) {ldelim}
            var frm = document.getElementById('itemAdminForm');
            {foreach from=$ItemDelete.peers item=peer}
            frm.elements['g2_form[selectedIds][{$peer.id}]'].checked =
                !frm.elements['g2_form[selectedIds][{$peer.id}]'].checked;
            {/foreach}
            {rdelim}

        // ]]>
    </script>

    {$form_buttons}

    <div class="item-action-matrix table clearfix">
    {foreach from=$ItemDelete.peers item=peer}
        {assign var="peerItemId" value=$peer.id}
        <div class="table-row col-xs-12 col-sm-6 col-md-4 col-lg-3">
            <div class="table-column thumbnail-wrapper" align="center">
            <label for="cb_{$peerItemId}" class="giTitle">
                {if isset($peer.thumbnail)}
                    {g->image item=$peer image=$peer.thumbnail maxSize=50 class="giThumbnail"}
                {else}
                    <img width="100%" height="100%" src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7">
                {/if}
                <input class="checkbox" type="checkbox" id="cb_{$peerItemId}"
                       {if $peer.selected}checked="checked" {/if}
                       name="{g->formVar var="form[selectedIds][$peerItemId]"}"/>
                <div class="thumbnail-description-wrapper">
                    <p class="giTitle">
                        {$peer.title|markup:strip|default:$peer.pathComponent}
                    </p>
                    <i>
                        {if isset($ItemDelete.peerTypes.data[$peer.id])}
                            {g->text text="(data)"}
                        {/if}
                        {if isset($ItemDelete.peerTypes.album[$peer.id])}
                            {if isset($ItemDelete.peerDescendentCounts[$peer.id])}
                                {g->text one="(album containing %d item)" many="(album containing %d items)"
                            count=$ItemDelete.peerDescendentCounts[$peer.id]
                            arg1=$ItemDelete.peerDescendentCounts[$peer.id]}
                            {else}
                                {g->text text="(empty album)"}
                            {/if}
                        {/if}
                    </i>
                </div>
            </label>
        </div></div>
    {/foreach}

    </div>

    {foreach from=$ItemDelete.selectedIds item=selectedId}
        <input type="hidden" name="{g->formVar var="form[selectedIds][$selectedId]"}" value="on"/>
    {/foreach}
    <input type="hidden" name="{g->formVar var="form[numPerPage]"}" value="{$ItemDelete.numPerPage}"/>

    {$form_buttons}

</div>
{/if}


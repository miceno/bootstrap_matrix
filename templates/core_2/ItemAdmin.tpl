{*
 * $Revision: 17075 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}

<form action="{g->url}" method="post" enctype="{$ItemAdmin.enctype}" id="itemAdminForm">
    <div>
        {g->hiddenFormVars}
        {if !empty($controller)}
            <input type="hidden" name="{g->formVar var="controller"}" value="{$controller}"/>
        {/if}
        {if !empty($form.formName)}
            <input type="hidden" name="{g->formVar var="form[formName]"}" value="{$form.formName}"/>
        {/if}
        <input type="hidden" name="{g->formVar var="itemId"}" value="{$ItemAdmin.item.id}"/>
    </div>

    <div class="admin-container">
        <div class="row">
            <div id="gsSidebarCol" class="col-xs-12 col-md-3">
                <div id="gsSidebar" class="gcBorder1">
                    {if $ItemAdmin.item.parentId or !empty($ItemAdmin.thumbnail)}
                        <div class="gbBlock col-xs-6 col-sm-12">
                            {capture assign=linkUrl}{g->url arg1="view=core.ShowItem" arg2="itemId=`$ItemAdmin.item.id`"}{/capture}
                            {if empty($ItemAdmin.thumbnail)}
                                <a href="{$linkUrl}">
                                    <img src="/install/images/background.png" class="giThumbnail gcPhotoImage"
                                         title="{g->text text="No Thumbnail"}" alt='{g->text text="No Thumbnail"}'/>
                                </a>
                            {else}
                                <a href="{$linkUrl}">
                                    {g->image item=$ItemAdmin.item image=$ItemAdmin.thumbnail class="giThumbnail"}
                                </a>
                            {/if}
                            <h3> {$ItemAdmin.item.title|markup} </h3>
                        </div>
                    {/if}

                    <div class="gbBlock col-xs-6 col-sm-12 parents">
                        <h2> {g->text text="Folders"} </h2>
                        <ul class="">
                            {strip}
                                {foreach name=parent from=$theme.parents item=parent}
                                    <li>
                                        <a href="{g->url params=$parent.urlParams}" class="parents-{counter name="BreadCrumb"}">{$parent.title|markup:strip|default:$parent.pathComponent}</a>
                                    </li>
                                    {if isset($separator)} {$separator} {/if}
                                {/foreach}

                            {/strip}
                        </ul>
                    </div>
                    <div class="gbBlock col-xs-6 col-sm-12">
                        <h2> {g->text text="Options"} </h2>
                        <ul>
                            {foreach from=$ItemAdmin.subViewChoices key=choiceName item=choiceParams}
                                <li class="{g->linkId urlParams=$choiceParams}">
                                    {if isset($choiceParams.active)}
                                        {$choiceName}
                                    {else}
                                        {assign var=script value=$choiceParams.script|default:""}
                                        {if isset($choiceParams.script)}
                                            {assign var=choiceParams
                                            value=$ItemAdmin.unsetCallback|@call_user_func:$choiceParams:"script"}
                                        {/if}
                                        <a href="{g->url params=$choiceParams}"{if !empty($script)} onclick="{$script}"{/if}> {$choiceName} </a>
                                    {/if}
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>

            <div id="admin-content" class="col-xs-12 col-md-9">
                <div id="gsContent" class="gcBorder1">
                    {include file="gallery:`$ItemAdmin.viewBodyFile`" l10Domain=$ItemAdmin.viewL10Domain}
                </div>
            </div>
        </div>
    </div>
</form>

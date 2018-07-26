{*
 * $Revision: 17380 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<style>
    {literal}

    .options-wrapper {
        margin: 0.5em 0;
    }
    {/literal}
</style>
<form id="SearchScan" action="{g->url}" method="get">
    <div id="gsContent" class="gcBorder1">
        {g->hiddenFormVars}
        <input type="hidden" name="{g->formVar var="controller"}" value="{$SearchScan.controller}"/>
        <input type="hidden" name="{g->formVar var="form[formName]"}" value="SearchScan"/>

        <script type="text/javascript">
            // <![CDATA[
            var search_options = [
            {foreach from=$SearchScan.modules key=moduleId item=moduleInfo}
            {foreach from=$moduleInfo.options key=optionId item=optionInfo}
            'cb_{$moduleId}_{$optionId}',
            {/foreach}
            {/foreach}];

            {literal}
            function setCheck(val) {
                for (var i = 0; i < search_options.length; i++)
                {
                    document.getElementById(search_options[i]).checked = val;
                }
                return false;
            }

            function invertCheck() {
                var o;

                for (var i = 0; i < search_options.length; i++) {
                    o = document.getElementById(search_options[i]);
                    o.checked = !o.checked;
                }
                return false;
                }
            {/literal}
            // ]]>
        </script>

        {* search form*}
        <div class="gbBlock form-group">
            <div class="input-wrapper input-group col-xs-12 col-md-6">
                <input type="text"
                       size="50"
                       class="form-control"
                       title="{$form.searchCriteria}"
                       aria-label="{$form.searchCriteria}"
                       name="{g->formVar var="form[searchCriteria]"}"
                       value="{$form.searchCriteria}"/>
                <div class="input-group-btn">
                    <input type="submit" class="btn btn-primary"
                           name="{g->formVar var="form[action][search]"}" value="{g->text text="Search"}"/>
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false">
                        <span class="glyphicon glyphicon-wrench"></span></button>
                    <ul class="dropdown-menu">
                        {foreach from=$SearchScan.modules key=moduleId item=moduleInfo}
                            {foreach from=$moduleInfo.options key=optionId item=optionInfo}
                                <li>
                                <a href="#">
                                    <label for="cb_{$moduleId}_{$optionId}">
                                <input type="checkbox" id="cb_{$moduleId}_{$optionId}"
                                       name="{g->formVar var="form[options][$moduleId][$optionId]"}"
                                        {if isset($form.options.$moduleId.$optionId)} checked="checked"{/if}/>
                                    {$optionInfo.description}
                                </label></a>
                            </li>{/foreach}
                        {/foreach}
                        <li><a href="#" onclick="javascript:event.stopPropagation();setCheck(1); return false;">{g->text text="Check All"}</a></li>
                        <li><a href="#" onclick="javascript:event.stopPropagation();setCheck(0); return false;">{g->text text="Uncheck All"}</a></li>
                        <li><a href="#" onclick="javascript:event.stopPropagation();invertCheck()">{g->text text="Invert"}</a></li>
                    </ul>
                </div>
            </div>
            {if isset($form.error.searchCriteria.missing)}
                <div class="giError">
                    {g->text text="You must enter some text to search for!"}
                </div>
            {/if}
            <div class="options-wrapper">

            </div>

        </div>
        <script type="text/javascript">
            document.getElementById('SearchScan')['{g->formVar var="form[searchCriteria]"}'].focus();
        </script>
        {* Search results *}
        {assign var="resultCount" value="0"}
        {if !empty($SearchScan.searchResults)}
            {foreach from=$SearchScan.searchResults key=moduleId item=results}
                {assign var="resultCount" value=$resultCount+$results.count}
                <div class="gbBlock row">
                    <h4>
                        {$SearchScan.modules.$moduleId.name}
                        {if ($results.count > 0)}
                            {g->text text="Results %d - %d" arg1=$results.start arg2=$results.end}
                        {/if}
                        {if ($results.count > $results.end)}
                            {assign var="moduleId" value=$moduleId}
                            &nbsp;
                            <input type="submit" class="btn btn-info"
                                   name="{g->formVar var="form[action][showAll][$moduleId]"}"
                                   value="{g->text text="Show all %d" arg1=$results.count}"/>
                        {/if}
                    </h4>

                    {assign var="searchCriteria" value=$form.searchCriteria}
                    {if (sizeof($results.results) > 0)}
                    <div id="gsThumbMatrix" class="col-xs-12">
                        {foreach from=$results.results item=result}
                            {assign var=itemId value=$result.itemId}
                            <div class="giItemCell col-xs-12 col-sm-6 col-md-4 col-lg-3">
                            <div class="thumbnail-wrapper {if
                            $SearchScan.items.$itemId.canContainChildren}gbItemAlbum{else}gbItemImage{/if}">
                                <a href="{g->url arg1="view=core.ShowItem" arg2="itemId=$itemId"}">
                                    {if isset($SearchScan.thumbnails.$itemId)}
                                        {g->image item=$SearchScan.items.$itemId image=$SearchScan.thumbnails.$itemId
                                    class="giThumbnail"}
                                    {else}
                                        <img src="/install/images/background.png" class="giThumbnail gcPhotoImage"
                                             title="{g->text text="No Thumbnail"}" alt='{g->text text="No Thumbnail"}'/>
                                    {/if}
                                </a>
                                <ul class="giInfo action-list">
                                    {foreach from=$result.fields item=field}
                                        {if isset($field.value)}
                                            <li>
                                                <span class="ResultKey result-key-{$field.field|lower}">{$field.key}:</span>
                                                <span class="ResultIcon result-key-{$field.field|lower}"></span>
                                                <span class="result-data-{$field.field|lower} ResultData">{$field.value|default:"&nbsp;"|markup}</span>
                                            </li>
                                        {/if}
                                    {/foreach}
                                </ul>
                            </div>
                            </div>
                        {/foreach}
                    </div>
                        <script type="text/javascript">
                            search_HighlightResults('{$searchCriteria}');
                        </script>
                    {else}
                        <p class="giDescription">
                            {g->text text="No results found for"} '{$form.searchCriteria}'
                        </p>
                    {/if}
                </div>
            {/foreach}
        {/if}

        {if $resultCount>0 && $SearchScan.slideshowAvailable}
            <div class="gbBlock gcBackground1">
                <input type="submit" class="btn btn-default"
                       name="{g->formVar var="form[action][slideshow]"}"
                       value="{g->text text="View these results in a slideshow"}"/>
            </div>
        {/if}
    </div>
</form>

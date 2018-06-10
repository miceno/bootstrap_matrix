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
<form id="SearchScan" action="{g->url}" method="post">
    <div id="gsContent" class="gcBorder1">
        {* header *}
        <div class="gbBlock gcBackground1 gHeader">
            <h2> {g->text text="Search the Gallery"} </h2>
        </div>

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
            }

            function invertCheck() {
                var o;

                for (var i = 0; i < search_options.length; i++) {
                    o = document.getElementById(search_options[i]);
                    o.checked = !o.checked;
                }
                }
            {/literal}
            // ]]>
        </script>

        {* search form*}
        <div class="gbBlock">
            <div class="input-wrapper">
                <input type="text" size="50"
                       name="{g->formVar var="form[searchCriteria]"}" value="{$form.searchCriteria}"/>
                <script type="text/javascript">
                    document.getElementById('SearchScan')['{g->formVar var="form[searchCriteria]"}'].focus();
                </script>
                <input type="submit" class="inputTypeSubmit"
                       name="{g->formVar var="form[action][search]"}" value="{g->text text="Search"}"/>

                {if isset($form.error.searchCriteria.missing)}
                    <div class="giError">
                        {g->text text="You must enter some text to search for!"}
                    </div>
                {/if}
            </div>
            <div class="options-wrapper">

                {foreach from=$SearchScan.modules key=moduleId item=moduleInfo}
                    {foreach from=$moduleInfo.options key=optionId item=optionInfo}
                        <input type="checkbox" id="cb_{$moduleId}_{$optionId}"
                               name="{g->formVar var="form[options][$moduleId][$optionId]"}"
                                {if isset($form.options.$moduleId.$optionId)} checked="checked"{/if}/>
                        <label for="cb_{$moduleId}_{$optionId}">
                            {$optionInfo.description}
                        </label>
                    {/foreach}
                {/foreach}
                <div>
                    <a href="javascript:setCheck(1)">{g->text text="Check All"}</a>
                    &nbsp;
                    <a href="javascript:setCheck(0)">{g->text text="Uncheck All"}</a>
                    &nbsp;
                    <a href="javascript:invertCheck()">{g->text text="Invert"}</a>
                </div>
            </div>

        </div>

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
                            <input type="submit" class="inputTypeSubmit"
                                   name="{g->formVar var="form[action][showAll][$moduleId]"}"
                                   value="{g->text text="Show all %d" arg1=$results.count}"/>
                        {/if}
                    </h4>

                    {assign var="searchCriteria" value=$form.searchCriteria}
                    {if (sizeof($results.results) > 0)}
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
                                        {g->text text="No thumbnail"}
                                    {/if}
                                </a>
                                <ul class="giInfo action-list">
                                    {foreach from=$result.fields item=field}
                                        {if isset($field.value)}
                                            <li>
                                                <span class="label label-default ResultKey">{$field.key}:</span>
                                                <span class="ResultData">{$field.value|default:"&nbsp;"|markup}</span>
                                            </li>
                                        {/if}
                                    {/foreach}
                                </ul>
                            </div>
                            </div>
                        {/foreach}
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
                <input type="submit" class="inputTypeSubmit"
                       name="{g->formVar var="form[action][slideshow]"}"
                       value="{g->text text="View these results in a slideshow"}"/>
            </div>
        {/if}
    </div>
</form>

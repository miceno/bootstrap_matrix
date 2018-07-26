{*
 * $Revision: 16235 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<form id="SearchShowAll" action="{g->url}" method="get">
    <div id="gsContent" class="gcBorder1">
        {* header *}
        <div class="gbBlock gcBackground1 gHeader hidden">
            <h2>
                {g->text text="%s Search Results for " arg1=$SearchShowAll.moduleInfo.name}
                '{$form.searchCriteria}'
            </h2>
        </div>

        {g->hiddenFormVars}
        <input type="hidden"
               name="{g->formVar var="controller"}" value="{$SearchShowAll.controller}"/>
        <input type="hidden" name="{g->formVar var="form[formName]"}" value="SearchShowAll"/>
        <input type="hidden" name="{g->formVar var="form[moduleId]"}" value="{$form.moduleId}"/>
        <input type="hidden" name="{g->formVar var="form[page]"}" value="{$form.page}"/>

        <script type="text/javascript">
            // <![CDATA[
            var search_options = [
                {strip}
                {foreach from=$SearchShowAll.moduleInfo.options key=optionId item=optionInfo}
                'cb_{$optionId}',
                {/foreach} ];
            {/strip}

            {literal}
            function setCheck(val) {
                for (var i = 0; i < search_options.length; i++) {
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
            }
            {/literal}
            // ]]>
        </script>

        <div class="gbBlock form-group">
            <div class="input-wrapper input-group col-xs-12 col-md-6">
                <input type="text" size="50"
                       class="form-control"
                       title="{g->text text='Search Criteria'}"
                       aria-label="{g->text text='Search Criteria'}"
                       name="{g->formVar var="form[searchCriteria]"}"
                       value="{$form.searchCriteria}"/>
                <div class="input-group-btn">
                    <input type="submit" class="btn btn-primary"
                           name="{g->formVar var="form[action][search]"}" value="{g->text text="Search"}"/>
                    {if !empty($SearchShowAll.results)}
                        <input type="submit" class="btn btn-info"
                               name="{g->formVar var="form[action][scan]"}"
                               value="{g->text text="Search All Modules"}"/>
                    {/if}
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false">
                        <span class="glyphicon glyphicon-wrench"></span></button>
                    <ul class="dropdown-menu">
                        {foreach from=$SearchShowAll.moduleInfo.options key=optionId item=optionInfo}
                            <li>
                            <a href="#">
                                <label for="cb_{$optionId}">
                                    <input id="cb_{$optionId}" type="checkbox"
                                       name="{g->formVar var="form[options][`$SearchShowAll.moduleId`][$optionId]"}"
                                       {if isset($form.options[$SearchShowAll.moduleId].$optionId)}checked="checked"{/if}/>

                                    {$optionInfo.description}
                                </label>
                            </a>
                            </li>
                        {/foreach}
                        <li><a href="#" onclick="javascript:event.stopPropagation();setCheck(1); return false;">{g->text text="Check All"}</a></li>
                        <li><a href="#" onclick="javascript:event.stopPropagation();setCheck(0); return false;">{g->text text="Uncheck All"}</a></li>
                        <li><a href="#" onclick="javascript:event.stopPropagation();invertCheck()">{g->text text="Invert"}</a></li>
                    </ul>


                </div>
            </div>
            <script type="text/javascript">
                document.getElementById('SearchShowAll')['{g->formVar var="form[searchCriteria]"}'].focus();
            </script>
            <input type="hidden"
                   name="{g->formVar var="form[lastSearchCriteria]"}" value="{$form.searchCriteria}"/>
            {if isset($form.error.searchCriteria.missing)}
                <div class="giError">
                    {g->text text="You must enter some text to search for!"}
                </div>
            {/if}
        </div>

        {* Search results *}
        {if !empty($SearchShowAll.results)}
        <div class="gbBlock">
            <h4 class="">
                {$SearchShowAll.moduleInfo.name}
                {if ($SearchShowAll.results.count > 0)}
                    {g->text text="Results %d - %d of %d, Page %d of %d"
                arg1=$SearchShowAll.results.start arg2=$SearchShowAll.results.end
                arg3=$SearchShowAll.results.count arg4=$form.page arg5=$SearchShowAll.maxPages}
                {/if}
                {if ($form.page > 1)}
                    <input type="submit" class="btn btn-primary"
                           name="{g->formVar var="form[action][previousPage]"}"
                           value="{g->text text="&laquo; Back"}"/>
                {/if}
                {if ($form.page < $SearchShowAll.maxPages)}
                    <input type="submit" class="btn btn-primary"
                           name="{g->formVar var="form[action][nextPage]"}"
                           value="{g->text text="Next &raquo;"}"/>
                {/if}
            </h4>

            {if (sizeof($SearchShowAll.results.results) > 0)}
                <div id="gsThumbMatrix" class="col-xs-12">
                {foreach from=$SearchShowAll.results.results item=result}
                {assign var=itemId value=$result.itemId}
                <div class="giItemCell col-xs-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="thumbnail-wrapper {if
                $SearchShowAll.items.$itemId.canContainChildren}gbItemAlbum{else}gbItemImage{/if}">
                    <a href="{g->url arg1="view=core.ShowItem" arg2="itemId=$itemId"}">
                        {if isset($SearchShowAll.thumbnails.$itemId)}
                            {g->image item=$SearchShowAll.items.$itemId
                        image=$SearchShowAll.thumbnails.$itemId class="giThumbnail"}
                        {else}
                            <img src="/install/images/background.png" class="giThumbnail gcPhotoImage"
                                 title="{g->text text="No Thumbnail"}" alt='{g->text text="No Thumbnail"}'/>
                        {/if}
                    </a>
                    <ul class="giInfo action-list">
                        {foreach from=$result.fields item=field}
                            <li>
                                <span class="ResultKey result-key-{$field.field|lower}">{$field.key}:</span>
                                <span class="ResultIcon result-key-{$field.field|lower}"></span>
                                <span class="result-data-{$field.field|lower} ResultData">{$field.value|default:"&nbsp;"|markup}</span>
                            </li>
                        {/foreach}
                    </ul>
                    </div>
                </div>
                {/foreach}
</div>                <script type="text/javascript">
                    search_HighlightResults('{$form.searchCriteria}');
                </script>
                <h4 class="">
                    {$SearchShowAll.moduleInfo.name}
                    {if ($SearchShowAll.results.count > 0)}
                        {g->text text="Results %d - %d of %d, Page %d of %d"
                    arg1=$SearchShowAll.results.start arg2=$SearchShowAll.results.end
                    arg3=$SearchShowAll.results.count arg4=$form.page arg5=$SearchShowAll.maxPages}
                    {/if}
                    {if ($form.page > 1)}
                        <input type="submit" class="btn btn-primary"
                               name="{g->formVar var="form[action][previousPage]"}"
                               value="{g->text text="&laquo; Back"}"/>
                    {/if}
                    {if ($form.page < $SearchShowAll.maxPages)}
                        <input type="submit" class="btn btn-primary"
                               name="{g->formVar var="form[action][nextPage]"}"
                               value="{g->text text="Next &raquo;"}"/>
                    {/if}
                </h4>

            {else}
                <p class="giDescription">
                    {g->text text="No results found for"} '{$form.searchCriteria}'
                </p>
            {/if}
        </div>
        {/if}
    </div>
</form>

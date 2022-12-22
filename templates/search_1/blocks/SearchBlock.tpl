{*
 * $Revision: 17650 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{if !isset($showAdvancedLink)} {assign var="showAdvancedLink" value="false"} {/if}
{if !isset($inputWidth)} {assign var="inputWidth" value="18"} {/if}
{capture name="search_text"}{strip}
    {g->text text="Search your Gallery" l10Domain="themes_bootstrap_matrix"}
{/strip}{/capture}

{g->addToTrailer}
<script type="text/javascript">
  // <![CDATA[
  search_SearchBlock_init('{g->text text="Search your Gallery" l10Domain="themes_bootstrap_matrix" forJavascript=true}', '{g->text text="Please enter a search term." l10Domain="themes_bootstrap_matrix" forJavascript=true}', '{g->text text="Searching in progress, please wait!" l10Domain="themes_bootstrap_matrix" forJavascript=true}');
  // ]]>
</script>
{/g->addToTrailer}

<!-- <div class="{$class}"> -->
  <form id="search_SearchBlock" class="navbar-form navbar-left search-form" action="{g->url}" method="get" onsubmit="return search_SearchBlock_checkForm()">
      {g->hiddenFormVars}
      <input type="hidden" name="{g->formVar var="controller"}" value="search.SearchShowAll"/>
      <input type="hidden" name="{g->formVar var="form[formName]"}" value="SearchShowAll"/>
      <input type="hidden" name="{g->formVar var="form[action][showAll][GalleryCoreSearch]"}" value="1"/>
      <input type="hidden" name="{g->formVar var="form[options][GalleryCoreSearch][descriptions]"}" value="on"/>
      <input type="hidden" name="{g->formVar var="form[options][GalleryCoreSearch][keywords]"}" value="on"/>
      <input type="hidden" name="{g->formVar var="form[options][GalleryCoreSearch][summaries]"}" value="on"/>
      <input type="hidden" name="{g->formVar var="form[options][GalleryCoreSearch][titles]"}" value="on"/>
      <div class="search-form-group has-feedback form-group">
            <label for="searchCriteria" class="sr-only">{g->text text="Search" l10Domain="$l10Domain"}</label>
            <div class="input-group">
            {strip}
                <span class="input-group-btn">
                    <button id="{g->formVar var="form[searchCriteria]"}-search"
                            title="{$smarty.capture.search_text}"
                            aria-label="{$smarty.capture.search_text}"
                            class="btn btn-default" type="submit">
                        <span class="glyphicon glyphicon-search"></span>
                    </button>
                </span>
            {/strip}
                <input type="text" id="searchCriteria" size="{$inputWidth}"
                 name="{g->formVar var="form[searchCriteria]"}"
                 value="{$smarty.capture.search_text}"
                 placeholder="{$smarty.capture.search_text}"
                 onfocus="search_SearchBlock_focus()"
                 onblur="search_SearchBlock_blur()"
                 class="form-control textbox"/>
            </div>
      </div>
      <input class="hidden" type="hidden" name="{g->formVar var="form[useDefaultSettings]"}" value="1" />
  </form>



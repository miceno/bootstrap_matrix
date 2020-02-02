{*
 * $Revision: 17650 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{if !isset($showAdvancedLink)} {assign var="showAdvancedLink" value="false"} {/if}
{if !isset($inputWidth)} {assign var="inputWidth" value="18"} {/if}

{g->addToTrailer}
<script type="text/javascript">
  // <![CDATA[
  search_SearchBlock_init('{g->text text="Search your Gallery" forJavascript=true}', '{g->text text="Please enter a search term." forJavascript=true}', '{g->text text="Searching in progress, please wait!" forJavascript=true}');
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
            <label for="searchCriteria" class="sr-only">{g->text text="Search"}</label>
            <div class="input-group">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button>
                </span>
                <input type="text" id="searchCriteria" size="{$inputWidth}"
                 name="{g->formVar var="form[searchCriteria]"}"
                 value="{g->text text="Search your Gallery"}"
                 placeholder="{g->text text="Search your Gallery"}"
                 onfocus="search_SearchBlock_focus()"
                 onblur="search_SearchBlock_blur()"
                 class="form-control textbox"/>
            </div>
      </div>
      <input class="hidden" type="hidden" name="{g->formVar var="form[useDefaultSettings]"}" value="1" />
  </form>



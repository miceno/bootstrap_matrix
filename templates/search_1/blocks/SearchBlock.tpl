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
      <input type="hidden" name="{g->formVar var="view"}" value="search.SearchScan"/>
      <input type="hidden" name="{g->formVar var="form[formName]"}" value="search_SearchBlock"/>
      <div class="search-form-group has-feedback form-group">
            <label for="searchCriteria" class="sr-only">{g->text text="Search"}</label>
            <input type="text" id="searchCriteria" size="{$inputWidth}"
      	     name="{g->formVar var="form[searchCriteria]"}"
      	     value="{g->text text="Search your Gallery"}"
      	     placeholder="{g->text text="Search your Gallery"}"
      	     onfocus="search_SearchBlock_focus()"
      	     onblur="search_SearchBlock_blur()"
      	     class="form-control textbox"/>
        
            <span class="glyphicon glyphicon-search form-control-feedback"></span>
      </div>
      <input class="hidden" type="hidden" name="{g->formVar var="form[useDefaultSettings]"}" value="1" />
<!--    {if $showAdvancedLink}
      <a href="{g->url arg1="view=search.SearchScan" arg2="form[useDefaultSettings]=1"
		       arg3="return=1"}"
	 class="advanced">{g->text text="Advanced Search"}</a>
    {/if} -->
  </form>



{*
 * $Revision: 16235 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{assign var="class" value=$class|replace:"SystemLinks":"SystemLink"}
{assign var="order" value=$order|default:""|split}
{assign var="othersAt" value=$othersAt|default:0}
{assign var="othersAt" value=$othersAt-1}
{assign var="separator" value=$separator|default:""}

{capture name="SystemLinks"}
  {foreach from=$theme.systemLinks key=linkId item=link}
    {if !in_array($linkId, $order)}
    <li class="{$class}">
      <a href="{g->url params=$link.params}">{$link.text}</a>
    </li>
    {$separator}
    {/if}
  {/foreach}
{/capture}

<nav class="navbar navbar-nav">
  <div class="container-fluid">
	<div class="navbar-header navbar-right">
	  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#gallery-navbar-collapse-systemlinks" aria-expanded="false">
	    <span class="sr-only">Toggle navigation</span>
	    <span class="icon-bar"></span>
	    <span class="icon-bar"></span>
	    <span class="icon-bar"></span>
	  </button>
	</div>

	<div class="collapse navbar-collapse" id="gallery-navbar-collapse-systemlinks">
                {g->block type=search.SearchBlock showAdvancedLink=false inputWidth=18}
		<ul class="nav navbar-nav">
		{foreach from=$order key=index item=linkId}
		  {if $index==$othersAt}
		    {assign var="SystemLinksShown" value=true}
		    {$smarty.capture.SystemLinks}
		  {/if}
		  {if isset($theme.systemLinks[$linkId])}
		  <li class="{$class}">
		    <a href="{g->url
		       params=$theme.systemLinks[$linkId].params}">{$theme.systemLinks[$linkId].text}</a>
		  </li>
		  {/if}
		{/foreach}
		{if !isset($SystemLinksShown)}{$smarty.capture.SystemLinks}{/if}
		</ul>


	</div>
  </div> {* container-fluid *}
</nav>

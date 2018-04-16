{*
 * $Revision: 16235 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{if isset($reverseOrder) && $reverseOrder}
    {assign var="order" value="next-and-last current first-and-previous"}
{else}
    {assign var="order" value="first-and-previous current next-and-last"}
{/if}
{assign var="prefix" value=$prefix|default:""}
{assign var="suffix" value=$suffix|default:""}
{*
 * The strip calls in this tpl are to avoid a safari bug where padding-right is lost
 * in floated containers for elements that have whitespace before the closing tag.
 *}
<nav class="{$class} text-center" aria-label="{g->text text="Pagination"}">
    <ul class="pagination g-pagination">
        {foreach from=$order|split item="which"}
            {if $which=="next-and-last"}
                {strip}
                    {if isset($navigator.next)}    {* Uncomment to omit next when same as last:
	&& (!isset($navigator.last) || $navigator.next.urlParams != $navigator.last.urlParams)} *}
                        <li class="next">
                            <a href="{g->url params=$navigator.next.urlParams}" aria-label="{g->text text="next"}"
                            class="next">
                                <span class="sr-only">{g->text text="next"}{$suffix}</span>
                                <span class="glyphicon glyphicon-forward" aria-hidden="true"></span>
                            </a>
                        </li>
                    {else}
                        <li class="next disabled">
                            <span class="next">
                                <span aria-hidden="true">
                                    <span class="sr-only">{g->text text="next"}{$suffix}</span>
                                    <span class="glyphicon glyphicon-forward" aria-hidden="true"></span>
                                </span>
                            </span>
                        </li>
                    {/if}

                    {if isset($navigator.last)}
                        <li class="next">
                            <a href="{g->url params=$navigator.last.urlParams}" class="last"
                               aria-label="{g->text text="last"}">
                                <span class="sr-only">{g->text text="last"}{$suffix}</span>
                                <span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>
                            </a>
                        </li>
                    {else}
                        <li class="next disabled">
                            <span class="last">
                                <span aria-hidden="true">
                                    <span class="sr-only">{g->text text="last"}{$suffix}</span>
                                    <span class="glyphicon glyphicon-step-forward" aria-hidden="true"></span>
                                </span>
                            </span>
                        </li>
                    {/if}
                {/strip}
            {elseif $which=="current"}
                {g->block type="core.Pager"}
            {else}
                {strip}
                    {if isset($navigator.first)}
                        <li class="previous">
                            <a href="{g->url params=$navigator.first.urlParams}" class="first"
                                                aria-label="{g->text text="first"}">
                                <span class="sr-only">{$prefix}{g->text text="first"}</span>
                                <span class="glyphicon glyphicon-step-backward" aria-hidden="true"></span>
                            </a>
                        </li>
                    {else}
                        <li class="previous disabled">
                            <span class="first">
                                <span class="sr-only">{$prefix}{g->text text="first"}</span>
                                <span class="glyphicon glyphicon-step-backward" aria-hidden="true"></span>
                            </span>
                        </li>
                    {/if}

                    {if isset($navigator.back)}    {* Uncomment to omit previous when same as first:
	&& (!isset($navigator.first) || $navigator.back.urlParams != $navigator.first.urlParams)} *}
                        <li class="previous">
                            <a href="{g->url params=$navigator.back.urlParams}" class="previous"
                                                aria-label="{g->text text="previous"}">
                                <span class="sr-only">{$prefix}{g->text text="previous"}</span>
                                <span class="glyphicon glyphicon-backward" aria-hidden="true"></span>
                            </a>
                        </li>
                    {else}
                        <li class="previous disabled">
                            <span class="previous">
                                <span class="sr-only">{$prefix}{g->text text="previous"}</span>
                                <span class="glyphicon glyphicon-backward" aria-hidden="true"></span>
                            </span>
                        </li>
                    {/if}
                {/strip}
            {/if}
        {/foreach}
    </ul>
</nav>

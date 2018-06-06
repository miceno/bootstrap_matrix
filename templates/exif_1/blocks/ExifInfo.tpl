{*
 * $Revision: 17380 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
{if empty($item)} {assign var=item value=$theme.item} {/if}

{* Load up the EXIF data *}
{g->callback type="exif.LoadExifInfo" itemId=$item.id}

{if !empty($block.exif.LoadExifInfo.exifData)}
    {assign var="exif" value=$block.exif.LoadExifInfo}
    {if empty($ajax)}
        {if $exif.blockNum == 1}
        <script type="text/javascript">
            // <![CDATA[
            function exifSwitchDetailMode(num, itemId, mode) {ldelim}
                url = '{g->url arg1="view=exif.SwitchDetailMode" arg2="itemId=__ITEMID__"
                        arg3="mode=__MODE__" arg4="blockNum=__NUM__" htmlEntities=false forceDirect=true}';
                {strip}document.getElementById('ExifInfoLabel' + num).innerHTML =
                    '{g->text text="Loading.." forJavascript=true}';{/strip}
            {literal}
                YAHOO.util.Connect.asyncRequest('GET',
                    url.replace('__ITEMID__', itemId).replace('__MODE__', mode).replace('__NUM__', num),
                    {success: handleExifResponse, failure: handleExifFail, argument: num}, null);
                return false;
            }

            function handleExifResponse(http) {
                document.getElementById('ExifInfoBlock' + http.argument).innerHTML = http.responseText;
            }

            function handleExifFail(http) {
                document.getElementById('ExifInfoLabel' + http.argument).innerHTML = '';
            }
            {/literal}
            // ]]>
        </script>
        {/if} {* $exif.blockNum == 1 *}
    <div id="ExifInfoBlock{$exif.blockNum}" class="{$class}">
        {/if}
        <div class="block-expandable-header">
            <span class="glyphicon glyphicon-camera" aria-hidden="true"></span>
            <span class="hidden-xs hidden-sm">{g->text text="EXIF Photo Properties"}</span>
        {if isset($exif.mode)}
            {strip}
        <button class="btn btn-xs btn-default"
        {if ($exif.mode == 'summary')}
               onclick="return exifSwitchDetailMode({$exif.blockNum},{$item.id},'detailed')">
                {g->text text="details"}
        {else}
               onclick="return exifSwitchDetailMode({$exif.blockNum},{$item.id},'summary')">
                {g->text text="summary"}
        {/if}
        </button>
        <span id="ExifInfoLabel{$exif.blockNum}" aria-hidden="true"></span>
            {/strip}
        {/if}{* isset($exif.mode) *}
        </div>

        {if !empty($exif.exifData)}
        <div class="gbDataTable block-expandable-content">
        {section name=outer loop=$exif.exifData step=2}
        {section name=inner loop=$exif.exifData start=$smarty.section.outer.index max=2}
            <p class="exif-data">
            <span class="exif-tag small">{g->text text=$exif.exifData[inner].title}</span>
            <span class="h4"><span class="exif-value label label-default">{$exif.exifData[inner].value}</span></span>
            </p>
        {/section}
        {/section}
        </div>
        {/if}

        {if empty($ajax)}</div>{/if}
{/if}

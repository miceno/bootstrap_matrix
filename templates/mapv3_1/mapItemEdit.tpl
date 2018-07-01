{*
 * $Revision: 1264 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<div class="gbBlock">
    {if !empty($form.fields)}
    {if !empty($form.apiKey)}
        <script src="//maps.googleapis.com/maps/api/js?file=api&amp;v=3&amp;key={$form.apiKey}"
                type="text/javascript"></script>
    {/if}
        <script type="text/javascript">
            // <![CDATA[
            {if !empty($form.apiKey)}
            var getAddress = null;
            (function () {ldelim}
                var gps_id = '{g->formVar var="form[fields][GPS]"}';
                var loading_id = 'geocode_loading';
                var loading_msg = '{g->text text="Loading..." forJavascript=true}';
                var msg_error = '{g->text text="Not found" hint="Address not found" forJavascript=true}';
                {literal}
                var geocoder = new google.maps.Geocoder();

                function _getAddress(address) {
                    if (address != '') {
                        GPSField = document.getElementsByName(gps_id)[0];
                        loading_element = document.getElementById(loading_id);
                        loading_element.innerHTML = loading_msg;
                        geocoder.geocode({'address': address}, function (results, status) {
                            if (status === 'OK') {
                                var location = results[0].geometry.location
                                GPSField.value = location.toUrlValue(6);
                                GPSField.focus();
                            } else {
                                GPSField.value = msg_error;
                                console.debug('Geocode was not successful for the following reason: ' + status);
                            }
                            loading_element.innerHTML = "";
                        });
                    }
                }

                getAddress = _getAddress;
                {/literal}
                {rdelim})();
            {/if}

            {literal}
            function hidehelp() {
                var helpdiv = document.getElementById('helpdiv');
                helpdiv.style.visibility = "hidden";
            }

            function showhelp(help, pos) {
                var helptext = document.getElementById('helptext');
                var helpdiv = document.getElementById('helpdiv');
                helptext.innerHTML = help;
                helpdiv.style.top = pos + "px";
                helpdiv.style.visibility = "visible";
            }
            {/literal}
            {include file="modules/mapv3/templates/helpfile.tpl"}
            // ]]>
        </script>
        <style>
            {literal}
            .helpdiv {
                visibility: hidden;
                border: 2px solid black;
                position: absolute;
                right: 350px;
                top: 200px;
                width: 250px;
                height: 150px;
                z-index: 10;
            }

            .helphead {
                width: 250px;
                height: 25px;
                background: #150095;
                color: white;
                border-bottom: 2px solid black;
            }

            .helptext {
                width: 250px;
                height: 123px;
                color: black;
                font-size: 12px;
                background: #B2E4F6;
                -moz-opacity: .75;
                filter: alpha(opacity=75);
                opacity: .75;
                overflow: auto;
                clear: both;
            }

            .helptable {
                height: 100%;
                border-collapse: collapse;
            }

            .helptitle {
                width: 230px;
                vertical-align: middle;
            }

            .helpclose {
                width: 25px;
                cursor: pointer;
            }

            {/literal}
            .helpbutton {ldelim}
                cursor: pointer;
                width: 18px;
                height: 18px;
            {if !$form.IE}
                filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{$form.picbase}help.png");
            {/if}{rdelim}
        </style>
        <!-- Help Div -->
        <div id="helpdiv" class="helpdiv">
            <div id="helphead" class="helphead">
                <img alt="none" {if !$form.IE}style="float:left;" src="{$form.picbase}help.png"
                     {else}src='{$form.picbase}blank.gif'
                     style='float:left;filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{$form.picbase}help.png");'{/if}/>
                <table class="helptable">
                    <tr>
                        <td class="helptitle"><b>Help Window</b></td>
                        <td class="helpclose" onclick="javascript:hidehelp()">
                            <center><b>X</b></center>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="helptext" class="helptext"></div>
        </div>
        <!-- End of Help Div -->

    {foreach from=$form.fields key=field item=value}
        <div class="gbBlock form-group">
            <div class="col-xs-2">
                <label>{$field}
                    {if isset($form.UserHelp) and $form.UserHelp eq 1}
                        <img onclick="javascript:showhelp(_HP_U_{$field},180)" alt="help"
                             class="helpbutton"
                                {if !$form.IE}
                            src="{$form.picbase}help.png"
                                {else}
                            src='{$form.picbase}blank.gif'
                                {/if}/>
                    {/if}
                </label></div>

            <div class="col-xs-10">
                {if isset($form.choices[$field])}
                    <select name="{g->formVar var="form[fields][$field]"}">
                        <option value="">&laquo; {g->text text="No Value"} &raquo;</option>
                        {foreach from=$form.choices[$field] item=choice}
                            <option{if $choice==$value} selected="selected"{/if}>{$choice}</option>{/foreach}
                    </select>
                {else}
                    {if ($field eq 'GPS')}
                        <div class="input-group form-group">
                        <div class="input-group-addon">Coordinates</div>
                    {/if}
                    <input type="text" class="form-control" size="40"
                           name="{g->formVar var="form[fields][$field]"}" value="{$value}"/>
                    {if ($field eq 'GPS')}
                        <span class="input-group-btn">
                            <a role="button" class="btn btn-info"
                               href="{g->url arg1="view=mapv3.ShowMap" arg2="itemId=`$form.itemId`" arg3="plugin=ItemEdit" arg4="Mode=Pick"}"
                               title="{g->text text="Get via a Map"}"
                               alt="{g->text text="Get via a Map"}">
                            <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                            </a>
                            {if !isset($form.noexif) or (isset($form.noexif) and $form.noexif neq 1)}
                                {if isset($form.exif)}
                                    <button type="submit" class="btn btn-info"
                                            name="{g->formVar var="form[action][getexif]"}"
                                            value="{g->text text="Get via EXIF headers"}"
                                            title="{g->text text="Get via EXIF headers"}"
                                            alt="{g->text text="Get via EXIF headers"}">
                                <span class="glyphicon glyphicon-floppy-open" aria-hidden="true"></span>
                                <input type="hidden" name="{g->formVar var="form[exif]"}" value="{$form.exif}"/>
                                </button>
                                {/if}
                            {/if}

                            {if $ItemAdmin.item.entityType eq "GalleryPhotoItem"}
                                <button type="submit" class="btn btn-info"
                                        name="{g->formVar var="form[action][setexif]"}"
                                        value="{g->text text="Write GPS to EXIF header"}"
                                        title="{g->text text="Write GPS to EXIF header"}"
                                        alt="{g->text text="Write GPS to EXIF header"}">
                                <span class="glyphicon glyphicon-floppy-save" aria-hidden="true"></span>
                            </button>

{if isset($form.error.gps.missingGPSCoordinates)}
                                <div class="giError">
                                    {g->text text="No GPS coordinates to write."}
                                </div>
                            {/if}
                            {if isset($form.error.gps.coordinatesAlreadyInHeader)}
                                <div class="giError">
                                    {g->text text="This picture already has GPS coordinates in the header"}
                                </div>
                            {/if}
                            {/if}
                        </span>
                        </div>

                        {if !empty($form.apiKey)}
                            <div class="input-group form-group">
                                <div class="input-group-addon">Address</div>
                                <input accesskey="e" class="form-control" type="text"
                                       name="{g->formVar var="form[address]"}"
                                       id="map.addr" size=40/>
                                <div class="input-group-btn">
                                    <button type="button" class="btn btn-info"
                                            onclick="getAddress(document.getElementById('map.addr').value)"
                                            value="{g->text text="Get via address"}"
                                            title="{g->text text="Get via address"}"
                                            alt="{g->text text="Get via address"}">
                                        <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                        <span id="geocode_loading"></span>
                                    </button>
                                </div>
                            </div>
                        {/if}
                    {/if} {* gps *}
                {/if}
                <div class="help-block"></div>
            </div>
        </div>
    {/foreach}

    {/if}

</div>

{if !empty($form.fields)}
    <div class="gbBlock">
        <input type="submit" class="btn btn-primary" name="{g->formVar var="form[action][save]"}"
               value="{g->text text="Save"}"/>
        <input type="submit" class="btn btn-link" name="{g->formVar var="form[action][reset]"}"
               value="{g->text text="Reset"}"/>
    </div>
{/if}

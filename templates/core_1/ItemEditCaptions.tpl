{*
 * $Revision: 17662 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}

{capture assign="form_buttons"}
	<div class="gbBlock form-buttons">
		{if $ItemEditCaptions.canCancel}
			<input type="submit" class="btn btn-primary"
				   name="{g->formVar var="form[action][save][done]"}" value="{g->text text="Save and Done"}"/>
		{else}
			<input type="submit" class=" btn btn-primary"
				   name="{g->formVar var="form[action][save][stay]"}" value="{g->text text="Save"}"/>
		{/if}

		{if ($ItemEditCaptions.page > 1)}
			<input type="submit" class=" btn btn-default"
				   name="{g->formVar var="form[action][save][previous]"}"
				   value="&laquo; {g->text text="Save and Edit Previous %s" arg1=$form.numPerPage}"/>
		{/if}

		{if ($ItemEditCaptions.page < $ItemEditCaptions.numPages)}
			<input type="submit" class=" btn btn-default"
				   name="{g->formVar var="form[action][save][next]"}"
				   value="{g->text text="Save and Edit Next %s" arg1=$form.numPerPage} &raquo;"/>
		{/if}

		{if $ItemEditCaptions.canCancel}
			<input type="submit" class=" btn btn-danger"
				   name="{g->formVar var="form[action][cancel]"}" value="{g->text text="Cancel"}"/>
		{/if}
	</div>
{/capture}

<div class="gbBlock gcBackground1">
  <h2>
	{g->text text="Edit Captions"}
	{if ($ItemEditCaptions.numPages > 1) }
	  {g->text text="(page %d of %d)" arg1=$ItemEditCaptions.page arg2=$ItemEditCaptions.numPages}
	{/if}
  </h2>
</div>

{if !empty($status)}
<div class="gbBlock">
  {if $status.errorCount > 0}
  <h2 class="giError">
	{if $status.successCount > 0}
	  {g->text text="There were errors saving some items"}
	{else}
	  {g->text text="There were errors saving all items"}
	{/if}
  </h2>
  {elseif $status.successCount > 0}
  <h2 class="giSuccess">
	{g->text text="Successfully saved all items"}
  </h2>
  {/if}
</div>
{/if}

{if empty($form.items)}
  <div class="gbBlock">
	<p class="giDescription">
	  {g->text text="This album contains no items"}
	</p>
  </div>
{else}

<input type="hidden" name="{g->formVar var="page"}" value="{$ItemEditCaptions.page}"/>
<input type="hidden" name="{g->formVar var="form[formname]"}" value="EditCaption"/>
<input type="hidden" name="{g->formVar var="form[numPerPage]"}" value="{$form.numPerPage}"/>

{$form_buttons}

{foreach name=itemLoop from=$form.items item=item}
<div class="gbBlock edit-form row form-horizontal">
	<div class="col-xs-8">
		<input type="hidden"
			   name="{g->formVar var="form[items][`$item.id`][serialNumber]"}" value="{$item.serialNumber}"/>

		<div class="form-group">
			<label class="control-label col-xs-2" for="title_{$item.id}"> {g->text text="Title"} </label>
			<div class="col-xs-10">
				<input class="form-control" type="text" id="title_{$item.id}" {* size="60" *}
					   maxlength="{$ItemEditCaptions.fieldLengths.title}"
					   name="{g->formVar var="form[items][`$item.id`][title]"}" value="{$item.title}"/>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-xs-2" for="summary_{$item.id}"> {g->text text="Summary"} </label>
			<div class="col-xs-10">
				<input class="form-control" type="text" id="summary_{$item.id}" {* size="60" *}
					   name="{g->formVar var="form[items][`$item.id`][summary]"}" value="{$item.summary}"/></div>
		</div>

		<div class="form-group">
			<label class="control-label col-xs-2" for="keywords_{$item.id}"> {g->text text="Keywords"} </label>
			<div class="col-xs-10">
		<textarea class="form-control" id="keywords_{$item.id}" rows="2" {* cols="60" *}
				  name="{g->formVar var="form[items][`$item.id`][keywords]"}">{$item.keywords}</textarea></div>
		</div>
		<div class="form-group">

			<label class="control-label col-xs-2"
				   for="description_{$item.id}"> {g->text text="Description"} </label>
			<div class="col-xs-10"><textarea class="form-control" id="description_{$item.id}"
											 rows="4" {* cols="60" *}
											 name="{g->formVar var="form[items][`$item.id`][description]"}">{$item.description}</textarea>
			</div>
		</div>
	    <!--  START NEW FIELD -->
	    <div class="gbBlock form-group">
	        <label class="control-label col-xs-2" for="thumbSize"> {g->text text="Photo Date and Time"} </label>
		{* Specific translations: {g->text text="Link Date and Time"} *}

	        <div class="col-xs-10">
	            {if !empty($item.originationTimestamp) and is_array($item.originationTimestamp)}
	            <p class="form-inline">
		        {capture name=originationTimestampField}{strip}
		            {g->formVar var="form[items][`$item.id`][originationTimestampSplit]"}
		        {/strip}{/capture}
		        <label>{g->text text="Date:"}</label>
		        {capture name=htmlSelectDate}
		            {html_select_date time=$item.originationTimestamp.timestamp
		            field_array=$smarty.capture.originationTimestampField start_year="1970" end_year="+0"
		            all_extra='class="form-control"'}
		        {/capture}
		        {$smarty.capture.htmlSelectDate|utf8}
		        <label>{g->text text="Time:"}</label>
		        {html_select_time time=$item.originationTimestamp.timestamp
		        field_array=$smarty.capture.originationTimestampField
		        all_extra='class="form-control"'}
		        <br/>
	            </p>

		    {if !empty($item.originationTimestamp) and is_array($item.originationTimestamp)}
		        <script type="text/javascript">
                            // <![CDATA[
                            function setOriginationTimestamp_{$item.id}() {ldelim}
                                var frm = document.getElementById('itemAdminForm');
                                frm.elements['{$smarty.capture.originationTimestampField}[Date_Month]'].value = '{$item.originationTimestamp.Date_Month}';
                                frm.elements['{$smarty.capture.originationTimestampField}[Date_Day]'].value = '{$item.originationTimestamp.Date_Day}';
                                frm.elements['{$smarty.capture.originationTimestampField}[Date_Year]'].value = '{$item.originationTimestamp.Date_Year}';
                                frm.elements['{$smarty.capture.originationTimestampField}[Time_Hour]'].value = '{$item.originationTimestamp.Time_Hour}';
                                frm.elements['{$smarty.capture.originationTimestampField}[Time_Minute]'].value = '{$item.originationTimestamp.Time_Minute}';
                                frm.elements['{$smarty.capture.originationTimestampField}[Time_Second]'].value = '{$item.originationTimestamp.Time_Second}';
			        {rdelim}
                            // ]]>
		        </script>
		        <p>
			    {g->text text="Use the original capture date and time from file information (e.g. Exif tag):"}
			    <br/>
			    <a href="#" onclick="setOriginationTimestamp_{$item.id}();return false">
			        {g->date timestamp=$item.originationTimestamp.timestamp style="datetime"}
			    </a>
		        </p>
		    {/if}

	            {if !empty($form.error.originationTimestamp.invalid)}
	                <div class="giError">
	                    {g->text text="You must enter a valid date and time"}
	                </div>
	            {/if}
	            <p class="help-block">
		        {g->text text="Set the date and time when this image was captured."}
	            </p>
	            {else}
	                <div class="form-control-static">{g->text
		            text="Entity date is not available. Change it using the Edit action of the element."}</div>
	            {/if}
	        </div>
	    </div>

	    <!--  END NEW FIELD -->

	    {if isset($status[$item.id].saved)}
			<div class="giSuccess">
				{g->text text="Saved successfully."}
			</div>
		{/if}
		{if isset($status[$item.id].obsolete)}
			<div class="giError">
				{g->text text="This item was modified by somebody else at the same time.  Your changes were lost."}
			</div>
		{/if}
		{* We will probably  never see this message because the view won't show us items for which we have no permissions *}
		{if isset($status[$item.id].permissionDenied)}
			<div class="giError">
				{g->text text="You do not have permissions to modify this item."}
			</div>
		{/if}
	</div>
	{if isset($item.thumbnail)}{strip}
		<div class="col-xs-4">
			<div class="thumbnail-wrapper ">
				<a id="thumb_{$item.id}" href="{g->url arg1="view=core.ShowItem" arg2="itemId=`$item.id`"}">
					{g->image item=$item image=$item.thumbnail maxSize=150 class="giThumbnail"}
				</a>
			</div>
		</div>
	{/strip}{/if}
</div>
{/foreach}

{$form_buttons}

{/if}

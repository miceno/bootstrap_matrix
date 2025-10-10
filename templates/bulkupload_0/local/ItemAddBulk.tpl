{*
 * $Revision: 13671 $
 * If you want to customize this file, do not edit it directly since future upgrades
 * may overwrite it.  Instead, copy it into a new directory called "local" and edit that
 * version.  Gallery will look for that file first and use it if it exists.
 *}
{if !empty($form.error)}
<div class="gbBlock giError">
  <h2>
    {g->text text="There was a problem processing your request, see below for details."}
  </h2>
</div>
{/if}

<div class="gbBlock">
  <p class="giDescription">
    {g->text text="Add many files at once with pre-prepared title, summary, description and keywords."}
    <a onclick="document.getElementById('ItemAddBulk_instructions').className='show'">{g->text text="[help]"}</a>
  </p>
  <p class="hide" id="ItemAddBulk_instructions" class="giDescription">
    {capture assign=sampleDataFile}<a href="{g->url href="modules/bulkupload/data/sample.txt"}">{/capture}
    {capture assign=sampleExcelSpreadsheet}<a href="{g->url href="modules/bulkupload/data/sample.xls"}">{/capture}
    {g->text text="The photos you want to add must already be uploaded to your web server.  Create a data file containing the title, summary, description and keywords along with the path to each photo, and then enter the path to the text file in the box below.  For convenience, you can author the data file in Excel and then save it in the %sText (tab delimited)%s format.  Here is a %ssample data file%s and a %ssample excel spreadsheet%s." arg1="<b>" arg2="</b>" arg3=$sampleDataFile arg4="</a>" arg5=$sampleExcelSpreadsheet arg6="</a>"}
  </p>

    <div class="form-group">
      <label class="control-label" for="giFormPath"> {g->text text="Data File"} </label>
      <input type="text" size="120" id="giFormPath" name="{g->formVar var="form[path]"}" value="{$form.path}" autocomplete="off"/>
        {g->autoComplete element="giFormPath"}
            {g->url arg1="view=core.SimpleCallback" arg2="command=lookupFiles" arg3="prefix=__VALUE__"
            htmlEntities=false}
        {/g->autoComplete}
    </div>

  {if isset($form.error.path)}
  <div class="giError">
    {g->text text="Invalid path."}
  </div>
  {/if}
</div>

{* Include our extra ItemAddOptions *}
{foreach from=$ItemAdd.options item=option}
  {include file="gallery:`$option.file`" l10Domain=$option.l10Domain}
{/foreach}

<div class="gbBlock">
  <input type="submit" class="btn btn-primary"
   name="{g->formVar var="form[action][add]"}" value="{g->text text="Add Items"}"/>
</div>


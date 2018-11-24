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
    {g->text text="Add many files at once with pre-prepared fields."}
    <a onclick="document.getElementById('ItemAddBulk_instructions').style.display='block'">{g->text text="[help]"}</a>
  </p>
  <p style="display: none" id="ItemAddBulk_instructions" class="giDescription">
    {capture assign=sampleDataFile}<a href="{g->url href="modules/bulkexcelupload/data/sample.zip"}">{/capture}
    {capture assign=sampleExcelSpreadsheet}<a href="{g->url href="modules/bulkexcelupload/data/sample.xls"}">{/capture}
    {g->text text="
    Create a data file containing the Registre, Referència, Temes, Suport, Descripció, Lloc, Autor and Data to each
    photo, and then enter the path
    to the XLSX and ZIP files in the box below. For convenience, you can author the data file in Excel and then save
    it in the %sXLSX%s format.
    The photos you want to add must be on the ZIP file in the same order as they are on the XLSX file.
    Here is a %ssample data file%s and a %ssample excel spreadsheet%s." arg1="<b>" arg2="</b>" arg3=$sampleDataFile arg4="</a>" arg5=$sampleExcelSpreadsheet arg6="</a>"}
  </p>

<div class="form-group">
    <div class="col-xs-2">
      <label for="giFormExcelPath"> {g->text text="Excel File"} </label>
    </div>

<div class="col-xs-10">
<input type="text" size="120" name="{g->formVar var="form[excelPath]"}" value="{$form.excelPath}"
         id='giFormExcelPath' autocomplete="off"/>
  {g->autoComplete element="giFormExcelPath"}
    {g->url arg1="view=core.SimpleCallback" arg2="command=lookupFiles" arg3="prefix=__VALUE__"
            htmlEntities=false}
  {/g->autoComplete}
  {if isset($form.error.excelPath)}
  <div class="giError">
    {g->text text="Invalid path for Excel file."}
  </div>
  {/if}
  </div>
</div>

<div class="form-group">  
<div class="col-xs-2"><label for="giFormZipPath"> {g->text text="Zip File"} </label>
</div>  
<div class="col-xs-10"><input type="text" size="120" name="{g->formVar var="form[zipPath]"}" value="{$form.zipPath}"
         id='giFormZipPath' autocomplete="off"/>
  {g->autoComplete element="giFormZipPath"}
    {g->url arg1="view=core.SimpleCallback" arg2="command=lookupFiles" arg3="prefix=__VALUE__"
            htmlEntities=false}
  {/g->autoComplete}
  {if isset($form.error.zipPath)}
  <div class="giError">
    {g->text text="Invalid path for ZIP file."}
  </div>
  {/if}
</div></div>
    <label for="giReadHeader"> {g->text text="Read header"} </label>
        <input id="giReadHeader" type="checkbox" {if $form.readHeader=="on"}checked="checked" {/if}
        onclick="document.getElementById('readHeader').value = this.checked ? 'on' : 'off'"/>
    <input type="hidden" id="readHeader"
	name="{g->formVar var="form[readHeader]"}" value="{$form.readHeader}"/>

</div>

{* Include our extra ItemAddOptions *}
{foreach from=$ItemAdd.options item=option}
  {include file="gallery:`$option.file`" l10Domain=$option.l10Domain}
{/foreach}

<div class="gbBlock gcBackground1">
  <input type="submit" class="inputTypeSubmit"
   name="{g->formVar var="form[action][add]"}" value="{g->text text="Add Items"}"/>
</div>


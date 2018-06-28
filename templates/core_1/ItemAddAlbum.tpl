{*
 * $Revision: 16235 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<div class="gbBlock">
  <h2> {g->text text="Add Sub-Album"} </h2>
</div>

<div class="gbBlock">

  <div class="form-group {if isset($form.error.pathComponent.invalid)
  || isset($form.error.pathComponent.missing)
  || isset($form.error.pathComponent.collision)}has-error{/if}">
      <label class="control-label col-xs-2" for="idName">
          {g->text text="Name"}<span> {g->text text="(required)"} </span>
      </label>

      <div class="col-xs-10">

          <div class="input-group">
              <div class="input-group-addon">
                  <span class="form-control-static">
                    {strip}
                        {foreach from=$ItemAdmin.parents item=parent}
                            {$parent.pathComponent}/
                        {/foreach}
                        {$ItemAdmin.item.pathComponent}/
                    {/strip}
                  </span>
              </div>

              <input id="idName" type="text" size="10" class="form-control form-inline"
                     name="{g->formVar var="form[pathComponent]"}" value="{$form.pathComponent}"/>

              <script type="text/javascript">
                  document.getElementById('itemAdminForm')['{g->formVar var="form[pathComponent]"}'].focus();
              </script>

          </div>
          <p class="help-block">
              {g->text text="The name of this album on your hard disk.  It must be unique in this album.  Only use alphanumeric characters, underscores or dashes.  You will be able to rename it later."}
              {if !empty($form.error.pathComponent.invalid)}
          <div class="giError">
              {g->text text="Your name contains invalid characters.  Please enter another."}
          </div>
          {/if}
          {if !empty($form.error.pathComponent.missing)}
              <div class="giError">
                  {g->text text="You must enter a name for this album."}
              </div>
          {/if}
          {if !empty($form.error.pathComponent.collision)}
              <div class="giError">
                  {g->text text="The name you entered is already in use.  Please enter another."}
              </div>
          {/if}
          </p>
      </div>
  </div>
<div class="form-group">
    <label class="control-label col-xs-2" for="title"> {g->text text="Title"} </label>

    <div class="col-xs-10">
        <div>{include file="gallery:modules/core/templates/MarkupBar.tpl"
           viewL10domain="modules_core"
           element="title" firstMarkupBar=true}
        </div>
        <input type="text" id="title" size="40" class="form-control"
        name="{g->formVar var="form[title]"}" value="{$form.title}"/>

        <p class="help-block">{g->text text="This is the album title."}</p>
    </div>
</div>


<div class="form-group">
    <label class="control-label col-xs-2" for="summary">{g->text text="Summary"}</label>
    <div class="col-xs-10">
        <div>{include file="gallery:modules/core/templates/MarkupBar.tpl"
           viewL10domain="modules_core"
           element="summary"}
        </div>
        <input type="text" id="summary" size="40" class="form-control"
        name="{g->formVar var="form[summary]"}" value="{$form.summary}"/>
        <p class="help-block">{g->text text="This is the album summary."}</p>
    </div>
</div>

    <div class="form-group">
        <label class="control-label col-xs-2" for="keywords">{g->text text="Keywords"}</label>
        <div class="col-xs-10">

        <textarea rows="2" cols="60" id="keywords" class="form-control"
                name="{g->formVar var="form[keywords]"}">{$form.keywords}</textarea>
        <p class="help-block">
            {g->text text="Keywords are not visible, but are searchable."}
        </p>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-xs-2"
                                   for="description"> {g->text text="Description"} </label>

        <div class="col-xs-10">
            {include file="gallery:modules/core/templates/MarkupBar.tpl"
            viewL10domain="modules_core"
            element="description"}

            <textarea id="description" rows="4" cols="60" class="form-control"
                      name="{g->formVar var="form[description]"}">{$form.description}</textarea>
            <p class="help-block">
                {g->text text="This is the long description of the album."}
            </p></div>
    </div>
</div>

<div class="gbBlock">
  <input type="submit" class="btn btn-primary"
   name="{g->formVar var="form[action][create]"}" value="{g->text text="Create"}"/>

    <input type="submit" class="btn btn-link"
           name="{g->formVar var="form[action][undo]"}" value="{g->text text="Back"}"/>
</div>

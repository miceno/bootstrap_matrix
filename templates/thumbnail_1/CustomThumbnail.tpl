{*
 * $Revision: 16235 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<div class="gbBlock form-group">
    <label class="control-label col-xs-2" for="file"> {g->text text="Custom Thumbnail"} </label>

    <div class="col-xs-10">
        <input id="file" type="file" size="45" name="{g->formVar var="form[1]"}"/>

        <p class="help-block">
            {if isset($CustomThumbnailOption.thumbnail)}
                <label for="CustomThumbnailOption_delete" class="control-label">
                    <input type="checkbox" id="CustomThumbnailOption_delete"
                           name="{g->formVar var="form[CustomThumbnailOption][delete]"}"/>
                    {g->text text="Remove custom thumbnail for this item"}
                </label>
            {else}
                {g->text text="Upload a JPEG image to use as the thumbnail for this item."} <br/>
                {if $CustomThumbnailOption.canResize}
                    {g->text text="Image does not need to be thumbnail size; it will be resized as needed."}
                {else}
                    {g->text text="No toolkit available for resizing so uploaded image must be thumbnail sized."}
                {/if}
            {/if}
            {if !empty($form.CustomThumbnailOption.error.missingFile)}
            <div class="giError">
                {g->text text="Missing image file"}
            </div>
            {/if}
            {if !empty($form.CustomThumbnailOption.error.imageMime)}
                <div class="giError">
                    {g->text text="Thumbnail image must be a JPEG"}
                </div>
            {/if}
        </p>
    </div>
</div>

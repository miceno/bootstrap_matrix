{*
 * $Revision: 17113 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
var prompts = {ldelim}
"header" : '{g->text text="Warning!" forJavascript=true}',
"body"   : '{g->text text="Do you really want to delete %s?" forJavascript=true}',
"yes"    : '{g->text text="Yes" forJavascript=true}',
"no"     : '{g->text text="No" forJavascript=true}',
"more"   : '{g->text text="Delete more items..." forJavascript=true}'
{rdelim};

{literal}
function core_confirmDelete(url, moreUrl, title) {
    var modal = $('#galleryModal');
    var pageItemId = this.pageItemId;
    var bodyText = prompts['body'].replace('%s', title);
    var location = "document.location.href=\'" + moreUrl + "\';return false";

    // Set title
    modal.find('.modal-title').html(prompts['header']);

    if (moreUrl) {
    bodyText += '<br/><br/><a href="'+ moreUrl + '">' + prompts['more'] + '</a>';
    }
    // Set body
    modal.find('.modal-body').first().html(bodyText);

    // Set Yes
    modal.find('#btnSubmit').html(prompts['yes'])
    .off('click')
    .click(function (event) {
    event.preventDefault();
    event.stopPropagation();
    if(btnSubmit != "Continue") {
    document.location = url;
    }
    return true;
    });

    // Set Cancel
    modal.find('#btnClose').html(prompts['no']);

    // Show the modal.
    modal.modal({show: true});
}
{/literal}

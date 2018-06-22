{*
 * $Revision: 16727 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html lang="{g->language}" xmlns="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
      xmlns:v="urn:schemas-microsoft-com:vml">
<head>
    <meta name="keywords" content="{$theme.item.keywords|markup:strip|default:$theme.item.pathComponent}"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    {* Let Gallery print out anything it wants to put into the <head> element *}
    {g->head}

    {* If Gallery doesn't provide a header, we use the album/photo title (or filename) *}
    {if empty($head.title)}
        <title>{$theme.item.title|markup:strip|default:$theme.item.pathComponent}</title>
    {/if}

    {* Bootstrap CSS *}
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    {* Include this theme's style sheet *}
    <link rel="stylesheet" type="text/css" href="{g->theme url="theme.css"}"/>

    {php}
        $includefilepath = GALLERY_CONFIG_DIR . '/ga.js';
        if (file_exists($includefilepath)) {
        include($includefilepath);
        }
    {/php}
    {* OpenSans font *}
    <link rel="stylesheet" id="google-fonts-css"
          href="https://fonts.googleapis.com/css?family=Open+Sans%3A300%2C400%2C600%7CMontserrat%3A400%7CRaleway%3A400%7CCrimson+Text%3A400Italic&amp;subset=latin&amp;ver=1472669696"
          type="text/css" media="all">
</head>
<body class="gallery">
<div class="container-fluid" {g->mainDivAttributes}>
    {*
     * Some module views (eg slideshow) want the full screen.  So for those, we don't draw
     * a header, footer, navbar, etc.  Those views are responsible for drawing everything.
     *}
    {if $theme.useFullScreen}
        {include file="gallery:`$theme.moduleTemplate`" l10Domain=$theme.moduleL10Domain}
    {elseif $theme.pageType == 'progressbar'}
        <div id="gsHeader" class="row-fluid">
            <img src="{g->url href="images/galleryLogo_sm.gif"}" width="107" height="48" alt=""/>
        </div>
        {g->theme include="progressbar.tpl"}
    {else}
        <div id="gsHeader" class="row-fluid navbar navbar-default navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#gallery-navbar-collapse-systemlinks" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    {strip}
                    <a class="navbar-brand" href="{g->url}">
                        <img src="{g->url href="`$theme.themeUrl`/images/gallery_logo.png"}" alt="Logo de l'Arxiu Històric del Poblenou"/>
                    </a>
                    {/strip}
                </div> {* navbar-header *}
                <div class="collapse navbar-collapse" id="gallery-navbar-collapse-systemlinks">
                {g->block type="core.SystemLinks"
                    order="core.SiteAdmin core.YourAccount core.Login core.Logout"
                    othersAt=4}
                </div>

            </div> {* container-fluid *}
        </div>
        {* gsHeader *}

        {* Include the appropriate content type for the page we want to draw. *}
        {if $theme.pageType == 'album'}
            {g->theme include="album.tpl"}
        {elseif $theme.pageType == 'photo'}
            {g->theme include="photo.tpl"}
        {elseif $theme.pageType == 'admin'}
            {g->theme include="admin.tpl"}
        {elseif $theme.pageType == 'module'}
            {g->theme include="module.tpl"}
        {/if}
        <div id="gsFooter row-fluid">
            {g->logoButton type="validation"}
            {g->logoButton type="gallery2"}
            {g->logoButton type="gallery2-version"}
            {g->logoButton type="donate"}
        </div>
    {/if}  {* end of full screen check *}
</div> {* container-fluid *}

{*
 * Give Gallery a chance to output any cleanup code, like javascript that needs to be run
 * at the end of the <body> tag.  If you take this out, some code won't work properly.
 *}
{g->trailer}



{* Put any debugging output here, if debugging is enabled *}
{g->debug}

<!-- Modal -->
<div class="modal fade" id="galleryModal" tabindex="-1" role="dialog" aria-labelledby="modalDialogTitle">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="modalDialogTitle"></h4>
            </div>
            <div class="modal-body">
            </div>
            <div class="modal-footer">
                <button id="btnClose" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="btnSubmit" type="button" class="btn btn-primary">Save</button>
            </div>
        </div>
    </div>
</div>

</body>
{* jQuery (necessary for Bootstrap's JavaScript plugins) *}
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

{* Bootstrap JS *}
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
</html>

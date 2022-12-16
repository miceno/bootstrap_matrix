{strip}
{*
 * $Revision: 16727 $
 * Read this before changing templates!  http://codex.gallery2.org/Gallery2:Editing_Templates
 *}
<!DOCTYPE html>
<html lang="{g->language}" xmlns="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
      xmlns:v="urn:schemas-microsoft-com:vml">
<head>
    {if isset($theme.params.selfHostedAssets)}
        {assign var="selfHostedAssets" value=$theme.params.selfHostedAssets}
    {else}
        {assign var="selfHostedAssets" value=0}
    {/if}
    {if isset($theme.params.useMinifiedCss)}
        {assign var="useMinifiedCss" value=$theme.params.useMinifiedCss}
    {else}
        {assign var="useMinifiedCss" value=0}
    {/if}
    <meta name="keywords" content="{$theme.item.keywords|markup:strip|default:$theme.item.pathComponent}"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    {* Let Gallery print out anything it wants to put into the <head> element *}
    {g->head}

    {* If Gallery doesn't provide a header, we use the album/photo title (or filename) *}
    {if empty($head.title)}
        <title>{$theme.item.title|markup:strip|default:$theme.item.pathComponent}</title>
    {/if}

    {* Bootstrap CSS *}
    {if !$selfHostedAssets}
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/css/bootstrap.min.css"
          integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu"
          crossorigin="anonymous">
    {else}
    <link rel="stylesheet" href="{g->theme url="assets/bootstrap-3.4.1-dist/css/bootstrap.min.css?`$theme.params._version`"}">
    {/if}
    {* Include this theme's style sheet *}
    {assign var="theme_css_file" value="theme.css"}
    {assign var="print_css_file" value="print.css"}
    {if $useMinifiedCss}
        {assign var="theme_css_file" value="theme.min.css"}
        {assign var="print_css_file" value="print.min.css"}
    {/if}
    <link rel="stylesheet" type="text/css" href="{g->theme url=`$theme_css_file`?`$theme.params._version`}"/>
    <link rel="stylesheet" type="text/css" media="print" href="{g->theme url=`$print_css_file`?`$theme.params._version`}"/>

    {php}
        $includefilepath = GALLERY_CONFIG_DIR . '/ga.js';
        if (file_exists($includefilepath)) {
        include($includefilepath);
        }
    {/php}
    {* jQuery (necessary for Bootstrap's JavaScript plugins) *}
    {if !$selfHostedAssets}
    <script type="application/javascript"
            src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    {* Bootstrap JS *}
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.4.1/dist/js/bootstrap.min.js"
        integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd"
        crossorigin="anonymous"></script>

        {* OpenSans font *}
    <link rel="stylesheet" id="google-fonts-css"
          href="https://fonts.googleapis.com/css?family=Open+Sans%3A300%2C400%2C600%7CMontserrat%3A400%7CRaleway%3A400%7CCrimson+Text%3A400Italic&amp;subset=latin&amp;ver=1472669696"
          type="text/css" media="all">
    {else}
    <script type="application/javascript"
            src="{g->theme url=assets/jquery-1.12.4/jquery.min.js?`$theme.params._version`}"></script>

    {* Bootstrap JS *}
    <script type="application/javascript"
            src="{g->theme url=assets/bootstrap-3.4.1-dist/js/bootstrap.min.js?`$theme.params._version`}"
            async></script>
    {* OpenSans font *}
    <link rel="stylesheet" id="google-fonts-css"
          href="{g->theme url=assets/google-fonts/open-sans-fonts.css?`$theme.params._version`}"
          type="text/css" media="all">
    {/if}

    {* Favicon *}
    <link rel="apple-touch-icon" sizes="57x57" href="{g->theme url='images/favicon/apple-icon-57x57.png'}">
    <link rel="apple-touch-icon" sizes="60x60" href="{g->theme url='images/favicon/apple-icon-60x60.png'}">
    <link rel="apple-touch-icon" sizes="72x72" href="{g->theme url='images/favicon/apple-icon-72x72.png'}">
    <link rel="apple-touch-icon" sizes="76x76" href="{g->theme url='images/favicon/apple-icon-76x76.png'}">
    <link rel="apple-touch-icon" sizes="114x114" href="{g->theme url='images/favicon/apple-icon-114x114.png'}">
    <link rel="apple-touch-icon" sizes="120x120" href="{g->theme url='images/favicon/apple-icon-120x120.png'}">
    <link rel="apple-touch-icon" sizes="144x144" href="{g->theme url='images/favicon/apple-icon-144x144.png'}">
    <link rel="apple-touch-icon" sizes="152x152" href="{g->theme url='images/favicon/apple-icon-152x152.png'}">
    <link rel="apple-touch-icon" sizes="180x180" href="{g->theme url='images/favicon/apple-icon-180x180.png'}">
    <link rel="icon" type="image/png" sizes="192x192"  href="{g->theme url='images/favicon/android-icon-192x192.png'}">
    <link rel="icon" type="image/png" sizes="32x32" href="{g->theme url='images/favicon/favicon-32x32.png'}">
    <link rel="icon" type="image/png" sizes="96x96" href="{g->theme url='images/favicon/favicon-96x96.png'}">
    <link rel="icon" type="image/png" sizes="16x16" href="{g->theme url='images/favicon/favicon-16x16.png'}">
    <link rel="manifest" href="{g->theme url='images/favicon/manifest.json'}">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="{g->theme url='images/favicon/ms-icon-144x144.png'}">
    <meta name="theme-color" content="#ffffff">
</head>
<body class="gallery">
<div class="container-fluid no-gutter" {g->mainDivAttributes}>
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
{if !$selfHostedAssets }
<script type="application/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/lazysizes/4.0.4/lazysizes.min.js"
        integrity="sha256-FRkZgEAdWoQnIbMoXkMPk7Fv3+jDX1SUUHJOBG4U/1M=" crossorigin="anonymous" async></script>
{else}
<script type="application/javascript" src="{g->theme url=assets/lazysizes-4.0.4/lazysizes.min.js?`$theme.params._version`}"
        async></script>

{/if}

</html>
{/strip}

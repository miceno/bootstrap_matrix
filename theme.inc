<?php
/*
 * Gallery - a web based photo album viewer and editor
 * Copyright (C) 2000-2008 Bharat Mediratta
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA  02110-1301, USA.
 */

/**
 * Standard gallery theme
 * @package Themes
 * @subpackage Bootstrap_Matrix
 * @author Orestes Sanchez <orestes@estotienearreglo.es>
 * @version
 */
class Bootstrap_MatrixTheme extends GalleryTheme {

	function __construct() {
		global $gallery;

		$this->setId('bootstrap_matrix');
		$this->setName($gallery->i18n('BootstrapMatrix'));
		$this->setDescription($gallery->i18n('Bootstrap Gallery2 look and feel'));
		$this->setVersion('1.2.1');
		$this->setRequiredCoreApi(array(7, 20));
		$this->setRequiredThemeApi(array(2, 4));
		$this->setStandardSettings(
			array(
				'rows'            => 6,
				'columns'         => 4,
				'aboveFoldImages' => 8,
				'boxesLayout'     => 'left',
				'showImageOwner'  => 0, 'showAlbumOwner' => 1,
				'albumFrame'      => '', 'itemFrame' => '', 'photoFrame' => '',
				'colorpack'       => '', 'showMicroThumbs' => 0, 'dynamicLinks' => 'browse',
				'sidebarBlocks'   => serialize(array(
												   array('search.SearchBlock', array('showAdvancedLink' => true)),
												   array('core.ItemLinks', array('useDropdown' => false)),
												   array('core.PeerList', array()),
												   array('imageblock.ImageBlock', array()),
											   )),
				'albumBlocks'     => serialize(array(
												   array('comment.ViewComments', array()),
											   )),
				'photoBlocks'     => serialize(array(
												   array('exif.ExifInfo', array()),
												   array('comment.ViewComments', array()),
											   )),
			));
	}

	/**
	 * @see GalleryTheme::showAlbumPage
	 */
	function showAlbumPage(&$template, $item, $params, $childIds) {
		global $gallery;

		$ret = $this->loadCommonTemplateData(
			$template, $item, $params,
			array(
				'owner', 'viewCount', 'childCount', 'descendentCount', 'parents',
				'systemLinks', 'itemLinks', 'itemSummaries', 'permissions',
				'thumbnails', 'pageNavigator', 'jumpRange',
			),
			$childIds);
		if ($ret) {
			return array($ret, null);
		}

		$ret = $this->preloadBlock($template, 'search.SearchBlock');
		if ($ret) {
			return array($ret, null);
		}

		/* Add in our extra stuff */
		$theme          =& $template->getVariableByReference('theme');
		$theme['debug'] = $gallery->getDebug();

		/* Add our header and styles */

		return array(null, 'theme.tpl');
	}

	/**
	 * @see GalleryTheme::showPhotoPage
	 */
	function showPhotoPage(&$template, $item, $params) {
		global $gallery;

		$dataTypes = array(
			'owner', 'parents', 'systemLinks', 'itemLinks', 'permissions',
			'itemLinksDetailed', 'itemNavigator', 'imageViews',
		);
		if (! empty($params['showMicroThumbs'])) {
			$dataTypes[] = 'navThumbnails';
		}
		$ret = $this->loadCommonTemplateData($template, $item, $params, $dataTypes);
		if ($ret) {
			return array($ret, null);
		}

		$ret = $this->preloadBlock($template, 'search.SearchBlock');
		if ($ret) {
			return array($ret, null);
		}

		/* Add in our extra stuff */
		$theme          =& $template->getVariableByReference('theme');
		$theme['debug'] = $gallery->getDebug();

		return array(null, 'theme.tpl');
	}

	/**
	 * @see GalleryTheme::showModulePage
	 */
	function showModulePage(&$template, $item, $params, $templateFile) {
		global $gallery;
		$ret = $this->loadCommonTemplateData(
			$template, $item, $params, array('parents', 'systemLinks'));
		if ($ret) {
			return array($ret, null);
		}

		$ret = $this->preloadBlock($template, 'search.SearchBlock');
		if ($ret) {
			return array($ret, null);
		}

		/* Add in our extra stuff */
		$theme          =& $template->getVariableByReference('theme');
		$theme['debug'] = $gallery->getDebug();

		return array(null, 'theme.tpl');
	}

	/**
	 * @see GalleryTheme::showAdminPage
	 */
	function showAdminPage(&$template, $item, $params, $templateFile) {
		global $gallery;
		$ret = $this->loadCommonTemplateData(
			$template, $item, $params, array('parents', 'systemLinks'));
		if ($ret) {
			return array($ret, null);
		}

		$ret = $this->preloadBlock($template, 'search.SearchBlock');
		if ($ret) {
			return array($ret, null);
		}

		/* Add in our extra stuff */
		$theme          =& $template->getVariableByReference('theme');
		$theme['debug'] = $gallery->getDebug();

		return array(null, 'theme.tpl');
	}

	/**
	 * @see GalleryTheme::showErrorPage
	 */
	function showErrorPage(&$template) {
		global $gallery;

		/* Add in our extra stuff */
		$theme          =& $template->getVariableByReference('theme');
		$theme['debug'] = $gallery->getDebug();

		return array(null, 'error.tpl');
	}

	/**
	 * @see GalleryTheme::showProgressBarPage
	 */
	function showProgressBarPage(&$template, $item, $params) {
		global $gallery;

		/* Add in our extra stuff */
		$theme          =& $template->getVariableByReference('theme');
		$theme['debug'] = $gallery->getDebug();

		$ret = $this->loadCommonTemplateData(
			$template, $item, $params, array('parents', 'systemLinks'));
		if ($ret) {
			return array($ret, null);
		}

		$ret = $this->preloadBlock($template, 'search.SearchBlock');
		if ($ret) {
			return array($ret, null);
		}

		return array(null, 'theme.tpl');
	}

	/**
	 * @see GalleryTheme::getSettings
	 */
	function getSettings($itemId = null) {
		list ($ret, $settings, $params) = parent::getSettings($itemId);
		if ($ret) {
			return array($ret, null, null);
		}

		/* Add in our custom settings */
		$settings[] = array(
			'key'     => 'boxesLayout',
			'name'    => $this->translate('Block layout'),
			'type'    => 'single-select',
			'choices' => array(
				'left'    => $this->translate('To the left'),
				'bottom'  => $this->translate('To the bottom'),
				'right'   => $this->translate('To the right'),
				'disable' => $this->translate('Disable'),
			),
			'value'   => $params['boxesLayout'],
		);

		/* Add in our custom settings */
		$settings[] = array(
			'key'        => 'aboveFoldImages',
			'name'       => $this->translate('Number of above-the-fold images.
	    Above-the-fold images will load immediately, while below-the-fold images will be lazy
	    loaded.'),
			'type'       => 'text-field',
			'typeParams' => array('size' => 2),
			'value'      => $params['aboveFoldImages'],
		);

		return array(null, $settings, $params);
	}

}

?>

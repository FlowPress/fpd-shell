<?php

namespace fp\components;

use fp;

if ( class_exists( 'fp\Component' ) ) {
	/**
	 * Class {{COMPONENT_CLASS}}
	 */
	class {{COMPONENT_CLASS}} extends fp\Component {

		/**
		 * Schema version.
		 *
		 * @var int
		 */
		public $schema_version = {{SCHEMA_VERSION}}; // This needs to be updated manually when we make changes to this template so we can find out-of-date components.

		/**
		 * Component version.
		 *
		 * @var string
		 */
		public $version = '{{VERSION}}';

		/**
		 * Component slug.
		 *
		 * @var string
		 */
		public $component = '{{COMPONENT_SLUG}}'; // Component slug should be the same as this file base name.

		/**
		 * Component name.
		 *
		 * @var string
		 */
		public $component_name = '{{COMPONENT_NAME}}'; // Shown in BB sidebar.

		/**
		 * Component description.
		 *
		 * @var string
		 */
		public $component_description = '{{COMPONENT_DESCRIPTION}}';

		/**
		 * Component category.
		 *
		 * @var string
		 */
		public $component_category = '{{COMPONENT_CATEGORY}}';

		/**
		 * CSS dependencies.
		 *
		 * @var array
		 */
		public $deps_css = array(); // WordPress Registered CSS Dependencies.

		/**
		 * JS dependencies.
		 *
		 * @var array
		 */
		public $deps_js = array( 'jquery' ); // WordPress Registered JS Dependencies.

		/**
		 * Base directory.
		 *
		 * @var string
		 */
		public $base_dir = __DIR__;

		/**
		 * Fields.
		 *
		 * @var array
		 */
		public $fields = array(); // Placeholder for fields used in BB Module & Shortcode.

		/**
		 * BB config.
		 *
		 * @var array
		 */
		public $bbconfig = array(); // Placeholder for BB Module Registration.

		/**
		 * Variants.
		 *
		 * @var array
		 */
		public $variants = array(); // Component CSS Variants as per -> http://rscss.io/variants.html.

		/**
		 * Include wrapper.
		 *
		 * @var bool
		 */
		public $include_wrapper = false;

		/**
		 * Dynamic data feed parameters.
		 *
		 * @var array
		 */
		public $dynamic_data_feed_parameters = array(); // Generates $atts[posts] object with dynamically populated data.

		/**
		 * Pre-process data.
		 *
		 * @param array $atts   Attributes.
		 * @param mixed $module Module.
		 * @return array Processed attributes.
		 */
		public function pre_process_data( $atts, $module ) {
			return $atts;
		}
	}

	new {{COMPONENT_CLASS}}();
}

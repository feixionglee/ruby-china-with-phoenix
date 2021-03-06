exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js",

      // To use a separate vendor.js bundle, specify two files path
      // https://github.com/brunch/brunch/blob/stable/docs/config.md#files

      //
      // To change the order of concatenation of files, explicitly mention here
      // https://github.com/brunch/brunch/tree/master/docs#concatenation
      order: {
        before: [
          "web/static/vendor/js/underscore.js",
          "web/static/vendor/js/backbone.js",
          "web/static/vendor/js/bootstrap.js",
          "web/static/vendor/js/bootstrap-select.js",
          "web/static/vendor/js/bootstrap-select-i18n/defaults-en_US.js",
          "web/static/vendor/js/bootstrap-select-i18n/defaults-zh_CN.js",
          "web/static/vendor/js/medium-editor.js",
          "web/static/vendor/js/handlebars.runtime.js",
          "web/static/vendor/js/jquery-sortable.js",
          "web/static/vendor/js/jquery.ui.widget.js",
          "web/static/vendor/js/jquery.iframe-transport.js",
          "web/static/vendor/js/jquery.fileupload.js",
          "web/static/vendor/js/medium-editor-insert-plugin.js"
        ]
      }
    },
    stylesheets: {
      joinTo: "css/app.css",
      order: {
        before: [
          "web/static/vendor/css/boostrap.css",
          "web/static/vendor/css/bootstrap-select.css",
          "web/static/vendor/css/font-awesome.css",
          "web/static/css/vars.scss",
          "web/static/vendor/css/medium-editor.css",
          "web/static/vendor/css/medium-editor-theme-default.css",
          "web/static/vendor/css/medium-editor-insert-plugin.css"
        ]
      }
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/web/static/assets". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(web\/static\/assets)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: [
      "web/static",
      "test/static"
    ],

    // Where to compile files to
    public: "priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/web\/static\/vendor/]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["web/static/js/app"]
    }
  },

  npm: {
    enabled: true,
    // Whitelist the npm deps to be pulled in as front-end assets.
    // All other deps in package.json will be excluded from the bundle.
    globals: {
      $: 'jquery',
      jQuery: 'jquery'
    }
  }
};

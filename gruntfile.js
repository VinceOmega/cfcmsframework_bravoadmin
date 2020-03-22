const sass = require('node-sass');

const cssmin = require('grunt-contrib-cssmin');


module.exports = function(grunt) {

    grunt.initConfig({
        concat: {
            dist: {
                src: [
                    'templates/vendors/material-pro/scss/includes.scss',
                    'templates/vendors/material-pro/scss/variable.scss',
                    'templates/vendors/material-pro/scss/sidebar.scss',
                    'templates/vendors/material-pro/scss/app.scss',
                    'templates/vendors/material-pro/scss/grid.scss',
                    'templates/vendors/material-pro/scss/material.scss',
                    'templates/vendors/material-pro/scss/pages.scss',
                    'templates/vendors/material-pro/scss/responsive.scss',
                    'templates/vendors/material-pro/scss/widgets.scss'
                ],
                dest: 'templates/vendors/material-pro/scss/style.scss',
            }
        },
        sass: {
            options: {
                implementation: sass,
                sourceMap: true
            },
            dist: {
                files: {
                    'templates/vendors/material-pro/css/colors/general.css': 'templates/vendors/material-pro/scss/colors/general.scss',
                    'templates/vendors/material-pro/css/colors/gray.css': 'templates/vendors/material-pro/scss/colors/gray.scss',
                    'templates/vendors/material-pro/css/colors/blue.css': 'templates/vendors/material-pro/scss/colors/blue.scss',
                    'templates/vendors/material-pro/css/colors/blue-dark.css': 'templates/vendors/material-pro/scss/colors/blue-dark.scss',
                    'templates/vendors/material-pro/css/colors/default.css': 'templates/vendors/material-pro/scss/colors/default.scss',
                    'templates/vendors/material-pro/css/colors/default-dark.css': 'templates/vendors/material-pro/scss/colors/default-dark.scss',
                    'templates/vendors/material-pro/css/colors/green.css': 'templates/vendors/material-pro/scss/colors/green.scss',
                    'templates/vendors/material-pro/css/colors/green-dark.css': 'templates/vendors/material-pro/scss/colors/green-dark.scss',
                    'templates/vendors/material-pro/css/colors/megan.css': 'templates/vendors/material-pro/scss/colors/megna.scss',
                    'templates/vendors/material-pro/css/colors/megna-dark.css': 'templates/vendors/material-pro/scss/colors/megna-dark.scss',
                    'templates/vendors/material-pro/css/colors/purple.css': 'templates/vendors/material-pro/scss/colors/purple.scss',
                    'templates/vendors/material-pro/css/colors/purple-dark.css': 'templates/vendors/material-pro/scss/colors/purple-dark.scss',
                    'templates/vendors/material-pro/css/colors/red.css': 'templates/vendors/material-pro/scss/colors/red.scss',
                    'templates/vendors/material-pro/css/colors/red-dark.css': 'templates/vendors/material-pro/scss/colors/red-dark.scss',
                    'templates/vendors/material-pro/css/style.css': 'templates/vendors/material-pro/scss/style.scss'
                }
            },
            custom: {
                files: {
                    'style/css/custom.css': 'style/scss/custom.scss',
                    'style/css/toastr.css': 'style/scss/toastr.scss'
                }
            }
        },
        postcss: {
            options: {
                map: {
                    inline: false, // inline sourcemaps
                    annotation: 'templates/vendors/material-pro/css/sourcemaps'
                },
                processors: [
                    require('pixrem')(), //add fallbacks for rem units,
                    require('autoprefixer')({ overrideBrowserslist: ['last 3 versions', 'ie 11'] }), //add vendor prefixes
                    require('cssnano')() //minify the result

                ]
            },
            dist: {
                src: 'templates/vendors/material-pro/css/*.css'
            },
            custom: {
                src: 'style/css/custom.css'
            }
        },
        cssmin: {
            options: {
                mergeIntoShorthands: false,
                roundingPrecision: -1
            },
            target: {
                files: [{
                    expand: true,
                    cwd: 'template/vendors/material-pro/css',
                    src: ['*.css', '!*.min.css'],
                    dest: 'template/vendors/material-pro/css',
                    ext: '.min.css'

                }]
            }
        },
        watch: {
            files: ['template/vendors/material-pro/scss/*.scss'],
            tasks: ['concat', 'sass', 'cssmin', 'postcss']
        }
    });

    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-sass');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-postcss');

    grunt.registerTask('default', ['concat', 'sass', 'cssmin', 'postcss']);
    grunt.registerTask('build', ['concat', 'sass', 'cssmin', 'postcss']);
    grunt.registerTask('custom_build', ['sass', 'postcss']);
    grunt.registerTask('watch');

}
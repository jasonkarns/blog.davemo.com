# Exports an object that defines
#  all of the configuration needed by the projects'
#  depended-on grunt tasks.
#
# You can find the parent object in: node_modules/lineman/config/application.coffee
#

siteConfig =
  author: "David Mosher"
  title: "david mosher"
  description: "personal and semi-professional opinions of a web designer and developer living in saskatoon, sk, canada"
  url: "http://blog.davemo.com"
  rssCount: 10 #<-- remove, comment, or set to zero to disable RSS generation
  disqus: "davidmosher" #<-- uncomment and set your disqus account name to enable disqus support


_ = require("underscore")
lineman = require("lineman")

# A little function to make it easy to swap named tasks in an array
replaceTask = (search, replace, type = "common") ->
  _(lineman.config.application.appTasks[type]).tap (tasks) ->
    tasks[_(tasks).indexOf(search)] = replace

module.exports = lineman.config.extend "application"

  # Use grunt-markdown-blog in lieu of Lineman's built-in homepage task
  appTasks:
    common: replaceTask("homepage:dev", "markdown:dev", "common")
    dist: replaceTask("homepage:dist", "markdown:dist", "dist")

  markdown:
    options: _(siteConfig).extend
      layouts:
        wrapper: "app/templates/wrapper.us"
        index: "app/templates/index.us"
        post: "app/templates/post.us"
        archive: "app/templates/archive.us"
      paths:
        markdown: "app/posts/*.md"
        posts: "posts"
        index: "index.html"
        archive: "archive.html"
        rss: "index.xml"

    dev:
      dest: "generated"
      context:
        js: "../js/app.js"
        css: "../css/app.css"

    dist:
      dest: "dist"
      context:
        js: "../js/app.min.js"
        css: "../css/app.min.css"

  watch:
    markdown:
      files: ["app/posts/*.md", "app/templates/*.us"]
      tasks: ["markdown:dev"]

Chaplin = require "chaplin"
Posts = require "models/posts"
PostsView = require "views/posts"
HeaderView = require "views/header"

module.exports = class PostsController extends Chaplin.Controller
  show: (params) ->
    # Unescape matched parts of url.
    # Why the hell chaplin doesn't do it by himself?
    # XXX: Seems like what we should use encodeURIComponent
    # and then decode it for each url parameter like user or id
    # but we hope that they will not contain "bad" characters
    # in future.
    params.tag = decodeURIComponent params.tag if params.tag?
    params.club = decodeURIComponent params.club if params.club?

    # Bnw API returns Error 500 if feed request contains use_bl key
    query = if params.id is "feed" then {} else use_bl: 1
    if params.user?
      query.user = params.user
      query.show = params.show
      query.tag = params.tag if params.tag?
      params.title = "@#{params.user}"
      breadcrumbs = [["/u/#{params.user}", "user", params.user]]
      if params.tag?
        breadcrumbs.push ["/u/#{params.user}/t/#{params.tag}", "tag",
                          params.tag]
    else if params.club?
      query.club = params.club
      params.title = "!#{params.club}"
      breadcrumbs = [["/c/#{params.club}", "group", params.club]]
    else if params.tag?
      query.tag = params.tag
      params.title = "*#{params.tag}"
      breadcrumbs = [["/t/#{params.tag}", "tag", params.tag]]
    else
      breadcrumbs = []

    @collection = new Posts [], id: params.id, query: query
    @view = new PostsView
      collection: @collection
      scrollable: params.scrollable
      pageUser: params.user
      show: params.show
      enableNewPostWs: params.enableNewPostWs
    @adjustTitle params.title
    HeaderView::updateBreadcrumbs breadcrumbs

# Description:
#   Notifies about any available GitHub repo event via webhook
#
# Configuration:
#   (See: http://developer.github.com/webhooks/#events)
#
#   You will have to do the following:
#   1. Create a new webhook for your `myuser/myrepo` repository at:
#    https://github.com/myuser/myrepo/settings/hooks/new
#
#   2. Select the individual events to minimize the load on your Hubot.
#
#   3. Add the url: <HUBOT_URL>:<PORT>/hubot/gh-repo-events[?room=<room>]
#    (Don't forget to urlencode the room name, especially for IRC. Hint: # = %23)
#
# Commands:
#   None
#
# URLS:
#   POST /hubot/gh-repo-events?room=<room>
#
# Notes:
#   Currently tested with the following event types in HUBOT_GITHUB_EVENT_NOTIFIER_TYPES:
#     - issue
#     - page_build
#     - pull_request
#     - push
#
# Authors:
#   spajus
#   patcon
#   parkr
#   strugee

inspect = (require('util')).inspect
url = require('url')
querystring = require('querystring')

module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    query = querystring.parse(url.parse(req.url).query)
    data = req.body
    robot.logger.debug "github-repo-event-notifier: Received POST to /hubot/gh-repo-events with data = #{inspect data}"
    room = query.room || process.env["HUBOT_GITHUB_EVENT_NOTIFIER_ROOM"]
    eventType = req.headers["x-github-event"]

    robot.messageRoom room, JSON.stringify(data);

    res.end ""

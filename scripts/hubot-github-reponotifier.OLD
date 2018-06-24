# Description:
#   Hubot slack notifications for github repo events.
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
# WebHook URL:
#   POST /hubot/gh-repo-events?room=<room>

url = require('url')
querystring = require('querystring')

module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    query = querystring.parse(url.parse(req.url).query)
    data = JSON.parse(req.body.payload)
    room = query.room || process.env["HUBOT_GITHUB_EVENT_NOTIFIER_ROOM"]
    eventType = req.headers["x-github-event"]

    commits = data.commits
    head_commit = data.head_commit
    repo = data.repository
    repo_link = repo.html_url
    pusher = data.pusher

    if !data.deleted
      if commits.length == 1
        commit_link = "<#{head_commit.url} | #{head_commit.message}>"
        robot.messageRoom room, "[#{repo_link}] New commit #{commit_link} by #{pusher.name}"
      else if commits.length > 1
        message = "[#{repo_link}] #{pusher.name} pushed #{commits.length} commits:"
        for commit in commits
          commit_link = "<#{commit.url}|#{commit.message}>"
          message += "\n#{commit_link}"
        robot.messageRoom room, message


    console.log(data);
    res.end ""

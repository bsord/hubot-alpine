# Hubot-Alpine






Putting hubot inside Docker


## Testing

Pre-requisites:

- A slack token for your bot

To build a docker image
```
docker build -t hubot-alpine .
```

Deploy prebuilt docker image (Simple)
```
docker run -d -e HUBOT_SLACK_TOKEN=YOURSLACKTOKENHERE --name CONTAINERNAME bsord/hubot-alpine
```
Deploy prebuilt docker image (With Webhooks)
```
docker run -d -p 8080:8080 -e HUBOT_SLACK_TOKEN=YOURSLACKTOKENHERE -e HUBOT_GITHUB_EVENT_NOTIFIER_TYPES=pull_request,page_build,push --name CONTAINERNAME bsord/hubot-alpine
```

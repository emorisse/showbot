# Description:
#   Grab dgshow episode urls
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot dgshow ep[num]- Dave and Gunnar Show Episode <num>
#   hubot dgshow latest - Most recent Dave and Gunnar Show episode 
#
# Authors of xkcd script:
#   twe4ked
#   Hemanth (fixed the max issue)
#
# Author of dgshow script:
#   ghelleks

module.exports = (robot) ->
  robot.respond /dgshow latest/i, (msg) ->
    msg.http("http://dgshow.org/wp-json/posts")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Can\'t connect to the API.'
        else
          object = JSON.parse(body)[0]
          msg.send object.link

  robot.respond /dgshow ep(\d+)/i, (msg) ->
    num = "#{msg.match[1]}"

    msg.http("http://dgshow.org/wp-json/posts?filter[s]=%23#{num}")
      .get() (err, res, body) ->
        if res.statusCode == 404
          msg.send 'Episode #{num} not found.'
        else
          object = JSON.parse(body)[0]
          msg.send object.link


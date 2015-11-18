class Dashing.Checkmyws extends Dashing.Widget
 
  ready: ->
    if @get('unordered')
      $(@node).find('ol').remove()
    else
      $(@node).find('ul').remove()
 
  onData: (data) ->
  	node = $(@node)
  	status = data.overall_status
  	node.addClass "status-#{status}"

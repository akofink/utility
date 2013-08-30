setupLinks = ->
  $('#tasks a').attr "target", "_blank"

divAtIndex = (index) ->
  $ taskItemsInView()[index]

setStatus = (div, done) ->
  div.toggleClass "glyphicon-ok", done
  div.toggleClass "glyphicon-minus", not done

statusDiv = (taskDiv) ->
  taskDiv.find ".glyphicon-minus, .glyphicon-ok"

cachedtaskItems = ->
  localStorage["taskItems"] = JSON.stringify([])  unless localStorage["taskItems"]
  JSON.parse localStorage["taskItems"]

savetaskItems = (taskItems) ->
  localStorage["taskItems"] = JSON.stringify(taskItems)

taskDate = (taskItem) ->
  $(taskItem).find("h4").html()

taskBody = (taskDiv) ->
  $(taskDiv).find("p").html()

taskIndex = (taskDiv) ->
  taskItemsInView().index taskDiv

taskItemsInView = ->
  $ "#tasks .task-item"

taskFromDiv = (taskDiv) ->
  title: taskTitle(taskDiv)
  body: taskBody(taskDiv)

$(document).on "click", ".editable:not(a)", (event) ->
  $(this).toggleClass "editable", false
  $(this).html "<input type='text' class='task-form-item form-control' value='" + $(this).html().trim() + "'>"
  $(this).find("input").focus()

$(document).on "blur", "input.task-form-item", (event) ->
  parentSection = $(this).parent("p, h4")
  parentSection.toggleClass "editable", true
  taskDiv = parentSection.parent()
  $(this).replaceWith $(this).val().trim()
  taskItems = cachedtaskItems()
  index = taskIndex(taskDiv)
  if index is taskItems.length
    taskItems.push taskFromDiv(taskDiv)
  else
    taskItems[index] = taskFromDiv(taskDiv)
  savetaskItems taskItems

$(document).on "click", "#add-task", (event) ->
  $("#tasks").append $("#new-task-form").html()

$(document).on "click", "#remove-task", (event) ->
  taskDiv = $(this).parent()
  index = taskIndex(taskDiv)
  taskItems = cachedtaskItems()
  taskItems.splice index, 1
  savetaskItems taskItems
  taskDiv.remove()

$(document).on "ready", ->
  setupLinks()

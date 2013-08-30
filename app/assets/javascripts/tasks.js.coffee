# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


setupLinks = ->
  $("a").attr "target", "_blank"

populateTodo = ->
  todoItems = cachedTodoItems()
  for i of todoItems
    todoItems.splice i, 1  unless todoItems[i]?
    itemToAppend = "\
        <div class='list-group-item todo-item'>\
          <button class='btn btn-xs pull-right' id='toggle-status'>\
            <span class='glyphicon glyphicon-minus'></span>\
          </button>\
          <button class='btn btn-xs pull-right' id='remove-todo'>\
            <span class='glyphicon glyphicon-remove'></span>\
          </button>\
          <button class='btn btn-xs pull-right' id='move-up-todo'>\
            <span class='glyphicon glyphicon-arrow-up'></span>\
          </button>\
          <button class='btn btn-xs pull-right' id='move-down-todo'>\
            <span class='glyphicon glyphicon-arrow-down'></span>\
          </button>\
          <h4 class='list-group-item-heading editable'>" + todoItems[i].date + "</h4>\
          <p class='list-group-item-text editable'>\
            " + todoItems[i].body + "\
          </p>\
        </div>\
        "
    $("#todo-items").append itemToAppend
    setStatus statusDiv(divAtIndex(i)), todoItems[i].status or false
  saveTodoItems todoItems

divAtIndex = (index) ->
  $ todoItemsInView()[index]

setStatus = (div, done) ->
  div.toggleClass "glyphicon-ok", done
  div.toggleClass "glyphicon-minus", not done

statusDiv = (todoDiv) ->
  todoDiv.find ".glyphicon-minus, .glyphicon-ok"

cachedTodoItems = ->
  localStorage["todoItems"] = JSON.stringify([])  unless localStorage["todoItems"]
  JSON.parse localStorage["todoItems"]

saveTodoItems = (todoItems) ->
  localStorage["todoItems"] = JSON.stringify(todoItems)

todoDate = (todoItem) ->
  $(todoItem).find("h4").html()

todoBody = (todoDiv) ->
  $(todoDiv).find("p").html()

todoStatus = (todoDiv) ->
  statusDiv($(todoDiv)).hasClass "glyphicon-ok"

todoIndex = (todoDiv) ->
  todoItemsInView().index todoDiv

todoItemsInView = ->
  $ "#todo-items .todo-item"

todoFromDiv = (todoDiv) ->
  date: todoDate(todoDiv)
  body: todoBody(todoDiv)
  status: todoStatus(todoDiv)

$(document).on "click", ".editable:not(a)", (event) ->
  $(this).toggleClass "editable", false
  $(this).html "<input type='text' class='todo-form-item form-control' value='" + $(this).html().trim() + "'>"
  $(this).find("input").focus()

$(document).on "blur", "input.todo-form-item", (event) ->
  parentSection = $(this).parent("p, h4")
  parentSection.toggleClass "editable", true
  todoDiv = parentSection.parent()
  $(this).replaceWith $(this).val().trim()
  todoItems = cachedTodoItems()
  index = todoIndex(todoDiv)
  if index is todoItems.length
    todoItems.push todoFromDiv(todoDiv)
  else
    todoItems[index] = todoFromDiv(todoDiv)
  saveTodoItems todoItems

$(document).on "click", "#add-todo", (event) ->
  $("#todo-items").append $("#new-todo-item-form").html()

$(document).on "click", "#toggle-status", (event) ->
  todoDiv = $(this).parent()
  index = todoIndex(todoDiv)
  todoItems = cachedTodoItems()
  currentItem = todoItems[index]
  setStatus statusDiv(todoDiv), not currentItem.status or false
  currentItem.status = todoStatus(todoDiv)
  saveTodoItems todoItems

$(document).on "click", "#remove-todo", (event) ->
  todoDiv = $(this).parent()
  index = todoIndex(todoDiv)
  todoItems = cachedTodoItems()
  todoItems.splice index, 1
  saveTodoItems todoItems
  todoDiv.remove()

$(document).on "click", "#move-up-todo", (event) ->
  todoDiv = $(this).parent()
  index = todoIndex(todoDiv)
  todoDiv.insertBefore todoDiv.prev()
  todoItems = cachedTodoItems()
  currentItem = todoItems[index]
  todoItems[index] = todoItems[index - 1]
  todoItems[index - 1] = currentItem
  saveTodoItems todoItems

$(document).on "click", "#move-down-todo", (event) ->
  todoDiv = $(this).parent()
  index = todoIndex(todoDiv)
  todoDiv.insertAfter todoDiv.next()
  todoItems = cachedTodoItems()
  currentItem = todoItems[index]
  todoItems[index] = todoItems[index + 1]
  todoItems[index + 1] = currentItem
  saveTodoItems todoItems

$(document).on "ready", ->
  populateTodo()
  setupLinks()

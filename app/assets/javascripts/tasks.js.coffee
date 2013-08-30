$(document).on 'ready page:load', ->
  setupLinks = ->
    $('#tasks a').attr "target", "_blank"

  taskTitle = (taskItem) ->
    $(taskItem).find("h4").html()

  updateTitle = (taskDiv, title) ->
    $(taskDiv).find('#task_title').val(title)

  taskBody = (taskDiv) ->
    $(taskDiv).find("p").html()

  updateBody = (taskDiv, body) ->
    $(taskDiv).find('#task_body').val(body)

  taskId = (taskDiv) ->
    $(taskDiv).find('#task_id').val()

  updateId = (taskDiv, id) ->
    $(taskDiv).find('#task_id').val(id)

  updateDiv = (taskDiv, task) ->
    updateId taskDiv, task.id
    updateTitle taskDiv, task.title
    updateBody taskDiv, task.body

  taskFromDiv = (taskDiv) ->
    {
      id: taskId(taskDiv)
      title: taskTitle(taskDiv)
      body: taskBody(taskDiv)
    }

  tasksInView = ->
    $('#tasks .task')

  saveTask = (taskDiv) ->
    task = taskFromDiv taskDiv
    $.ajax
      url: 'tasks/update',
      data: { task: task },
      type: 'PUT',
      success: (data, status, xhr) ->
        task.id = data.id
        updateDiv taskDiv, task

  destroyTask = (taskDiv) ->
    task = taskFromDiv taskDiv
    $.ajax
      url: 'tasks/destroy',
      data: { task: task },
      type: 'DELETE'

  $(document).on "click", "#add-task", (event) ->
    $("#tasks").append $("#new-task-form").html()
    taskDiv = tasksInView().last()
    saveTask taskDiv

  $(document).on "click", ".editable:not(a)", (event) ->
    $(this).toggleClass "editable", false
    $(this).html "<input type='text' class='task-form-item form-control' value='" + $(this).html().trim() + "'>"
    $(this).find("input").focus()

  $(document).on "blur", "input.task-form-item", (event) ->
    parentSection = $(this).parent("p, h4")
    parentSection.toggleClass "editable", true
    taskDiv = parentSection.parent()
    text = $(this).val().trim()
    $(this).replaceWith text
    saveTask taskDiv

  $(document).on "click", "#remove-task", (event) ->
    taskDiv = $(this).parent()
    taskDiv.remove()
    destroyTask taskDiv

  setupLinks()

$(document).on 'ready page:load', ->
  setupLinks = ->
    $('#tasks a').attr "target", "_blank"

  taskDue = (taskDiv) ->
    $(taskDiv).find("#task_due").html()

  updateDue = (taskDiv, due) ->
    $(taskDiv).find('#task_due').val(due)

  taskTitle = (taskItem) ->
    $(taskItem).find("#task_title").html().trim()

  updateTitle = (taskDiv, title) ->
    $(taskDiv).find('#task_title').val(title)

  taskBody = (taskDiv) ->
    $(taskDiv).find("#task_body").html().trim()

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
      due: taskDue(taskDiv)
      title: taskTitle(taskDiv)
      body: taskBody(taskDiv)
    }

  tasksInView = ->
    $('#tasks .task')

  saveTask = (taskDiv) ->
    task = taskFromDiv taskDiv
    console.log JSON.stringify(task)
    $.ajax
      url: 'tasks/update',
      data: { task: task },
      type: 'PUT',
      success: (data, status, xhr) ->
        task.id = data.id
        updateDiv taskDiv, task
        reloadTasks()

  destroyTask = (taskDiv) ->
    task = taskFromDiv taskDiv
    $.ajax
      url: 'tasks/destroy',
      data: { task: task },
      type: 'DELETE'

  reloadTasks = ->
    $.ajax
      url: 'dashboard/tasks',
      success: (data, status, xhr) ->
        $('#tasks_partial').html data


  $(document).on "click", "#add-task", (event) ->
    $("#tasks").append $("#new-task-form").html()
    taskDiv = tasksInView().last()
    saveTask taskDiv

  $(document).on "click", ".editable:not(a)", (event) ->
    element = $(this).closest('#task_due, #task_title, #task_body')
    element.toggleClass "editable", false
    element.html "<input type='text' class='task-form-item form-control' value='" + $(this).html().trim() + "'>"
    element.find("input").focus()

  $(document).on "blur", "input.task-form-item", (event) ->
    $(this).closest('span').toggleClass "editable", true
    taskDiv = $(this).closest('.task')
    text = $(this).val().trim()
    if text == ''
      text = $(this).closest('span').attr 'id'
    $(this).replaceWith text
    saveTask taskDiv

  $(document).on "click", "#remove-task", (event) ->
    taskDiv = $(this).parent()
    taskDiv.remove()
    destroyTask taskDiv

  setupLinks()

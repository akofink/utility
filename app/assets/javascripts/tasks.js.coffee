$(document).on 'ready page:load', ->
  setupLinks = ->
    $('#tasks a').attr "target", "_blank"

  taskContent = (taskDiv, section) ->
    element = $(taskDiv).find(".task_" + section)
    if section == 'status'
      return element.find('span').hasClass('glyphicon-ok')
    if section == 'id'
      return element.val()

    element.html().trim()

  updateContent = (taskDiv, section, content) ->
    if section == 'status'
      $(taskDiv).
        find('.task_status span').
        toggleClass('glyphicon-ok', content)
      $(taskDiv).
        find('.task_status span').
        toggleClass('glyphicon-minus', !content)

    $(taskDiv).select('.task_' + section).val(content)

  updateDiv = (taskDiv, task) ->
    updateContent taskDiv, 'id', task.id
    updateContent taskDiv, 'due', task.due
    updateContent taskDiv, 'status', task.status
    updateContent taskDiv, 'title', task.title
    updateContent taskDiv, 'body', task.body

  taskFromDiv = (taskDiv) ->
    {
      id: taskContent(taskDiv, 'id')
      due: taskContent(taskDiv, 'due')
      status: taskContent(taskDiv, 'status')
      title: taskContent(taskDiv, 'title')
      body: taskContent(taskDiv, 'body')
    }

  tasksInView = ->
    $('#tasks .task')

  saveTask = (taskDiv) ->
    task = taskFromDiv taskDiv
    console.log task
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
      url: 'dashboards/tasks',
      success: (data, status, xhr) ->
        $('#tasks_partial').html data
        setupLinks()

  $(document).on "click", ".editable", (event) ->
    unless $(this).find('input').length > 0
      if event.shiftKey
        event.preventDefault()

        element = $(this).find('.task_body')
        if element.length == 0
          element = $(this).closest('.task_due, .task_title')
        element.html "<input type='text' class='task-form-item form-control' value='" + element.html().trim() + "'>"
        element.find("input").focus()

  $(document).on "blur", ".editable input", (event) ->
    taskDiv = $(this).closest('.task')
    text = $(this).val().trim()
    if text == ''
      text = taskContent taskDiv, 'id'
    $(this).replaceWith text
    saveTask taskDiv

  $(document).on "click", ".add_task", (event) ->
    $("#tasks").append $(".new-task-form").html()
    saveTask tasksInView().last()


  $(document).on "click", ".remove_task", (event) ->
    taskDiv = $(this).parent()
    taskDiv.remove()
    destroyTask taskDiv

  $(document).on "click", ".task_status", (event) ->
    taskDiv = $(this).parent()
    updateContent taskDiv, 'status', !taskContent(taskDiv, 'status')
    saveTask taskDiv

  setupLinks()

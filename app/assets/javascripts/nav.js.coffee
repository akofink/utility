$(document).on 'ready page:load', ->

  set_active_nav = ->
    current_url = document.URL
    for nav_link in $('nav').find('a')
      if nav_link.href == current_url
        $(nav_link).parent().addClass 'active'
        $(nav_link).addClass 'active'
  set_active_nav()

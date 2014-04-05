refresh_page = ->
  if !document.disable_auto_refresh
    location.reload()

document.auto_refresh = ->
  document.disable_auto_refresh = false
  setTimeout ->
    refresh_timer = refresh_page()
  , 30000

function init()
    m.category_screen = m.top.findNode("category_screen")
    m.content_screen = m.top.findNode("content_screen")
    m.details_screen = m.top.findNode("details_screen")
    m.video_player = m.top.findNode("video_player")
    m.error_dialog = m.top.findNode("error_dialog")
    initVideoPlayer()
    m.content_screen.observeField("content_selected", "onContentSelected")
    m.category_screen.observeField("category_selected", "onCategorySelected")
    m.details_screen.observeField("play_button_pressed", "onPlayButtonPressed")
    m.category_screen.setFocus(true)
end function

function onKeyEvent(key, press) as boolean
    if key = "back" and press
        if m.content_screen.visible
            m.content_screen.visible = false
            m.category_screen.visible = true
            m.category_screen.setFocus(true)
            return true
        else if m.details_screen.visible
            m.details_screen.visible = false
            m.content_screen.visible = true
            m.content_screen.setFocus(true)
            return true
        else if m.video_player.visible
            closeVideo()
            return true
        end if
    end if
    return false
end function

sub initVideoPlayer()
    m.video_player.EnableCookies()
    m.video_player.setCertificatesFile("common:/certs/ca-bundle.crt")
    m.video_player.InitClientCertificates()
    m.video_player.observeFieldScoped("state", "onPlayerStateChanged")
end sub

sub onContentSelected(obj)
    selected_index = obj.getData()
    m.selected_media = m.content_screen.findNode("content_grid").content.getChild(selected_index)
    m.details_screen.content = m.selected_media
    m.content_screen.visible = false
    m.details_screen.visible = true
end sub

sub onPlayButtonPressed(obj)
    m.details_screen.visible = false
    m.video_player.visible = true
    m.video_player.setFocus(true)
    m.video_player.content = m.selected_media
    m.video_player.control = "play"
end sub

sub onPlayerStateChanged(obj)
    state = obj.getData()
    if state = "error"
        showErrorDialog(m.video_player.errorMsg, m.video_player.errorCode)
    else if state = "finished"
        closeVideo()
    end if
end sub

sub showErrorDialog(msg, code)
    m.error_dialog.message = msg + chr(10) + "Error Code: " + code.toStr()
    m.error_dialog.visible = true
    m.top.dialog = m.error_dialog
end sub

sub closeVideo()
    m.video_player.control = "stop"
    m.video_player.visible = false
    m.details_screen.visible = true
    m.details_screen.setFocus(true)
end sub

sub onCategorySelected(obj)
    list = m.category_screen.findNode("category_list")
    item = list.content.getChild(obj.getData())
    loadFeed(item.feed_url)
end sub

sub loadFeed(feed_url)
    appInfo = CreateObject("roAppInfo")
    content_server = appInfo.getValue("content_server")
    m.feed_task = CreateObject("roSGNode", "load_feed_task")
    m.feed_task.observeField("response", "onFeedResponse")
    m.feed_task.url = content_server + feed_url
    m.feed_task.control = "RUN"
end sub

sub onFeedResponse(obj)
    response = obj.getData()
    data = ParseJson(response)
    if data <> invalid and data.items <> invalid
        m.category_screen.visible = false
        m.content_screen.visible = true
        m.content_screen.feed_data = data
    else
        ? "NO FEED DATA!"
    end if
end sub
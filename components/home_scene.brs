function init()
    m.category_screen = m.top.findNode("category_screen")
    m.content_screen = m.top.findNode("content_screen")
    m.details_screen = m.top.findNode("details_screen")
    m.video_player = m.top.findNode("video_player")
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
            m.video_player.visible = false
            m.details_screen.visible = true
            m.details_screen.setFocus(true)
            return true
        end if
    end if
    return false
end function

sub onContentSelected(obj)
    selected_index = obj.getData()
    item = m.content_screen.findNode("content_grid").content.getChild(selected_index)
    m.details_screen.content = item
    m.content_screen.visible = false
    m.details_screen.visible = true
end sub

sub onPlayButtonPressed(obj)
    m.details_screen.visible = false
    m.video_player.visible = true
    m.video_player.setFocus(true)
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
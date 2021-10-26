function init()
    m.category_screen = m.top.findNode("category_screen")
    m.content_screen = m.top.findNode("content_screen")
    m.category_screen.observeField("category_selected", "onCategorySelected")
    m.category_screen.setFocus(true)
end function

function onKeyEvent(key, press) as boolean
    return false
end function

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
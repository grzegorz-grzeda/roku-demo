function init()
    m.category_list = m.top.findNode("category_list")
    m.category_list.setFocus(true)
    m.category_list.observeField("itemSelected", "onCategorySelected")
end function

sub onCategorySelected(obj)
    item = m.category_list.content.getChild(obj.getData())
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
    ? "onFeedResponse "; obj.getData()
end sub
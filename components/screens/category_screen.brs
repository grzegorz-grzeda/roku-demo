function init()
    m.category_list = m.top.findNode("category_list")
    m.category_list.setFocus(true)
    m.category_list.observeField("itemSelected", "onCategorySelected")
end function

sub onCategorySelected(obj)
    item = m.category_list.content.getChild(obj.getData())
    loadFeed(item.feed_url)
end sub

sub loadFeed(url)
    appInfo = CreateObject("roAppInfo")
    content_server = appInfo.getValue("content_server")
    ? "loadFeed! ";content_server;url
end sub
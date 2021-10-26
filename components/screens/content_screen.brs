sub init()
    m.header = m.top.findNode("header")
    m.content_grid = m.top.findNode("content_grid")
    m.top.observeField("visible", "onVisibleChanged")
end sub

sub onVisibleChanged()
    if m.top.visible then m.content_grid.setFocus(true)
end sub

sub onFeedChange(obj)
    feed = obj.getData()
    m.header.text = feed.title
    posterContent = createObject("roSGNode", "ContentNode")
    appInfo = CreateObject("roAppInfo")
    content_server = appInfo.getValue("content_server")
    for each item in feed.items
        node = CreateObject("roSGNode", "ContentNode")
        node.streamformat = item.streamformat
        node.title = item.title
        node.url = item.url
        node.description = item.description
        node.HDGRIDPOSTERURL = content_server + item.thumbnail
        node.SHORTDESCRIPTIONLINE1 = item.title
        node.SHORTDESCRIPTIONLINE2 = item.description
        postercontent.appendChild(node)
    end for
    showpostergrid(postercontent)
end sub

sub showpostergrid(content)
    m.content_grid.content = content
    m.content_grid.visible = true
    m.content_grid.setFocus(true)
end sub
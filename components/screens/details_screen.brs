sub init()
    m.title = m.top.FindNode("title")
    m.description = m.top.FindNode("description")
    m.thumbnail = m.top.FindNode("thumbnail")
    m.play_button = m.top.FindNode("play_button")
    m.top.observeField("visible", "onVisibleChange")
end sub

sub onVisibleChange()
    if m.top.visible then m.play_button.setFocus(true)
end sub

sub onContentChange(obj)
    item = obj.getData()
    m.title.text = item.title
    m.description.text = item.description
    m.thumbnail.uri = item.HDGRIDPOSTERURL
end sub
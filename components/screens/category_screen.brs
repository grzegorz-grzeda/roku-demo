function init()
    m.category_list = m.top.findNode("category_list")
    m.category_list.setFocus(true)
    m.top.observeField("visible", "onVisibleChanged")
end function

sub onVisibleChanged()
    if m.top.visible then m.category_list.setFocus(true)
end sub

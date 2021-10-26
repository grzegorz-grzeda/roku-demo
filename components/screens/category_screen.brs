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
  ? "loadFeed! ";url
end sub
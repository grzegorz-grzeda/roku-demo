sub main()
    ? "[main] main"
    printDeviceInfo()
    runApp()
end sub

sub printDeviceInfo()
    app_info = createObject("roAppInfo")
    ? "App Title: ", app_info.getTitle()
    ? "App Version: ", app_info.getVersion()
    ? "Channel ID: ", app_info.getID()
    ? "isDev: ", app_info.isDev()
    ? "- - - - - - - - - - - - - - - - "
    device_info = createObject("roDeviceInfo")
    ? "Model: ", device_info.getModel()
    ? "Display Name: ", device_info.getModelDisplayName()
    ? "Firmware: ", device_info.getVersion()
    ? "Device ID: ", device_info.GetChannelClientId()
    ? "Friendly Name: ", device_info.getFriendlyName()
    display_size = device_info.getDisplaySize()
    ? "Display Size: ", display_size.w;"x";display_size.h
    ? "UI Resolution: ", device_info.getUIResolution()
    ? "Video Mode: ", device_info.getVideoMode()
    ? "IP Address: ", device_info.getExternalIp()
end sub

sub runApp() 
	screen = createObject("roSGScreen")
	scene = screen.createScene("home_scene")
	screen.Show()

	port = createObject("roMessagePort")
	screen.setMessagePort(m.port)
	while(true)
		' the HOME and BACK buttons on the remote will nuke the app
	end while
end sub
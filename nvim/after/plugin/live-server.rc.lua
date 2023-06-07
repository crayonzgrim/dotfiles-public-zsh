local status, liveServer = pcall(require, "live-server")
if not status then
	return
end

liveServer.setup()

/client/proc/update_server()
	set category = "Server"
	set name = "Update Server"
	if (!usr.client.holder)
		return
	var/confirm = alert("Вы хотите обновить сервер?", "Выберите, когда", "При рестарте", "ПрЯмо сейчас", "Отменить")
	if(confirm == "Отменить")
		if(update_ready == 1)
			update_ready = 0
			message_admins("[key_name_admin(usr)] отменил обновление сервера в конце раунда.")
			log_game("[key_name_admin(usr)] отменил обновление сервера в конце раунда.")
			world << "<span class='danger'>[usr.key] отменил обновление сервера в конце раунда.</span>"
		else
			return
	if(confirm == "При рестарте")
		message_admins("[key_name_admin(usr)] инициировал обновление сервера в конце текущего раунда.")
		log_game("[key_name_admin(usr)] инициировал обновление сервера в конце текущего раунда.")
		world << "<span class='danger'>[usr.key] инициировал обновление сервера в конце текущего раунда. Сервер будет остановлен на пару минут, а затем автоматически запущен.</span>"
		updater_key = usr.key
		update_ready = 1
	if(confirm == "ПрЯмо сейчас")
		updater_key = usr.key
		update_ready = 1
		reboot_updating()

/proc/reboot_updating()
	if(update_ready == 0)
		return
	world << "<span class='danger'><FONT size=5>Внимание, инициализация обновления сервера!</FONT><br>Обновление займет несколько минут, после чего сервер будет автоматически запущен. Ициниатор: [updater_key]</span>."
	sleep(100)
	shell("sh update_server.sh")

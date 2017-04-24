module DiscordBot
	class Information
$bot.command :si do |event|
	begin
		if event.channel.private?
			event.channel.send_embed do |embed|
				embed.title = ':no_entry:'
				embed.description = 'This command cannot be used in a PM!'
				embed.color = 16_722_454
			end
		else
			event.channel.send_embed do |embed|
				embed.title = 'Server Information'
				embed.description = 'Advanced server information.'
				embed.add_field(name: "**#{event.server.name}**", value: "Hosted in **#{event.server.region}** with **#{event.server.channels.count}** channels and **#{event.server.member_count}** members, owned by #{event.server.owner.mention}")
				embed.add_field(name: 'Icon:', value: event.server.icon_url.to_s, inline: true)
				embed.add_field(name: 'IDs:', value: "Server ID: #{event.server.id}, Owner ID: #{event.server.owner.id}", inline: true)
				embed.color = 1_108_583
				embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: event.server.icon_url.to_s)

				embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: event.server.name.to_s, icon_url: event.server.icon_url.to_s)
			end
		end
	rescue
		event.channel.send_embed do |embed|
			embed.title = 'Server Information'
			embed.description = 'Advanced server information.'
			embed.add_field(name: "**#{event.server.name}**", value: "Hosted in **#{event.server.region}** with **#{event.server.channels.count}** channels and **#{event.server.member_count}** members, owned by #{event.server.owner.mention}")

			embed.add_field(name: 'IDs:', value: "Server ID: #{event.server.id}, Owner ID: #{event.server.owner.id}", inline: true)
			embed.color = 1_108_583
			embed.thumbnail = Discordrb::Webhooks::EmbedImage.new(url: event.server.icon_url.to_s)

			embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: event.server.name.to_s)
		end
	end
end

$bot.command :bi do |event|
	event.channel.send_embed do |embed|
		lsc = 0
		ls = $bot.servers.values.each { |s| lsc += 1 if s.large }
		ss = $bot.servers.count - lsc
		embed.title = '$bot Information'
		embed.description = 'Advanced $bot information.'
		embed.add_field(name: 'Currently active on', value: "**#{$bot.servers.count}** servers.")
		embed.add_field(name: lsc.to_s, value: 'Large servers', inline: true)
		embed.add_field(name: ss.to_s, value: 'Small servers.', inline: true)
		embed.add_field(name: $bot.users.count.to_s, value: 'Unique users.', inline: true)
		embed.add_field(name: 'Connected to', value: "#{$bot.servers.count} servers.", inline: true)
		#embed.add_field(name: 'Messages sent since last restart:', value: " #{msg}", inline: true)
		embed.color = 1_108_583
		embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'MnpnBot is hosted on a DigitalOcean Droplet in Amsterdam, Europe.', icon_url: 'http://i.imgur.com/VpeUzUB.png')
	end
end

$bot.command([:ui, :uinfo, :userinfo]) do |event|
	playing = event.user.game
	playing = 'None' if playing.nil?
	event.channel.send_embed do |embed|
		embed.title = 'User Information'
		embed.description = "Name and Tag: #{event.user.name}##{event.user.discrim}"
		embed.add_field(name: 'Status:', value: event.user.status.to_s)
		embed.add_field(name: 'Currently Playing:', value: playing)
		embed.color = 1_108_583
		embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: 'MnpnBot %s.' % [version], icon_url: 'http://i.imgur.com/VpeUzUB.png')
	end
end

$bot.command :psi do |event|
	if event.user.id != event.server.owner.id
		event.channel.send_embed do |embed|
			embed.title = ':no_entry:'
			embed.description = "You're not the owner of this server."
			embed.color = 16_722_454 # red
		end
	else
		event << 'It looks like you, <@%d' % event.server.owner.id + '> is the server owner. This feature is pretty stupid right now.'
	end
end

$bot.command :mnpn do |event|
	if (event.user.id != 172_030_506_970_382_337) && (event.user.id != 292_020_442_422_706_177)
		event.channel.send_embed do |embed|
			embed.title = ':no_entry:'
			embed.description = "You're not Mnpn or Xeon, kek."
			embed.color = 16_722_454 # red
		end
	else
		event.channel.send_embed do |embed|
			embed.title = 'MnpnBot Settings'
			embed.description = 'Here are the current settings.'
			embed.add_field(name: 'Development mode', value: devmode, inline: true)
			embed.add_field(name: 'Count $limit', value: $limit, inline: true)
			embed.add_field(name: 'Version', value: version, inline: true)
			embed.add_field(name: 'Debug mode', value: debug, inline: true)
			embed.add_field(name: '$annoy', value: $annoy, inline: true)
			embed.color = 1_108_583 # green
		end
	end
end
end
end
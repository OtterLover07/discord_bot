require 'discordrb'
require 'dotenv/load'
require_relative 'lib/text_command'
require_relative 'lib/roll_command'
require_relative 'lib/embed_command'

# Hämta token från miljövariabel
token = ENV['DISCORD_BOT_TOKEN']

if token.nil? || token.empty?
  puts "❌ DISCORD_BOT_TOKEN är inte satt!"
  puts "Skapa en .env fil med: DISCORD_BOT_TOKEN=din_token"
  exit 1
end

# Skapa bot
bot = Discordrb::Bot.new(token: token, intents: [:server_messages])
bot_ver = 0.3
admin_ids = [463972375214686216]

# Enkla textkommandon - nu med TextCommand!
hello_command = TextCommand.new(
  name: "hello",
  description: "Says hello",
  text: "Hello!"
)

ping_command = TextCommand.new(
  name: "ping",
  description: "Pings the bot",
  text: "Pong!"
)

roll_command = RollCommand.new

embed_info = EmbedCommand.new(
  name: "botinfo",
  description: "Shows bot info as embed",
  title: "Bot Information",
  embed_description: "OtterBot v#{bot_ver} - Currently building functionality",
  color: 0x00ff00
)
server_info = EmbedCommand.new(
  name: "serverinfo",
  description: "Server info",
  title: "Server Information",
  embed_description: "Info about this server",
  color: 0x0099ff,
  fields: [
    { name: "Members", value: "42" },
    { name: "Created", value: "2024-01-01" }
  ]
)

# Hantera meddelanden
bot.message do |event|
  next if event.user.bot_account?

  content = event.content.strip

  # Dela upp i command och arguments
  parts = content.split
  command_name = parts.first&.downcase
  args = parts[1..]  # Allt efter första ordet

  # Kolla om meddelandet är ett kommando
  case command_name
  when "!shutdown","!goodnight"
    if admin_ids.include?(event.user.id)
      event.respond("Goodnight!")
      exit
    end
  when "!die"
    if admin_ids.include?(event.user.id)
      event.respond("Ok, guess I'll die!")
      exit
    else
      event.respond("You don't have access to this command.")
    end
  when "!hello"
    hello_command.execute(event)
  when "!ping"
    ping_command.execute(event)
  when "!botinfo","!info"
    embed_info.execute(event)
  when "!serverinfo"
    server_info.execute(event)
  when "!roll"
    roll_command.execute(event, args)  
  when "!nuke"
    if admin_ids.include?(event.user.id)
      message = ""
      100.times {message << "text\n"}
      event.respond(message)
      event.respond("Channel successfully nuked!")
    else
      event.respond("You don't have access to this command.")
    end
  end
end

# Logga när bot:en startar
bot.ready do
  puts "✅ Bot inloggad som: #{bot.profile.username}"
  puts "📡 Bot är online och lyssnar på kommandon!"
  puts "💬 Testa: !hello eller !ping"
end

# Starta bot:en
puts "🚀 Startar bot..."
bot.run
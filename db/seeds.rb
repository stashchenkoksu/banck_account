require 'factory_bot_rails'

10.times do
  FactoryBot.create(:user, :with_tags)
end

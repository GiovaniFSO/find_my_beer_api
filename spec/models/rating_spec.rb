require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { should belong_to(:store) }
  it { should validate_presence_of(:value).with_message("can't be blank") }
  it { should validate_presence_of(:opinion).with_message("can't be blank") }
  it { should validate_presence_of(:user_name).with_message("can't be blank") }
end

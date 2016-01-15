require 'rails_helper'

describe Task do

  context "when user registers" do
    it "changes his email to downcase" do
      user = create(:user, email: "MYMAIL@EXAMPLE.COM")
      expect(user.email).to eq("mymail@example.com")
    end
  end

end

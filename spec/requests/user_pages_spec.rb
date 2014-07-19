require 'rails_helper'

RSpec.describe "UserPages", :type => :request do

	subject { page }

  describe "signup page" do
  	before { visit signup_path }

  	it { should have_content "ユーザアカウント登録" }
  	it { should have_title full_title("ユーザアカウント登録") }
  end
end

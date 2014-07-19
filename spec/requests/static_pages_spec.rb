require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do

	let(:base_title) { "みんなの新聞" }

	subject { page }

  describe "Home page" do 
  	before { visit root_path }

    it { should have_content "#{base_title}" }
    it { should have_title( full_title("") ) }
    it { should_not have_title "| ホーム" }
  end

  describe "About page" do 
  	before { visit about_path }

    it { should have_content('このサイトについて') }
  	it { should have_title( full_title("このサイトについて") ) }
  end

  describe "Contact page" do 
  	before { visit contact_path }

  	it { should have_content("お問い合わせ") }
  	it { should have_title( full_title("お問い合わせ") ) }
  end

end

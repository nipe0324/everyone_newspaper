require 'rails_helper'

RSpec.describe "StaticPages", :type => :request do

	let(:base_title) { "みんなの新聞" }

  describe "Home page" do 
    it "should have the content 'みんなの新聞'" do
    	visit home_path
    	expect(page).to have_content("#{base_title}")
    end

    it "should have the base title" do
    	visit home_path
    	expect(page).to have_title("#{base_title}")
    end

    it "should NOT have a custom page title" do
    	visit home_path
    	expect(page).not_to have_title("| ホーム")
    end
  end

  describe "About page" do 
    it "should have the content 'このサイトについて'" do
    	visit about_path
    	expect(page).to have_content('このサイトについて')
    end

    it "should have the title 'About'" do
    	visit about_path
    	expect(page).to have_title("このサイトについて | #{base_title}")
    end
  end

  describe "Contact page" do 
    it "should have the content 'お問い合わせ'" do
    	visit contact_path
    	expect(page).to have_content('お問い合わせ')
    end

    it "should have the title ''" do
    	visit contact_path
    	expect(page).to have_title("お問い合わせ | #{base_title}")
    end
  end

end

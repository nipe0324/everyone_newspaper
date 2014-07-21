require 'rails_helper'

RSpec.describe "UserPages", :type => :request do

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user) }

	subject { page }

  describe "index(new) & edit page" do
    before do
      login admin
      visit categories_path
    end

    it { should have_title "カテゴリ一覧" }
    it { should have_content "カテゴリ一覧" }

    describe "create" do
    	context "with invalid information" do
	  		it "should not create a category" do
	  			expect { click_button "カテゴリ名を追加" }.not_to change(Category, :count)
	  		end

	  		context "after submission" do
	  			before { click_button "カテゴリ名を追加" }
	    		it { should have_title "カテゴリ一覧" }
			    it { should have_content "カテゴリ一覧" }
			  	it { should have_content "入力してください。" }
	  		end
    	end
	
		 	context "with valid information" do
	  		before do
				  fill_in "カテゴリ名", with: "入力カテゴリ名"
	  		end

	  		it "should create a user" do
	  			expect { click_button "カテゴリ名を追加" }.to change(Category, :count).by(1)
	  		end

	  		context "after saving the user" do
	  			before { click_button "カテゴリ名を追加" }
	  			let(:category) { Category.find_by(name: "入力カテゴリ名") }
	    		it { should have_title "カテゴリ一覧" }
			    it { should have_content "カテゴリ一覧" }
			  	it { should have_content "入力カテゴリ名" }
	  		end
		  end
    end

    describe "update" do
    	let(:category) { FactoryGirl.create(:category) }
    	before { visit edit_category_path(category) }

  		it { should have_title "カテゴリ一覧" }
	    it { should have_content "カテゴリ一覧" }
	    it { should have_content category.name }

    	context "with invalid information" do
	      before do
	      	fill_in "カテゴリ名", with: ""
	      	click_button "カテゴリ名を更新"
	      end
	  		it "should not update a category" do
		      expect(page).to have_content "入力してください。"
	  		end
    	end
	
	    context "with valid information" do
	      let(:new_category_name) { "新カテゴリ名" }
	      before do
	        fill_in "カテゴリ名", with: new_category_name
	        click_button "カテゴリ名を更新"
	      end

	      it { should have_title "カテゴリ一覧" }
	      it { should have_content "新カテゴリ名" }
	      it { should have_success_message "" }
	      specify { expect(category.reload.name).to eq new_category_name }
	    end
    end

    describe "delete" do
    	let!(:category) { FactoryGirl.create(:category) }
    	before { visit categories_path }

	    context "not associated with an article" do
	      it "should be able to delete a category" do
	        expect do
	          click_link('削除')
	        end.to change(Category, :count).by(-1)
	      end

	      context "after delete" do
	        before { click_link "削除" }

	        it { should have_title "カテゴリ一覧" }
	        it { should have_content "カテゴリ一覧" }
	        it { should have_content "削除しました" }
	      end
	    end

	    context "associated with an article" do
	    	let!(:article) { FactoryGirl.create(:article, user: user, category: category) }

	      it "should not be able to delete a category" do
	        expect { click_link "削除" }.not_to change(Category, :count)
				end

	  		context "after submission" do
	  			before { click_link "削除" }

	        it { should have_title "カテゴリ一覧" }
	        it { should have_content "カテゴリ一覧" }
	        it { should have_content "削除できません" }
	  		end
	    end
	  end
  end
end

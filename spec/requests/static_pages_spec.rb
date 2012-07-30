require 'spec_helper'

describe "StaticPages" do

	let(:baseTitle){ "Furious Tomato" }

  describe "Home Page" do

    it "should have the base title content 'Furious Tomato'" do
      visit root_path
			page.should have_selector('title', :text => "#{baseTitle}")
    end
		
		it "should have the h1 content 'Furious Tomato'" do
			visit root_path 
			page.should have_selector('h1', :text => "Furious Tomato")
		end

		it "should not have a custom page title" do 
			visit root_path
			page.should_not have_selector('title', :text => '| Home')
		end

  end
	
  describe "Help Page" do

		it "shoudld have the title content 'Help'" do 
			visit help_path
			page.should have_selector('title', :text => "#{baseTitle} | Help")
	  end

		it "should have the h1 content 'Help'" do
			visit help_path 
			page.should have_selector('h1', :text => "Help")
		end

	end

	describe "About Page" do

		it "should have the title content 'About us" do
			visit about_path 
			page.should have_selector('title',:text => "#{baseTitle} | About us")
		end

		it "should have the h1 content 'About us'" do
			visit about_path
			page.should have_selector('h1', :text => "About us")
		end

	end

	describe "Contact Page" do

		it "should have the title content 'Contact us" do
			visit contact_path
			page.should have_selector('title',text: "#{baseTitle} | Contact us")
		end

		it "should have the h1 content 'contact us'" do
			visit contact_path 
			page.should have_selector('h1', text: "Contact us")
		end

	end
end

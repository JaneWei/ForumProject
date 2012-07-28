require 'spec_helper'

describe "StaticPages" do

  describe "Home Page" do

    it "should have the title content 'Furious Tomato'" do
      visit '/static_pages/home'
			page.should have_selector('title', :text => "Furious Tomato | Home")
    end
		
		it "should have the h1 content 'Home'" do
			visit '/static_pages/home'
			page.should have_selector('h1', :text => "Home")
		end

  end
	
  describe "Help Page" do

		it "shoudld have the title content 'Help'" do 
			visit '/static_pages/help'
			page.should have_selector('title', :text => "Furious Tomato | Help")
	  end

		it "should have the h1 content 'Help'" do
			visit '/static_pages/help'
			page.should have_selector('h1', :text => "Help")
		end

	end

	describe "About Page" do

		it "should have the title content 'About us" do
			visit '/static_pages/about'
			page.should have_selector('title',:text => "Furious Tomato | About us")
		end

		it "should have the h1 content 'About us'" do
			visit '/static_pages/about'
			page.should have_selector('h1', :text => "About us")
		end

	end

end

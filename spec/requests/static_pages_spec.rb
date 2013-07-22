require 'spec_helper'

describe "StaticPages" do

  let(:base_title) {"Ruby on Rails"}

  describe "Home Page" do
    it "deberia tener el h1 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('h1',:text=>'Home')
    end

    it "deberia tener titulo 'Home...'" do
      visit '/static_pages/home'
      page.should have_selector('title',:text=>"#{base_title}| Home")
    end
  end

  describe "Help Page" do
    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title',
                                :text => "#{base_title}| Help")
    end
  end

  describe "About Page" do
    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title',
                                :text => "#{base_title}| About Us")
    end
  end

end

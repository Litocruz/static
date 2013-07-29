require 'spec_helper'

describe "StaticPages" do

  #let(:base_title) {"Ruby on Rails"}
  subject { page }

  describe "Home Page" do
    before {visit root_path}

    it { should have_selector('h1', text: 'Home')}
    it { should have_selector('title', text: full_title(''))}
    it { should_not have_selector('title', text: '| SampleApp')}
  end

  describe "Help Page" do
    before {visit help_path}
    it { should have_selector('h1', text: 'Help')}
    it { should have_selector('title', text: full_title(''))}
  end

  describe "About Page" do
    before {visit about_path}
    it { should have_selector('h1', text: 'About Us')}
    it { should have_selector('title', text: full_title(''))}
  end

  describe "Contact page" do
    before {visit contact_path}
    it { page.should have_selector('h1', text: 'Contact')}
    it { should have_selector('title', text: full_title(''))}
  end
end

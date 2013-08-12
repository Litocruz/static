require 'spec_helper'

describe "StaticPages" do

  #let(:base_title) {"Ruby on Rails"}
  subject { page }

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    should # fill in
    click_link "Contact"
    should # fill in
    click_link "Home"
    click_link "Sign up now!"
    should # fill in
    click_link "sample app"
    should # fill in
  end


  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home Page" do
    before {visit root_path}
    let(:heading) {'Home'}
    let(:page_title) {''}
    it_should_behave_like "all static pages"
    it { should_not have_selector('title', text: '| SampleApp')}
  end

  describe "Help Page" do
    before {visit help_path}
    let(:heading) {'Help'}
    let(:page_title) {''}
    it_should_behave_like "all static pages"
  end

  describe "About Page" do
    before {visit about_path}
    let(:heading) {'About Us'}
    let(:page_title) {''}
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before {visit contact_path}
    let(:heading) {'Contact'}
    let(:page_title) {''}
    it_should_behave_like "all static pages"
  end
end

require 'spec_helper'

describe "StaticPages" do
	let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  subject { page }
  describe "Home page" do
    before { visit root_path }
    it { should have_content('Sample App') }

    it { should have_selector('title',
    						text: full_title("Home")) }

    describe "for signed-in user" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help Page" do
    before { visit help_path }
  	it { should have_content('Help') }
  	it { should have_selector('title',
    						text: full_title("Help")) }
  end

  describe "About page" do
    before { visit about_path }
  	it { should have_content('About Us') }
	  it { should have_selector('title',
    						text: full_title("About Us")) }
	end

	describe "Contact Us page" do
    before { visit contact_path }
		it { should have_selector("h1",    text: 'Contact Us')	}
		it { should have_selector('title', text: full_title("Contact Us")) }
	end

end

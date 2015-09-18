require 'rails_helper'

RSpec.describe BoardsController, type: :feature do

  before(:each) do
    FactoryGirl.create(:board, title: 'Board title #1')
    FactoryGirl.create(:board, title: 'Board title #2')
    visit root_path
    click_on "Enter"
  end

  it "displays all existing boards" do
    expect(page).to have_content('Existing Boards')
    expect(page).to have_content('Board title #1')
    expect(page).to have_content('Board title #2')
  end

  it "can be created" do
    click_on "Create A New Board"
    fill_in "Board Title", with: "Brand new board!"
    # fill_in "New Board Description", with: "Description of brand new board."
    click_on "Create Board"
    # save_and_open_page

    expect(current_path).to eq(boards_path)
    expect(page).to have_content('Brand new board!')
    # expect(page).to have_content("Board was created.")
  end

  it "cannot be created without a title" do
    click_on "Create A New Board"
    fill_in "Board Title", with: ""
    click_on "Create Board"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_button("Create Board")
    # expect(current_path).to eq(new_board_path)
  end

  it "cannot be created without a duplicate title" do
    click_on "Create A New Board"
    fill_in "Board Title", with: "Board title #1"
    click_on "Create Board"

    expect(page).to have_content("Title has already been taken")
    expect(page).to have_button("Create Board")
    # expect(current_path).to eq(new_board_path)
  end

  xit "can be edited" do
    first(:link, "Edit").click

    expect(page).to have_content("Edit Idea:")

    find_field('New Idea Title').value.should eq('Second idea title')
    find_field('New Idea Description').should have_content('Idea #2 Description')

    fill_in 'New Idea Title', with: 'Edited idea title'
    fill_in 'New Idea Description', with: 'Edited idea description'
    click_on "Save"

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Edited idea title')
    expect(page).to have_content('Edited idea description')
    expect(page).to_not have_content('Second idea title')
    expect(page).to_not have_content('Idea #2 Description')
  end

  xit "can be deleted" do
    first(:link, "Delete").click

    expect(current_path).to eq('/')
    expect(page).to have_content('First idea title')
    expect(page).to have_content('Idea #1 Description')
    expect(page).to_not have_content('Second idea title')
    expect(page).to_not have_content('Idea #2 Description')
  end
end

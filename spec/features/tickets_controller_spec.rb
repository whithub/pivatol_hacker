require 'rails_helper'

RSpec.describe TicketsController, type: :feature do

  before(:each) do
    @board = Board.create!(title: "Board-One")
    @ticket = @board.tickets.create!(name: 'Ticket Name #1', description: 'Real good ticket description')
    @ticket_2 = @board.tickets.create!(name: 'Ticket Name #2', description: 'Second awesome ticket description')

    visit root_path
    click_on "Enter"
  end

  it "displays all existing tickets" do
    click_on "Board-one"

    expect(current_path).to eq("/boards/#{@board.id}")
    expect(page).to have_content('Board-One')
    expect(page).to have_content('Ticket Name #1')
    expect(page).to have_content('Ticket Name #2')
    expect(page).to have_content('Second awesome ticket description')
  end

  it "can be created" do
    click_on "Board-one"
    fill_in "Ticket Name", with: "Brand new ticket!"
    fill_in "Ticket Description", with: "Description of what this ticket entails"
    click_on "Create Ticket"

    expect(current_path).to eq("/boards/#{@board.id}")
    expect(page).to have_content('Brand new ticket!')
    expect(page).to have_content('Description of what this ticket entails')
  end

  it "cannot be created without a title" do
    click_on "Board-one"
    fill_in "Ticket Description", with: "Description of what this ticket entails"
    click_on "Create Ticket"

    expect(page).to have_content("Name can't be blank")
    expect(current_path).to eq("/boards/#{@board.id}")
    expect(page).to have_button("Create Ticket")
  end

  it "cannot be created with a duplicate title" do
    click_on "Board-one"
    fill_in "Ticket Name", with: "Ticket Name #1"
    fill_in "Ticket Description", with: "Description of what this ticket entails"
    click_on "Create Ticket"

    expect(page).to have_content("Name has already been taken")
    expect(current_path).to eq("/boards/#{@board.id}")
    expect(page).to have_button("Create Ticket")
  end

  it "can be created without a description, defaults to blank" do
    click_on "Board-one"
    fill_in "Ticket Name", with: "Ticket without a description"
    click_on "Create Ticket"

    expect(current_path).to eq("/boards/#{@board.id}")
    expect(page).to have_content('Ticket without a description')
  end

  it "default status to backlog" do
    click_on "Board-one"
    fill_in "Ticket Name", with: "Ticket Name #3"
    fill_in "Ticket Description", with: "Description of what this ticket entails"
    click_on "Create Ticket"

    expect(@ticket.status).to eq('backlog')
    #expect it's location to be in backlog column...find ticket, grab its status...
  end

  xit "can have any status when created" do
    click_on "Board-one"
    fill_in "Ticket Name", with: "Ticket Name #3"
    fill_in "Ticket Description", with: "Description of what this ticket entails"
    select "In Progress", from: "Status"
    click_on "Create Ticket"

    expect(@ticket.reload.status).to eq('in_progress')
    expect(page).to have_content('Move Back to Current Sprint')
    expect(page).to have_content('Move to Done')
    #expect it's location to be in backlog column...find ticket, grab its status...
  end

  it "can be edited" do
    click_on "Board-one"
    first(:link, "Edit").click

    expect(page).to have_content("Edit Ticket:")

    # expect(page).to have_field('Ticket Name', text: 'Title Name #1')
    # find_field('Ticket Name').value.should eq('Title Name #1')

    # expect(page).to have_field('Ticket Description', with: 'Real good ticket description')
    # find_field('Ticket Description').should have_content('Real good ticket description')

    fill_in 'Ticket Name', with: 'Edited ticket name'
    fill_in 'Ticket Description', with: 'Edited ticket description'
    click_on "Update Ticket"

    expect(current_path).to eq("/boards/#{@board.id}")
    expect(page).to have_content('Edited ticket name')
    expect(page).to have_content('Edited ticket description')
    expect(page).to_not have_content('Ticket Name #1')
    expect(page).to_not have_content('Real good ticket description')
  end

  it "can be deleted" do
    click_on "Board-one"
    first(:link, "Delete").click

    expect(current_path).to eq("/boards/#{@board.id}")
    expect(page).to_not have_content('Ticket Name #1')
    expect(page).to have_content('Ticket Name #2')
  end

  it "in backlog state can only move to current sprint" do
    click_on "Board-one"

    expect(page).to have_content('Move to Current Sprint')
    expect(page).to_not have_content('Move to In Progress')
    expect(page).to_not have_content('Move to Done')

    first(:link, "Move to Current Sprint").click

    expect(page).to have_content('Move Back to Backlog')
    expect(page).to have_content('Move to In Progress')
    expect(page).to_not have_content('Move to Done')
  end

  it "in current sprint state can only move to in_progress or backlog" do
    click_on "Board-one"
    first(:link, "Move to Current Sprint").click
    first(:link, "Move to In Progress").click

    expect(page).to have_content('Move Back to Current Sprint')
    expect(page).to have_content('Move to Done')
    expect(page).to_not have_content('Move to In Progress')
    expect(page).to_not have_content('Move Back to Backlog')

    first(:link, "Move Back to Current Sprint").click
    first(:link, "Move Back to Backlog").click

    expect(page).to have_content('Move to Current Sprint')
    expect(page).to_not have_content('Move to In Progress')
    expect(page).to_not have_content('Move to Done')
  end

  it "in in_progress state can only move to done or current sprint" do
    click_on "Board-one"
    first(:link, "Move to Current Sprint").click
    first(:link, "Move to In Progress").click
    first(:link, "Move to Done").click

    expect(page).to have_content('Move Back to In Progress')
    expect(page).to_not have_content('Move to In Progress')
    expect(page).to_not have_content('Move Back to Backlog')

    first(:link, "Move Back to In Progress").click
    first(:link, "Move Back to Current Sprint").click

    expect(page).to have_content('Move to In Progress')
    expect(page).to have_content('Move Back to Backlog')
    expect(page).to_not have_content('Move to Done')
  end

  it "in done state can only move to in_progress" do
    click_on "Board-one"
    first(:link, "Move to Current Sprint").click
    first(:link, "Move to In Progress").click
    first(:link, "Move to Done").click

    expect(page).to have_content('Move Back to In Progress')
    expect(page).to_not have_content('Move Back to Current Sprint')
    expect(page).to_not have_content('Move Back to Backlog')
  end
end

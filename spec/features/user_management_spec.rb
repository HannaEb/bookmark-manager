feature 'User signs up' do

  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome stuff@what.com')
    expect(User.first.email).to eq('stuff@what.com')
  end

  scenario "with a passwrd that does not match" do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content "Password and confirmation password do not match"
    end

    def sign_up(email: 'stuff@what.com',
             password: 'bananas',
             password_confirmation: 'bananas')

    visit '/users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

  scenario "I can't sign up without an email address" do
    expect { sign_up(email: nil) }.to change(User, :count).by(0)
  end

  scenario "I can't sign up with an invalid email address" do
    expect { sign_up(email: "invalid@email") }.not_to change(User, :count)
  end

end

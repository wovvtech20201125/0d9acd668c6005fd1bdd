require 'rails_helper'

Rails.describe Api::UsersController, :sunspot => true do
  context "Modify existing record" do
    before do
      @user = User.create({firstname: 'albert', lastname: 'einstein', email: 'ae@relativity.com'})
    end

    it "should return user data in json if found" do
      get :show , params: {id: @user.id}
      json_body = JSON.parse(response.body)
      expect(json_body['firstname']).to eq @user.firstname
    end

    it "should update the exsiting record" do
      put :update, params: {id: @user.id, user:{firstname: 'venky'}}
      json_body = JSON.parse(response.body)
      expect(json_body['firstname']).to eq 'venky'
    end

    it "should destroy the record" do
      delete :destroy, params:{id: @user.id}
      json_body = JSON.parse(response.body)
      expect(json_body['success']).to eq 'Record succesfully destroyed'
      expect(User.count).to eq 0
    end
  end

  it "should create a new user" do
    post :create, params: {user: {firstname: 'albert', lastname: 'einstein', email: 'ae@relativity.com'}}
    expect(User.count).to eq 1
    user = User.first
    expect(user.firstname).to eq 'albert'
  end
end
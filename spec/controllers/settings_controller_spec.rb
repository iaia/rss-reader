require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  describe 'read opml' do
    context 'settings' do
      it 'view' do
        session[:user_id] = 1
        add_session(session)
        get :setting
        expect(response).to redirect_to 'setting'
      end
    end
    context 'regist opml test' do
      before do
        filepath = File.join(File.dirname(__FILE__), '../lib/feedly.opml')
        @reader = ReadOpml::Reader.read(filepath)
      end
      it '1' do
        p 'regist'
        collection = @reader.category
        post :regist_opml
        # expect(assigns(:collection)).to eq collection
      end
    end
  end
end

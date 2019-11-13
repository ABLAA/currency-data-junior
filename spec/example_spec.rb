require 'spec_helper'

describe 'Your application' do

  it "works!" do
    get '/'
    expect(last_response.status).to eq 200
  end

  it "works!" do
    get '/convert'
    expect(last_response.status).to eq 200
  end


  it "history works!" do
    get '/history'
    expect(last_response.status).to eq 200
  end



end
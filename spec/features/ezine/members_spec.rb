require 'spec_helper'

describe "ezine_members" do
  subject(:site) { cms_site }
  subject(:node) { create_once :ezine_node_page, name: "ezine" }
  subject(:item) { Ezine::Member.last }
  subject(:index_path) { ezine_members_path site.host, node }
  subject(:download_path) { download_ezine_members_path site.host, node }

  it "without login" do
    visit index_path
    expect(current_path).to eq sns_login_path
  end

  it "without auth" do
    login_ss_user
    visit index_path
    expect(status_code).to eq 403
  end

  context "with auth" do
    before { login_cms_user }

    it "#index" do
      visit index_path
      expect(current_path).not_to eq sns_login_path
    end

    it "#download" do
      visit download_path
      expect(current_path).not_to eq sns_login_path
    end
  end
end

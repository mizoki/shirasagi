require 'spec_helper'

describe "ezine_pages" do
  subject(:site) { cms_site }
  subject(:node) { create_once :ezine_node_page, name: "ezine" }
  subject(:item) { Ezine::Page.last }
  subject(:index_path) { ezine_pages_path site.host, node }
  subject(:new_path) { new_ezine_page_path site.host, node }
  subject(:show_path) { ezine_page_path site.host, node, item }
  subject(:edit_path) { edit_ezine_page_path site.host, node, item }
  subject(:delete_path) { delete_ezine_page_path site.host, node, item }

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

    it "#new" do
      visit new_path
      within "form#item-form" do
        fill_in "item[name]", with: "sample"
        fill_in "item[html]", with: "body_html"
        fill_in "item[text]", with: "body_text"
        click_button "保存"
      end
      expect(status_code).to eq 200
      expect(current_path).not_to eq new_path
      expect(page).not_to have_css("form#item-form")
    end

    it "#show" do
      visit show_path
      expect(status_code).to eq 200
      expect(current_path).not_to eq sns_login_path
    end

    it "#edit" do
      visit edit_path
      within "form#item-form" do
        fill_in "item[name]", with: "modify"
        click_button "保存"
      end
      expect(current_path).not_to eq sns_login_path
      expect(page).not_to have_css("form#item-form")
    end

    it "#delete" do
      visit delete_path
      within "form" do
        click_button "削除"
      end
      expect(current_path).to eq index_path
    end

    it "convert_html_to_text function" do
      #TODO: テキストエリアの値のテストの方法を調べる
      #visit new_path
      #within "form#item-form" do
      #  fill_in "item[name]", with: "sample"
      #  fill_in "item[html]", with: "<p>body</p>"
      #  click_button "HTML版を変換する"
      #end
      #within "textarea#item_text" do
      #  expect(page).to have_content("body")
      #end
    end
  end
end

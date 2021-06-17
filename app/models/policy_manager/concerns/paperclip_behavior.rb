# -*- encoding : utf-8 -*-
# require "paperclip"

module PolicyManager::Concerns::PaperclipBehavior
  extend ActiveSupport::Concern


  def file_remote_url=(url_value)
    self.attachment = File.open(url_value) unless url_value.blank?
    self.save
    self.complete!
  end

  def download_link
    url = self.attachment.expiring_url(PolicyManager::Config.exporter.expiration_link)
    PolicyManager::Config.exporter.customize_link(url)
  end
end
# frozen_string_literal: true

class RemovePhotoAttachmentIdFromRepresentatives < ActiveRecord::Migration[5.2]
  def change
    remove_column :representatives, :photo_attachment_id, :integer
  end
end

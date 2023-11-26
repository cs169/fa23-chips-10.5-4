# frozen_string_literal: true

class AddPhotoAttachmentToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    change_table :representatives do |t|
      t.references :photo_attachment, foreign_key: { to_table: :active_storage_blobs }
    end
  end
end

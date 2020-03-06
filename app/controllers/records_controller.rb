# frozen_string_literal: true
# from httplib2 import Http
# from oauth2client import client
# from googleapiclient.discovery import build
# CONTENTS = os.environ.get('GOOGLE_APPLICATION_CREDENTIALS')
# CREDS = client.Credentials.new_from_json(CONTENTS)
# SERVICE = build('calendar', 'v3', http=CREDS.authorize(Http()))

class RecordsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_record, only: %i[edit update destroy text]
  require "google/cloud/vision"

  def new
    @record = Record.new
  end

  def create
    @record = current_task.records.build(record_params)
    if @record.save
      flash[:success] = '新しい進捗を追加しました'
      if @record.progress == 100
        current_task.update_attribute(:status, 'complete')
      else
        current_task.update_attribute(:status, 'incomplete')
      end
      redirect_to current_task
    else
      flash.now[:danger] = '進捗を追加できませんでした'
      render :new
    end
  end

  def edit; end

  def update
    if @record.update(record_params)
      if params[:record][:image_ids]
        params[:record][:image_ids].each do |image_id|
          image = @record.images.find(image_id)
          image.purge
        end
      end
      flash[:success] = '進捗を変更しました'
      if @record.progress == 100
        current_task.update_attribute(:status, 'complete')
      else
        current_task.update_attribute(:status, 'incomplete')
      end
      redirect_to current_task
    else
      flash.now[:danger] = '進捗を変更できませんでした'
      render :edit
    end
  end

  def destroy
    @record.destroy
    flash[:success] = '進捗を削除しました'
    redirect_to current_task
  end

  def text

    @image = @record.images.find(params[:record][:image_id])
<<<<<<< HEAD
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new(credentials: JSON.parse(ENV.fetch('GOOGLE_API_CREDS')))
=======
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new(credentials: JSON.parse(ENV.fetch('GOOGLE_API_CREDS'))
>>>>>>> 1bad58a70f6598e3d7c91fee6bf2682d76689170
    image_path = ActiveStorage::Blob.service.send(:object_for, @image.key).public_url
    @response = image_annotator.text_detection(
      image: image_path,
      max_results: 1 # optional, defaults to 10
    )
  end
end

private

def record_params
  params.require(:record).permit(:progress, :supplement, :picture, images: [])
end

def correct_record
  @record = current_task.records.find_by(id: params[:id])
  redirect_to groups_url unless @record
end

def save_image(url)

end

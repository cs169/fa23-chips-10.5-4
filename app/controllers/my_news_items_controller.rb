# frozen_string_literal: true

require 'net/http'
require 'json'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]
  before_action :set_issues

  def new
    @news_item = NewsItem.new
    @rep_id = params[:news_item][:representative_id] if params[:news_item][:representative_id]
    @issue = params[:news_item][:issue] if params[:news_item][:issue]
    found_representative = @representatives_list.find { |_name, id| id == @rep_id.to_i }
    rep_name = found_representative.first
    @rep_name = rep_name

    @articles = get_news(rep_name, @issue)
  end

  # pre-form controller
  def pre; end

  def edit; end

  def create
    @news_item = NewsItem.new(news_item_params)
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  private

  def remove_middle_name(full_name)
    name_parts = full_name.split
    if name_parts.length > 2
      [name_parts.first, name_parts.last].join(' ')
    else
      full_name
    end
  end

  def get_news(rep_name, issue)
    rep_name = remove_middle_name(rep_name)
    url = URI("https://gnews.io/api/v4/search?q=#{rep_name}%20#{issue}&lang=en&country=us&max=5&apikey=704753ec864b8230a64b15339095816e")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    data['articles']
  end

  # pre-form to new parameters
  def news_item_default_params
    defaults = {}
    defaults[:representative] = params[:representative] if params[:representative]
    defaults[:issue] = params[:issue] if params[:issue]

    defaults
  end

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue)
  end

  def set_issues
    @temp_issues = ['Free Speech', 'Immigration', 'Terrorism',
                    'Social Security and Medicare', 'Abortion',
                    'Student Loans', 'Gun Control', 'Unemployment',
                    'Climate Change', 'Homelessness', 'Racism',
                    'Tax Reform', 'Net Neutrality',
                    'Religious Freedom', 'Border Security',
                    'Minimum Wage', 'Equal Pay']
  end
end

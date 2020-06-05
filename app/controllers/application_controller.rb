
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # set :method_override, true

  get '/' do
    redirect to '/articles'
  end

  get '/articles' do
    @articles = Article.all()
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do 
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id}"
  end

  get '/articles/:id' do
    @article = findArticleById params[:id]
    erb :show
  end

  get '/articles/:id/edit' do
    @article = findArticleById params[:id]
    erb :edit
  end

  patch '/articles/:id' do
    @article = findArticleById params[:id]
    @article.update({
      title: params[:title],
      content: params[:content]
    })
    redirect to  "/articles/#{ @article.id}"
  end

  delete '/articles/:id' do
    Article.find(params[:id]).delete
    redirect to '/artcles'
  end

  private

  def findArticleById(id)
    return Article.find(id)
  end
end

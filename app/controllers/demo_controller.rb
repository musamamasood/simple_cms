class DemoController < ApplicationController
  
  layout "application"

  def index
  	@array = [1,2,3,4,5]
  	render('index')
  end

  def hello
  	@id   = params[:id].to_i
  	@page = params[:page].to_i
    render('hello')
  end

  def hello_other
  	redirect_to(:controller => 'demo', :action => 'index')
  end

  def lynda
  	redirect_to("http://www.lynda.com")
  end

  def text_helpers
  end

  def escape_output    
  end

end

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

  def make_error
    # My guesses for the 3 most common errros:
    #render(:text => "text" # syntax error
    #render(:text => @something.upcase) #undefined method
    #render(:text => "1" + 1) # can't convert type
    
  end

  def logging
    logger.debug("This is debug.")
    logger.info("This is info.")
    logger.warn("This is warn.")
    logger.error("This is error.")
    logger.fatal("This is fatal.")
    render(:text => 'Logged!')
  end

end

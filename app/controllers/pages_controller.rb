class PagesController < ApplicationController
  
  layout "admin"

  def index
    @pages = Page.all.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(:name => "Page Name")
  end

  def create
    #initidate the new page with params
    @page = Page.new( page_params )
    # Save the page
    if @page.save
      #if successful, redirected to index page
      flash[:notice] = "Page cretaed successfully."
      redirect_to(:action => 'index')
    else
      # else failed then render new page. 
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    #initidate the new page with params
    @page = Page.find(params[:id])
    # Save the page
    if @page.update_attributes( page_params )
      #if successful, redirected to index page
      flash[:notice] = "Page updated successfully."
      redirect_to(:action => 'show', :id => @page.id)
    else
      # else failed then render new page. 
      render('edit')
    end

  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed successfully!"
    redirect_to(:action => 'index')
  end

  private
    def page_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned.
      params.require(:page).permit(:name, :permalink, :position, :visible)
      
    end
end

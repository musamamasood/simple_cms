class PagesController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in
  before_action :find_subject

  def index
    # @pages = Page.where(:subject_id => @subject_id)
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id, :name => "Page Name"})
    @subjects = Subject.all.sorted
    @page_count = Page.count + 1
  end

  def create
    #initidate the new page with params
    @page = Page.new( page_params )
    # Save the page
    if @page.save
      #if successful, redirected to index page
      flash[:notice] = "Page cretaed successfully."
      redirect_to(:action => 'index', :subject_id => @subject.id)
    else
      # else failed then render new page. 
      @page_count = Page.count + 1
      @subjects = Subject.all.sorted
      render('new')
    end
  end

  def edit
    @page       = Page.find(params[:id])
    @subjects   = Subject.order('position ASC')
    @page_count = Page.count
  end
  
  def update
    #initidate the new page with params
    @page = Page.find(params[:id])
    # Save the page
    if @page.update_attributes( page_params )
      #if successful, redirected to index page
      flash[:notice] = "Page updated successfully."
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id)
    else
      # else failed then render new page. 
      @page_count = Page.count
      @subjects = Subject.all.sorted
      render('edit')
    end

  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed successfully!"
    redirect_to(:action => 'index', :subject_id => @subject.id)
  end

  private
    def page_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned.
      params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
    end

    def find_subject
      if params[:subject_id]
        @subject = Subject.find( params[:subject_id] )
      end
    end
end

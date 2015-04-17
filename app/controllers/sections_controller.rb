class SectionsController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in
  before_action :find_pages
  before_action :find_subjects

  def index
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find( params[:id] )
  end

  def new
    @section          = Section.new({:page_id => @page.id})
    @section_count    = Section.count + 1
    # @pages          = Page.order('position ASC')
    @pages            = @page.subject.pages.sorted
  end

  def create
    # initlize the new section
    @section = Section.new( section_params )
    # if section have fields
      if @section.save
        # save the field
        flash[:notice] = "Section Created successfully .."
        redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
      else 
        # otherwise return to new page
        @pages         = Page.order('position ASC')
        @section_count = Section.count + 1
        render('new')
      end

  end

  def edit
    @section       = Section.find( params[:id] )
    @pages         = Page.order('position ASC')
    @section_count = Section.count
  end

  def update
    # initlize the new section
    @section = Section.find( params[:id] )
    # if section have fields
      if @section.update_attributes( section_params )
        # save the field
        flash[:notice] = "Section Updated successfully .."
        redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
      else 
        # otherwise return to new page
        @pages         = Page.order('position ASC')
        @section_count = Section.count
        render('edit')
      end
  end

  def delete
    @section = Section.find( params[:id] )
  end

  def destroy
    section = Section.find( params[:id] ).destroy
    flash[:notice] = "Section #{section.name} deleted successfully!"
    redirect_to( :action => 'index', :page_id => @page.id )
  end

  private
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned.
    def section_params
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end

    def find_pages
      if params[:page_id]
        @page = Page.find( params[:page_id] )
      end 
    end

    def find_subjects
      if params[:subject_id]
        @subject = Subject.find( params[:subject_id] )
      end 
    end

end

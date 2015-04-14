class SectionsController < ApplicationController
  
  layout "admin"

  def index
    @sections = Section.all.sorted
  end

  def show
    @section = Section.find( params[:id] )
  end

  def new
    @section = Section.new
  end

  def create
    # initlize the new section
    @section = Section.new( section_params )
    # if section have fields
      if @section.save
        # save the field
        flash[:notice] = "Section Created successfully .."
        redirect_to(:action => 'show', :id => @section.id)
      else 
      # otherwise return to new page
        render('new')
      end

  end

  def edit
    @section = Section.find( params[:id] )
  end

  def update
    # initlize the new section
    @section = Section.find( params[:id] )
    # if section have fields
      if @section.update_attributes( section_params )
        # save the field
        flash[:notice] = "Section Updated successfully .."
        redirect_to(:action => 'show', :id => @section.id)
      else 
      # otherwise return to new page
        render('edit')
      end
  end

  def delete
    @section = Section.find( params[:id] )
  end

  def destroy
    section = Section.find( params[:id] ).destroy
    flash[:notice] = "Section #{section.name} deleted successfully!"
    redirect_to( :action => 'index' )
  end

  private
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned.
    def section_params
      params.require(:section).permit(:name, :position, :visible, :content_type, :content)
    end

end

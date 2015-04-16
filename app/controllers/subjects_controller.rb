class SubjectsController < ApplicationController

  layout "admin"

  def index
    @subjects = Subject.all.sorted
  end

  def show
    @subject = Subject.find( params[:id].to_i )
  end

  def new
    @subject       = Subject.new({:name => "Subject Name"})
    @subject_count = Subject.count + 1
  end

  def create

    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)

    # Save the object
    if @subject.save
      # If save succeeds, redirect to the index action
      flash[:notice] = 'Subject created successfully.'
      redirect_to(:action => 'index')
    else
      # If save fials, redisplay the form so user can fix the problems
      @subject_count = Subject.count + 1
      render('new')
    end

  end

  def edit

    @subject       = Subject.find( params[:id] )
    @subject_count = Subject.count

  end

  def update

    # Instantiate to find object using form parameters
    @subject = Subject.find( params[:id] )

    # Update the object
    if @subject.update_attributes(subject_params)
      # If Update succeeds, redirect to the show action
      flash[:notice] = 'Subject updated successfully.'
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # If save fials, redisplay the form so user can fix the problems
      @subject_count = Subject.count
      render('edit')
    end

  end

  def delete
    @subject = Subject.find( params[:id] )
  end

  def destroy
    subject = Subject.find( params[:id] ).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  private
    def subject_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned.
      params.require(:subject).permit(:name, :position, :visible)
      
    end

end

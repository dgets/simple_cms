class SubjectsController < ApplicationController

  #layout false
  layout "admin"

  before_action :confirm_logged_in

  def index

    @subjects = Subject.sorted

  end

  def show

    @subject = Subject.find(params[:id])

  end

  def new

    @subject = Subject.new({:name => "John Smith"})
    @subject_count = Subject.count + 1

  end

  def create

    #instantiate new object w/form parameters
    @subject = Subject.new(subject_params)
    #save the object
    if @subject.save
      #if succeeds, redirect to index
      flash[:notice] = "Subject created successfully"
      redirect_to(:action => 'index')
    else    
      #if fails, redisplay the form so user can fix problems
      @subject_count = Subject.count + 1
      render('new')
    end

  end

  def edit

    @subject = Subject.find(params[:id])
    @subject_count = Subject.count

  end

  def update

    #find an existing object w/form parameters
    @subject = Subject.find(params[:id])

    #update the object
    if @subject.update_attributes(subject_params)
      #if update succeeds, redirect to index
      flash[:notice] = "Subject updated successfully"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      #if update fails, redisplay the form so user can fix problems
      @subject_count = Subject.count
      render('edit')
    end

  end

  def delete

    @subject = Subject.find(params[:id])

  end

  def destroy

    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully"
    redirect_to(:action => 'index')

  end

  private
    def subject_params
      #raises an error if :subject is not present & allows listed attributes
      #to be mass assigned
      params.require(:subject).permit(:name, :position, :visible, :created_at)
    end

end

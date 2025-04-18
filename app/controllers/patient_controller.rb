class PatientController < ApplicationController
  layout "dashboard"

  def index
    @patients = Patient.all
  end
  
  def show
    @patient = Patient.find(params[:id])
    render partial: 'form', locals: { patient: @patient, readonly: true }
  end
  
  def new
    @patient = Patient.new
    render partial: 'form', locals: { patient: @patient, readonly: false }
  end
  
  def edit
    @patient = Patient.find(params[:id])
    render partial: 'form', locals: { patient: @patient, readonly: false }
  end

  def destroy
    @patient = Patient.find(params[:id])
    
    if @patient.destroy
      flash[:notice] = "Patient successfully deleted."
    else
      flash[:alert] = "There was an issue deleting the patient."
    end
    
    redirect_to patients_path # Redirect to the index page after deletion
  end
end

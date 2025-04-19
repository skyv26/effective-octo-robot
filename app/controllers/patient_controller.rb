class PatientController < ApplicationController
  layout "dashboard"

  def index
    @patients = Patient.all
  end

  def show
    @patient = Patient.find(params[:id])
    render locals: { patient: @patient, readonly: true }
  end


  def update
    @patient = Patient.find(params[:id])

    if @patient.update(patient_params)
      redirect_to @patient, notice: "Patient updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to @patient, notice: "Patient created successfully."
    else
      render :new, locals: { patient: @patient, readonly: false }, status: :unprocessable_entity
    end
  end

  def edit
    @patient = Patient.find(params[:id])
    render locals: { patient: @patient, readonly: false }
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("patient_#{@patient.id}") }
      format.html { redirect_to patients_path, notice: "Patient deleted successfully." }
    end
  end

  private

  def patient_params
    params.require(:patient).permit(
      :name, :age, :gender, :blood_group,
      :phone, :email, :address, :medical_history,
      :allergies, :emergency_contact
    )
  end
end

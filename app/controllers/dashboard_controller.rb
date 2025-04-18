class DashboardController < ApplicationController
    layout "dashboard"
  
    def index
        # Example: Patients grouped by created_at date (you can adjust this query)
        @patients_data = Patient.group_by_day(:created_at).count
        @doctor = User.where(role: 'doctor')
        @patient_today = Patient.where(created_at: Time.zone.today.all_day)
        @patient_recent = Patient.order(created_at: :desc).limit(8)
        @patient_this_week = Patient.where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week)
    end

  end
  
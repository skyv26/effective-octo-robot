class DashboardController < ApplicationController
    layout "dashboard"
  
    def index
        # Example: Patients grouped by created_at date (you can adjust this query)
        @patients_data = Patient.group_by_day(:created_at).count
      end
  end
  
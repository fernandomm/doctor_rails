class WorkingChecksController < DoctorRails::ChecksController
  protected
    def check_always_work
      true
    end

    def check_always_work_description
      "Always work :)"
    end
end
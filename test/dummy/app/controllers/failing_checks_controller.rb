class FailingChecksController < DoctorRails::ChecksController
  protected
    def check_always_fail
      false
    end

    def check_always_fail_description
      "Sorry, but i always fail :("
    end
end
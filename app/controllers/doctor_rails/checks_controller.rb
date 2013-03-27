require_dependency "doctor_rails/application_controller"

module DoctorRails
  class ChecksController < ApplicationController
    respond_to :html, :xml, :json

    def index
      @results = do_check(params[:checks])

      @results = boolean_result(@results) if params[:boolean_result]

      respond_with @results
    end

    protected
      def boolean_result results
        results.each do |check, result|
          return false if !result[:result]
        end

        true
      end


      def do_check checks
        available_checks = get_checks
        
        if checks.blank?
          checks = available_checks
        else
          checks = available_checks && checks
        end

        results = {}
        checks.each do |check|
          description_method = "#{check.to_s}_description"
          
          if self.class.method_defined? description_method
            description = self.send description_method
          else
            description = ""
          end

          results[check] = {
            :result => self.send(check),
            :description => description
          }
        end

        results
      end

      def get_checks
        action_methods.select{|n| n.to_s.match('check_') && !n.to_s.match('_description')}
      end
  end
end

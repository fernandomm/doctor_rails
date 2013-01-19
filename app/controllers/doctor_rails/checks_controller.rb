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
        methods.select{|n| n.to_s.match('check_') && !n.to_s.match('_description')}
      end

      def check_migrations
        !(ActiveRecord::Migrator.current_version != get_latest_migration)
      end

      def check_migrations_description
        "Check if migrations are up to date."
      end

      def get_latest_migration(dir = File.join(Rails.root, 'db', 'migrate'))
        latest_migration = 0
        Dir[File.join(dir, "[0-9]*_*.rb")].each do |f|
          l = f.scan(/0*([0-9]+)_[_a-zA-Z0-9]*.rb/).first.first
          latest_migration = l if !latest_migration || l.to_i > latest_migration.to_i
        end
        latest_migration
      end
  end
end

module Calamari
  module TimesheetEntries
    class ProjectEntry
      attr_reader :from, :to, :duration, :project

      def initialize(raw_project_entry)
        @from = to_date_time(raw_project_entry['from'])
        @to = to_date_time(raw_project_entry['to'])
        @duration = raw_project_entry['duration'].to_i
        @project = Project.new(raw_project_entry['project'])
      end

      def to_date_time(date_string)
        Time.parse(date_string)
      end

      class Project
        attr_reader :id, :name

        def initialize(raw_project)
          @id = raw_project['id']
          @name = raw_project['name']
        end
      end
    end
  end
end
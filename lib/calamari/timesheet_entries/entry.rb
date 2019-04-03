require_relative 'break_entry'
require_relative '../shared/person'
require_relative 'project_entry'

module Calamari
  module TimesheetEntries
    class Entry
      attr_reader :id, :started, :finished, :started_time_zone, :finished_time_zone,
                  :duration, :person, :breaks, :projects

      def initialize(raw_entry)
        @id = raw_entry['id']
        @started = to_date_time(raw_entry['started'])
        @finished = to_date_time(raw_entry['finished'])
        @started_time_zone = raw_entry['started_time_zone']
        @finished_time_zone = raw_entry['finished_time_zone']
        @duration = raw_entry['duration'].to_i
        @person = Shared::Person.new(raw_entry['person'])
        @breaks = raw_entry['breaks'].map { |break_entry| TimesheetEntries::BreakEntry.new(break_entry) }
        @projects = raw_entry['projects'].map { |project| TimesheetEntries::ProjectEntry.new(project) }
      end

      private

      def to_date_time(date_string)
        date_string.nil? ? date_string : Time.parse(date_string)
      end
    end
  end
end
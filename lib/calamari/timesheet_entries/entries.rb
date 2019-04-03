require_relative 'entry'

module Calamari
  module TimesheetEntries
    class Entries
      class << self
        def build(raw_entries)
          new(
              raw_entries.map { |raw_entry| build_entry(raw_entry) }
          )
        end

        private

        def build_entry(raw_entry)
          TimesheetEntries::Entry.new(raw_entry)
        end
      end

      def initialize(entries)
        @entries = entries
      end

      def count
        @entries.count
      end

      def first
        @entries.first
      end

      def last
        @entries.last
      end

      def each
        @entries.each { |entry| yield(entry) }
      end

      def map
        @entries.map { |entry| yield(entry) }
      end

      def select
        rebuild(
            @entries.select { |entry| yield(entry) }
        )
      end

      private

      def rebuild(entries)
        self.class.new(entries)
      end
    end
  end
end
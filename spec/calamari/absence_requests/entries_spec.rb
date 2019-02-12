require 'spec_helper'

RSpec.describe Calamari::AbsenceRequests::Entries do
  let(:first_entry) do
    {
      'id'=> 456,
      'from'=> (Time.now - 2).httpdate,
      'to'=> Time.now.httpdate,
      'absenceTypeName'=> 'Praca zdalna',
      'absenceTypeId'=> 4,
      'absenceCategory'=> 'WORK',
      'status'=> 'ACCEPTED',
      'entitlementAmount'=> 2.0,
      'amountFirstDay'=> nil,
      'amountLastDay'=> nil,
      'created'=> (Time.now - 5).httpdate,
      'updated'=> Time.now.httpdate
    }
  end

  let(:second_entry) do
    {
        'id'=> 457,
        'from'=> (Time.now - 5).httpdate,
        'to'=> (Time.now - 3).httpdate,
        'absenceTypeName'=> 'Praca zdalna',
        'absenceTypeId'=> 4,
        'absenceCategory'=> 'WORK',
        'status'=> 'PENDING',
        'entitlementAmount'=> 2.0,
        'amountFirstDay'=> nil,
        'amountLastDay'=> nil,
        'created'=> (Time.now - 5).httpdate,
        'updated'=> Time.now.httpdate
    }
  end

  let(:raw_entries) do
    [first_entry, second_entry]
  end

  describe '.build' do
    subject { described_class.build(raw_entries) }

    it { expect { subject }.not_to raise_error }
  end

  context 'instance methods' do
    let(:entries) { described_class.build(raw_entries) }

    describe '#first' do
      subject { entries.first }

      it { expect(subject.id).to eq first_entry['id'] }
    end

    describe '#last' do
      subject { entries.last }

      it { expect(subject.id).to eq second_entry['id'] }
    end

    describe '#accepted' do
      subject { entries.accepted }

      it { expect(subject.class).to eq described_class }
      it { expect(subject.count).to eq 1 }
      it { expect(subject.first.id).to eq first_entry['id'] }
    end

    describe '#pending' do
      subject { entries.pending }

      it { expect(subject.class).to eq described_class }
      it { expect(subject.count).to eq 1 }
      it { expect(subject.first.id).to eq second_entry['id'] }
    end
  end
end
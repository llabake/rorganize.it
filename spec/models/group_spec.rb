# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  address           :string(255)
#  time              :string(255)
#  number_of_members :integer
#  created_at        :datetime
#  updated_at        :datetime
#  picture           :string(255)
#  twitter           :string(255)
#  latitude          :float
#  longitude         :float
#  contact           :text
#  activities        :text
#

require 'spec_helper'

describe Group do

  subject { Group.create!(name: 'hello', email: 'hello@email.com') }

  it 'is valid with a name and email' do
    subject.name = 'Awesome Test Group'
    subject.email = 'mail@group.org'
    expect(subject.valid?).to be_true
  end

  describe 'editable by' do

    it 'is editable by student in the group' do
      user = Student.create!(first_name: 'test', email: 'test@test.com', password: 'testtest')
      user.join!(subject)
      expect(subject.is_editable_by?(user)).to be_true
    end

    it 'is not editable by student not in the group' do
      user = Student.create!(first_name: 'test', email: 'test@test.com', password: 'testtest')
      expect(subject.is_editable_by?(user)).to be_false
    end

    it 'is editable by coach in the group' do
      user = Coach.create!(first_name: 'test', email: 'test@test.com', password: 'testtest')
      user.join!(subject)
      expect(subject.is_editable_by?(user)).to be_true
    end

    it 'is not editable by coach not in the group' do
      user = Coach.create!(first_name: 'test', email: 'test@test.com', password: 'testtest')
      expect(subject.is_editable_by?(user)).to be_false
    end
  end
end

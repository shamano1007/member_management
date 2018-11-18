require 'rails_helper'

RSpec.describe BusinessCareerDecorator do
  let(:business_career) { BusinessCareer.new.extend BusinessCareerDecorator }
  subject { business_career }
  it { should be_a BusinessCareer }
end

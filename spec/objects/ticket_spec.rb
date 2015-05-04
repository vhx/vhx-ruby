require 'spec_helper'

describe Vhx::Ticket do
  let(:sample_ticket_response){ JSON.parse(File.read("spec/fixtures/sample_ticket_response.json")) }
  let(:vhx_ticket){Vhx::Ticket.new(sample_ticket_response)}
  let(:credentials){ JSON.parse(File.read("spec/fixtures/test_credentials.json")) }

  before {
    Vhx.setup(credentials)
  }

  describe '::create' do
    it 'returns ticket object' do
      expect(Vhx::Ticket.create(attributes)).to be_instance_of(Vhx::Ticket)
    end
  end

  describe 'attributes' do
    it 'are present' do
      expect(vhx_ticket.token).to_not be_nil
      expect(vhx_ticket.status).to_not be_nil
    end
  end

  describe 'associations' do
    it 'are present' do
      expect(vhx_ticket.user).to_not be_nil
      expect(vhx_ticket.package).to_not be_nil
      expect(vhx_ticket.site).to_not be_nil
    end

    it 'errors if not present' do
      expect(vhx_ticket.ticket).to raise_error(NoMethodError)
    end
  end

end
# frozen_string_literal: true

require "rails_helper"

describe UsersController, type: :controller do
  describe ".add_prarent_group_to_us" do
    context "when a band is in the session" do
    end

    context "when a band is not in the session" do
      let(:session) { {} }

      before do
        allow(controller).to receive(:add_parent_group_to_user)
        allow(GroupUser).to receive(:new).and_return(true)
      end

      it "does not add a group to the user" do
        expect(GroupUser).to_not receive(:new)
        add_parent_group_to_user
      end
    end
  end
end

module BandUser
  BANDS = {
    "abr" => {
      "name" => "augustburnsred",
      "category_id" => "124",
    },
  }.freeze

  def check_user_login
    band_reference = session.fetch("band", {}).fetch("name", nil)
    current_user = CurrentUser.lookup_from_env(request.env)

    if band_reference && current_user

      # find group
      group = Group.find_by(name: "#{band_reference}")
      if group && group.group_users.where(user_id: current_user.id).blank?
        group_user = GroupUser.new(group_id: group.id, user_id: current_user.id)
        if group_user.save
          Rails.logger.info("Added user #{current_user.id} to group #{group.id}")
        else
          Rails.logger.warn("Could not add user #{current_user.id} to group #{group.id}")
        end
      end
    end
  end
end

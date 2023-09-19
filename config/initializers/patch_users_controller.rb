UsersController.class_eval do
  after_action :add_parent_group_to_user, only: [:create]

  def add_parent_group_to_user
    # if session includes a band at it as a parent
    band_name = session.fetch("band", {}).fetch("name", nil)
    if band_name
      # extract tue users id from the response
      user_response = JSON.parse(response.body)
      user_id = user_response.fetch("user_id", nil)
      status = user_response.fetch("success", nil)

      if status == true && user_id
        # find group
        group = Group.find_by(name: "#{band_name}")
        if group && group.group_users.where(user_id: user_id).blank?
          group_user = GroupUser.new(group_id: group.id, user_id: user_id)
          if group_user.save
            # set as the primary group
            user = User.find_by(id: user_id)
            user.update(primary_group_id: group.id)
            Rails.logger.info("Added user #{user_id} to group #{group.id}")
          else
            Rails.logger.warn("Could not add user #{user_id} to group #{group.id}")
          end
        end
      end
    end
  end
end

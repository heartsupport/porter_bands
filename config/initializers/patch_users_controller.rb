UsersController.class_eval do
  after_action :add_parent_group_to_user, only: [:create]

  def add_parent_group_to_user
    band_id = session.fetch("band", {}).fetch("id", nil)

    Rails.logger.info("=====ADD USER TO GROUP=== \n Band ID: #{band_id} \n")
    if band_id
      band = Band.find_by(id: band_id)

      # extract tue users id from the response
      user_response = JSON.parse(response.body)
      user_id = user_response.fetch("user_id", nil)
      status = user_response.fetch("success", nil)
      Rails.logger.info("=====ADD USER TO GROUP=== \n status: #{status} \n user_id: #{user_id} \n")
      if status == true && user_id
        # find group
        group = Group.find_by(id: band.group_id)
        user = User.find_by(id: user_id)

        Rails.logger.info("=====GROUP=== \n group: #{group.inspect} \n")
        Rails.logger.info("=====USER=== \n user: #{user.inspect} \n")

        # return if group is nil
        return if group.nil?

        # return if user is already in group
        return if group.group_users.where(user_id: user_id).exists?
        Rails.logger.info("=====GROUP DOES NOT EXIST === \n user: #{user.inspect} \n")

        group_user = GroupUser.new(group_id: group.id, user_id: user_id)
        if group_user.save
          # set as the primary group
          user.update(primary_group_id: group.id)
          Rails.logger.info("Added user #{user_id} to group #{group.id}")
        else
          Rails.logger.warn("Could not add user #{user_id} to group #{group.id}")
        end
      end
    end
  end
end

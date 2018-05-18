module PlacesHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_places_path
    elsif action_name == 'edit'
      place_path
    end
  end
  
end


require_relative '../classes/label'

module CommonInfoData
  def get_user_input(prompt)
    print prompt
    gets.chomp.to_s
  end

  def add_item(file, item)
    data = DataStorage.new

    data.save_user_json_data(file, item.to_h)
    item.other_data
  end

  def get_label(file, item)
    title = get_user_input('Enter Label title: ')
    color = get_user_input('Enter Label color: ')

    label = Label.new(title, color)
    item.add_label(label)

    add_item(file, label)
  end
end

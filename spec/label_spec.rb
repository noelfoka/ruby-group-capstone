require_relative '../classes/label'

RSpec.describe Label do
  describe '#add_item' do
    it 'adds an item to the label' do
      label = Label.new('Test Label', 'red')
      item = double('item')

      expect(item).to receive(:label=).with(label)

      label.add_item(item)

      expect(label.items).to include(item)
    end
  end

  describe '#to_h' do
    it 'returns a hash representation of the label' do
      label = Label.new('Test Label', 'red')
      double('item', to_h: { id: 1, name: 'Item' })

      # Creating a more complex test double that responds to label=
      item_with_label_double = double('item_with_label', to_h: { id: 1, name: 'Item' })
      allow(item_with_label_double).to receive(:label=)

      label.add_item(item_with_label_double)

      expected_hash = {
        id: label.id,
        title: 'Test Label',
        color: 'red',
        items: [{ id: 1, name: 'Item' }]
      }

      expect(label.to_h).to eq(expected_hash)
    end
  end
end

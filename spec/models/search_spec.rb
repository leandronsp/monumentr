describe Search do
  let!(:summer) { Collection.make!(name: 'Summer 2014') }
  let!(:winter) { Collection.make!(name: 'Winter 2014') }
  let!(:autumn) { Collection.make!(name: 'Autumn 2014') }

  let!(:eiffel) { Monument.make!(name: 'Eiffel Tower', collection_id: summer.id) }
  let!(:museum) { Monument.make!(name: 'Summer Museum', collection_id: winter.id) }

  describe '.collections' do
    it 'searches thru collections and associated monuments' do
      result = Search.collections('summer')
      expect(result.size).to eq(2)
      expect(result.map(&:name)).to eq([summer.name, winter.name])
    end
  end

  describe '.universal_search' do
    it 'searches thru all multisearchable models' do
      result = Search.universal_search('summer')

      result[0].tap do |model|
        expect(model.searchable_type).to eq('Collection')
        expect(model.searchable.name).to eq(summer.name)
      end

      result[1].tap do |model|
        expect(model.searchable_type).to eq('Monument')
        expect(model.searchable.name).to eq(museum.name)
      end
    end
  end
end

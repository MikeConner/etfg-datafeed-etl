RSpec.describe BmoBaskets do
  it 'transforms baskets correctly' do
    basket_file_path = File.join(
      File.dirname(__FILE__), '../fixtures/bmo/baskets.20180725.test.csv'
    )
    rows = BmoBaskets.transform_file(basket_file_path)
    expect(rows[0][1]).to eq('JH291')
    expect(rows.size).to eq 7
  end
end

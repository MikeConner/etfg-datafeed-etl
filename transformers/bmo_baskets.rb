module BmoBaskets

  COLUMN_INDICES = {
    fund_name: 2
  }

  def self.transform_file(file_path)
    rows = []
    CSV.foreach(file_path, encoding:'iso-8859-1:utf-8') do |row|
      next unless /\ABMO/ =~ row[COLUMN_INDICES[:fund_name]]
      rows.push(row)
    end
    rows
  end
end

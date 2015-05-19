class AddPortfolioToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :portfolio_link, :string
  end
end

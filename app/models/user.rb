class User < ApplicationRecord
  searchable do
    text :firstname
    text :lastname
    text :email
  end
end

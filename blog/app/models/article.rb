class Article < ApplicationRecord
    include Visible
  
    has_many :comments, dependent: :destroy
    belongs_to :user
    has_one_attached :image

  
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }

    def report
      increment!(:reports_count)
    end

    def archive_if_reports_exceeded
      if reports_count >= 3 && !archived?
        update(archived: true)
      end
    end
  end
  
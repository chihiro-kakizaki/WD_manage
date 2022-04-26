class Pair < ApplicationRecord
  before_create :create_default_tasks, :add_season
  before_update :update_tasks_depend_on_weddingday_on, :add_season

  validates :weddingday_on, presence: true
 
  enum season: {
                spring:0, 
                summer:1,
                autumn:2,
                winter:3
                }

  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  
  has_many :tasks, dependent: :destroy

  def create_default_tasks
    default_tasks_params.each do |task_params|
      tasks.build(task_params)
    end
  end

  def update_tasks_depend_on_weddingday_on
    if self.will_save_change_to_weddingday_on?  
      diff = weddingday_on_change[1] - weddingday_on_change[0]
      tasks.each do |task|
        after = task.expired_on + diff
        task.update(expired_on: after)
      end
    end
  end

  def add_season
    case weddingday_on.month
    when 3..5
      self.season = 0
    when 6..8
      self.season = 1
    when 9..11
      self.season = 2
    when 1,2,12
      self.season = 3
    end
  end

  def default_tasks_params
    [{user: owner, title:"衣装", description:"衣装・アクセサリーやシューズ等の小物の決定",expired_on: weddingday_on<<4, status: 0},
     {user: owner, title:"前撮り", description:"前撮りの検討・スタジオやロケーションの決定",expired_on: weddingday_on<<4, status: 0},
     {user: owner, title:"装花", description:"会場コーディネートと装花の決定",expired_on: weddingday_on<<3, status: 0},
     {user: owner, title:"演出", description:"当日のプログラムと演出の決定",expired_on: weddingday_on<<3, status: 0},
     {user: owner, title:"写真・映像・BGM", description:"結婚式当日に使用する写真・映像・BGM等の選定・作成",expired_on: weddingday_on<<2, status: 0},
     {user: owner, title:"料理・ドリンク", description:"料理・ドリンクコースの内容の決定",expired_on: weddingday_on<<2, status: 0},
     {user: owner, title:"最終打合せ", description:"結婚式場での最終打合せ",expired_on: weddingday_on<<1, status: 0}, 
     {user: owner, title:"席次表の提出", description:"席次表の提出",expired_on: weddingday_on<<1, status: 0}
    ]
  end
end


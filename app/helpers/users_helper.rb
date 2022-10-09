module UsersHelper

   # 勤怠基本情報を指定のフォーマットで返します。  
   def format_basic_info(time)
    format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end

  # csvインポート
  def self.import(file)
    #User.import(params[:file])
    flash[:success] = "新規ユーザーを追加しました。"
    redirect_to users_url
  end
end

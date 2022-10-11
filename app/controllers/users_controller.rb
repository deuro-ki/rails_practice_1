class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show

  def index
    #@users = User.paginate(page: params[:page])
    @users = params[:tag_id].present? && params[:search] != "" ? Tag.find(params[:tag_id]).users.paginate(page: params[:page], per_page: 8).where.not(id: 1) : User.paginate(page: params[:page], per_page: 8).where.not(id: 1)
    @users = @users.where('name LIKE?', "%#{params[:search]}%") if params[:search].present?
  end

  def search
    if params[:search] != ""
      @users = User.search(params[:search])
    else
      @users = User.where.not(id: 1)
    end
  end

  # csvインポート
  def import
    User.import(params[:file])
    flash[:success] = "新規ユーザーを追加しました。"
    redirect_to users_url
  end

  def show
    #@first_day = Date.current.beginning_of_month
    #@last_day = @first_day.end_of_month
    @worked_sum = @attendances.where.not(started_at: nil).count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
    
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      # 更新成功時の処理
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。" + @user.errors.full_messages.join("、")
    end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation, tag_ids: [])
    end

    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end

   
end
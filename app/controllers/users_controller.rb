class UsersController < ApplicationController

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end


  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end

  def following
    @title ="Following"
    @user = User.find(params[:id])
    @users = @user.follower
    @following_count = Relationship.all.count(:followed_id)
    @followers_count = Relationship.all.count(:follower_id)
    render 'show_follower'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followed
    @following_count = Relationship.all.count(:followed_id)
    @followers_count = Relationship.all.count(:follower_id)
    render 'show_followed'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def zipedit
  params.require(:user).permit(:postcode, :prefecture_code, :address_city, :address_street)
  end
end

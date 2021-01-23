class BooksController < ApplicationController

# エラー：ユーザー権限のテスト
# if user_signed_in? を全てのアクションに定義する？
# まとめて制限をかける方法はあるのか → before_action

  before_action :authenticate_user!

  def new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = User.find(current_user.id)
      # @book = Book.newrai
      render action: :index
    end
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all

  end

  def show
    @books = Book.find(params[:id])
    @book = Book.new
    @book_comment = BookComment.new
    @user = @books.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

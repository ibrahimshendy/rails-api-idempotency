class Api::V1::PostsController < Api::Controller

  def index
    @posts = Post.limit(10)
  end

  def show
    @post = Post.find_by! id: params[:id]
  end

  def create
    @post = PostService.create attributes: post_params

    render :show, status: :created
  end

  def update
    @post = PostService.update post: Post.find_by!(id: params[:id]), attributes: post_params

    render :show, status: :ok
  end

  def destroy
    @post = Post.find_by!(id: params[:id])
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :status)
  end
end

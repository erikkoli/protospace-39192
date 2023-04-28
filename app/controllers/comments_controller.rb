class CommentsController < ApplicationController
  
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.new(message_params)
    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show"
    end
  end

  private 

  def message_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end

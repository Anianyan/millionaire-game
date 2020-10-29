class AnswersController < ApplicationController
    def show
        @answer = Answer.find(params[:id])

        render json: @answer
    end

    def get_correct
        @answer = Answer.where(question_id: params[:question_id], is_correct: 1)

        render json: @answer
    end
end

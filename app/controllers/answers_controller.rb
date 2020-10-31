class AnswersController < ApplicationController
    def show
        _answer = Answer.find(params[:id])

        render json: _answer
    end

    def get_correct
        _answer = Answer.where(question_id: params[:question_id], is_correct: 1)

        render json: _answer
    end
end

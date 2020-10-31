class QuestionsController < ApplicationController
    def show
        _question = Question.find(params[:id])

        render json: _question
    end
end

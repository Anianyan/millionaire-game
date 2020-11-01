class Admin::QuestionsController < ApplicationController
    def index
        @questions = Question.order(score: 'asc').all
    end

    def edit
        @question = Question.find(params[:id])
    end

    def update

        _question = Question.find(params[:id])
        
        update_answers(params[:question][:answers])
        if _question.update(question_params)
            redirect_to admin_questions_path
        else
            render 'edit'
        end
    end

    def destroy
        _question = Question.find(params[:id])
        _question.destroy
        
        redirect_to admin_questions_path
    end

    private
        def question_params
            params.require(:question).permit(:question_text, :level, :score, :answers)
        end

        def update_answers(answers)
            if answers
                _count = 0;
                answers.each do |key, answer|
                    _answer = Answer.find(key)
                    _correct = answer[:is_correct] ? 1 : 0
                    _answer.update(answer_text: answer[:answer_text], is_correct: _correct)
                    logger.debug "Person attributes hash: #{key} #{answer}"
                end
            end
            
        end
end

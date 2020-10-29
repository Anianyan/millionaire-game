class GameController < ApplicationController
    def wellcome
    end

    def new_game
        # Send one easy question for start game
        @offset = rand(Question.where(level: 'easy').count)
        @question = Question.where(level: 'easy')
                            .offset(@offset)
                            .first
    end

    def get_next_question
        @next_level = next_level(params[:level]);
        @offset = rand(Question.where(level: @next_level).count)
        @question = Question.where(level: @next_level)
                            .where("answers_count > 2")
                            .where.not(id: params[:question_ids])
                            .offset(@offset)
                            .first
        
        render json: @question.to_json({
            :include => {
                :answers => { only: [:id, :answer_text] }
            }
        })
    end

    def next_level(level)
        case level
        when 'easy'
            return 'medium'
        when 'medium'
            return 'hard'
        else
           return 'veryHard' 
        end
    end
end

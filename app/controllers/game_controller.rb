class GameController < ApplicationController
    def wellcome
        
    end

    def new_game
        # Send one easy question for start game
        @question = Question.where(level: 'easy').first
    end

    def get_next
        @question = Question.where(level: next_level(params[:level])).where("answers_count > 2").first
        
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

const game = {

    init: function() {
        const questionId = document.getElementById('question').getAttribute('data-question-id');
        this.questionsIds = [];
        this.questionNumber = 1;
        sendAjaxRequest({
            url: `/questions/${questionId}`,
            method: 'GET',
            success: (data) => {
                // Init question data.
                game.question = data;
                game.questionsIds.push(data.id);
            }
        });
    },

    updateScore: function() {
        const element = document.getElementById('game-score');
        let score = parseInt(element.innerHTML) + this?.question?.score;

        element.innerHTML = score;
    },

    setNewQuestion:function() {
        sendAjaxRequest({
            url: `/game/next`,
            method: 'POST',
            data: {
                level: this?.question?.level,
                question_ids: game.questionsIds
            },
            success: (question) => {
                // Init question data.
                game.question = question;
                game.questionsIds.push(question.id);

                $('#question-text').text('');
                $('#question-text').append(`<span class="label label-warning" id="qid">${++this.questionNumber}</span>${question.question_text}`);

                // Add questions
                $('#quiz').text('');
                $('#quiz').append(question?.answers?.map((answer) => (
                    `<label class="element-animation1 btn btn-lg btn-primary btn-block">
                        <span class="btn-label"><i class="glyphicon glyphicon-chevron-right"></i></span>
                        <input class="answer-input" type="radio" data-id="${answer.id}">${answer.answer_text}
                    </label>`
                )).join(''));
            }
        });
    },

    showErrorMessage: function(message) {
        const element = document.getElementById('answer');
        element.classList.remove('text-success');
        element.classList.add('text-danger');
        element.innerHTML = message;
    },

    showSuccessMessage: function(message) {
        const element = document.getElementById('answer');
        element.classList.remove('text-danger');
        element.classList.add('text-success');
        element.innerHTML = message;
    },

    showCorrectAnswer: function() {
        sendAjaxRequest({
            url: `/questions/${game.question.id}/correct-answers`,
            method: 'GET',
            success: (answers) => {
                const answersList = answers?.map((answer) => (
                    answer.answer_text
                )).join(' ');

                $('#correct-answer').text(`Correct Answer: ${answersList}`);
            }
        });
    },

    endGame() {
        if (this.questionNumber >= 5) {
            document.getElementById('question').classList.add('hide');
            document.getElementById('end-game').classList.remove('hide');

            return true;
        }

        return false;
    }
}

function sendAjaxRequest(payload) {
    const { url, method, success, error, beforeSend, data } = payload;
    $.ajax({
        method,
        url,
        data,
        dataType: 'json',
        accept: 'json',
        beforeSend,
        success,
        error,
    });
}

// Event Actions
$(document).ready(function() {
    // Check game page
    if ($('#question').length) {
        game.init();
    }

    // Handle select answer event.
    $(document).on('click', '.answer-input', function () {
        const answerId = $(this).data('id');

        sendAjaxRequest({
            url: `/questions/${game?.question?.id}/answers/${answerId}`,
            method: 'GET',
            beforeSend: () => {
                $('#loadbar').show();
            },
            success: (data) => {
                if (data.is_correct) {
                    game.showSuccessMessage('Correct :)');
                    game.updateScore();
                } else {
                    // User fail
                    game.showErrorMessage('Wrong :(');
                    game.showCorrectAnswer();
                }

                $('#loadbar').hide();
                $('#next-btn').removeClass('hide');
            },
            error: () => {
                game.showErrorMessage('Something went Wrong!');
                $('#loadbar').hide();
                $('#question').fadeIn();
            }
        });
    });

    $(document).on('click', '#next-btn', function() {
        $('#next-btn').addClass('hide');
        $('#answer').text('');
        $('#correct-answer').text('');

        if(!game.endGame()) {
            game.setNewQuestion();
        }
    });
});


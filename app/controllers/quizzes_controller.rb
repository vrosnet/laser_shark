class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
    @questions = Question.all
  end
  def show
    @quiz = Quiz.find(params[:id])
    @submission_stats = @quiz.quiz_submissions.stats
    @question_stats = @quiz.questions.stats(@quiz)

  end
  def add_question
    @quiz = Quiz.find(params[:quiz_id])
    @questions = Question.all
  end
  def link_question
    @quiz = Quiz.find(params[:quiz_id])
    @quiz.questions << Question.find(params[:question][:id])
  end
end
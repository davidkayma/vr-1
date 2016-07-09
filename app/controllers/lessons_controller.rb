class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:create, :new]
  before_action :set_lesson, only: [ :edit, :update, :destroy, :prompt_view,                  :role_model_view,
                                     :explanation_token, :prompt_token, :role_model_token]


  # GET /lessons
  # GET /lessons.json

  def prompt_view
  end

  def role_model_view
  end

  def explanation_token
    explanation_token = token_params[:explanation]
    @lesson.explanation = explanation_token

    if @lesson.save!
      render json: @lesson.explanation, status: :ok
    end
  end

  def prompt_token
    prompt_token = token_params[:prompt]
    @lesson.prompt = prompt_token

    if @lesson.save!
      render json: @lesson.prompt, status: :ok
    end
  end

  def role_model_token
    role_model_token = token_params[:role_model]
    @lesson.role_model = role_model_token

    if @lesson.save!
      render json: @lesson.role_model, status: :ok
    end
  end

  def index

    # @lessons = @topic.lessons.all
    # if @lessons
    # else

    @lessons = Lesson.all

  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson = Lesson.find(params[:id])
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
    # @lesson = current_user.lessons.build
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @topic = current_user.topics.find(params[:topic_id])
    # @lesson = Lesson.new(lesson_params)
    @lesson = @topic.lessons.build(lesson_params)

    if @lesson.save
      TopicLesson.create(topic_id:params[:topic_id], lesson_id:@lesson.id)
      respond_to do |format|
        format.html { redirect_to lesson_path(@lesson), notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    # if @lesson.user_id == current_user
      @lesson.destroy
      respond_to do |format|
        format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
        format.json { head :no_content }
      end
    # else
      # flash[:alert] = "You do not have permission to delete this lesson."
    # end
  end

  private
    def token_params
      params.require(:lesson).permit(:explanation, :prompt, :role_model)
    end
    # set the topic you are in before you start adding lessons
    def set_topic
      @topic = Topic.find(params[:topic_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:topic_id, :title, :explanation, :prompt, :role_model, :performance, :explanation_script, :prompt_script, :model_script, :model_token, :explanation_token, :role_model_token)
    end
end

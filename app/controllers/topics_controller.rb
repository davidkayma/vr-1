class TopicsController < ApplicationController
  before_action :set_course, only: [:index, :new, :edit, :create]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  # GET /topics
  # GET /topics.json
  def index
    course = Course.find_by(params[:course_id])
    @topics = course.topics
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find_by(params[:id])
  end

  # GET /topics/new
  def new
    @course = Course.find(params[:course_id])
    @new_topic = Topic.new
    # @topic = current_user.topics.build
  end

  # GET /topics/1/edit
  def edit
    @topic = @course.topics.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @course = Course.find(params[:course_id])
    @topic = Topic.new(topic_params)
    # @topic = current_user.topics.build(topic_params)
    respond_to do |format|
      if @topic.save
        course_topic = CourseTopic.create(course_id:params[:course_id], topic_id:@topic.id)

        format.html { redirect_to [@topic.course_id], notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    @topic = @course.topics.find(params[:id])
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to([@topic.post, @topic], notice: 'Topic was successfully updated.') }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @course = @topic.course
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:course_id, :title, :description, :tags, :status, :instructor_id)
    end
end

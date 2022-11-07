class Admin::SkillsController < ApplicationController
  before_action :ensure_skill, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_skills = @genre.skills
    else
      all_skills = Skill.includes(:genres)
    end
    @skills = all_skills.page(params[:page])
    @all_skills_count = all_skills.count
  end

  def show
  end

  def edit
  end

  def update
    @skill.update(skill_params) ? (redirect_to admin_skill_path(@skill)) : (render :edit)
  end

  def destroy
  end
  private

  def skill_params
    params.require(:skill).permit(:genre_id, :name, :body, :image, :price, :is_active, genre_ids: [])
  end

  def ensure_skill
    @skill = Skill.find(params[:id])
  end
end

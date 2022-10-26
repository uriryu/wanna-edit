class Public::HomesController < ApplicationController
  def top
    @genres = Genre.only_active.includes(:skills)
    @skills = Skill.recommended
    @skill = Skill.find_by(params[:id])
  end

  def search
    @model = params['search']['model']
    @content = params['search']['content']
    @method = params['search']['method']
    @result = search_for(@model, @content, @method)
  end

  private

  def search_for(model, content, method)
    if model == 'user'
      if method == 'forward'
        User.where(
          'user_name LIKE ?',
          "#{content}%"
        )
      elsif method == 'backward'
        User.where(
          'user_name LIKE ?',
          "%#{content}"
        )
      elsif method == 'perfect'
        User.where(
          'user_name = ?',
          content
        )
      else #partial
        User.where(
          'user_name LIKE ?',
          "%#{content}%"
          #部分一致は%で挟むこと!
        )
      end
    elsif model == 'skill'
      if method == 'forward'
        Skill.where('name LIKE ?', content + '%').includes(:genres)
      elsif method == 'backward'
        Skill.where('name LIKE ?', '%' + content).includes(:genres)
      elsif method == 'perfect'
        Skill.where(name: content).includes(:genres)
      else #partial
        Skill.where('name LIKE ?', '%' + content + '%').includes(:genres)
      end
    else
      []
    end
  end
end

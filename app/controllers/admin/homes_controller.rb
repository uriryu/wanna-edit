class Admin::HomesController < ApplicationController
  def top
  end

  def search
    @model = params['search']['model']
    @content = params['search']['content']
    @method = params['search']['method']
    @result = search_for(@model, @content, @method)
  end

  private

#入力欄にcontentをいれるので、返す値も"{content}"にしている。
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
    #elsif model == 'skill'
    else
      []
    end
  end
end

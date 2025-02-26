class CategoriesController < ApplicationController
  def index
    
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was created successfully."
      redirect_to @category
    else
      render :new
    end
  end

  def show
    
  end

  # def edit
    
  # end

  # def update
    
  # end
  
  private

  def category_params
    params.expect(category: [ :name ])
  end
end
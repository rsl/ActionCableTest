class ListDecorator < ApplicationDecorator
  delegate_all

  def row_style
    [active_style_name]
  end

private

  def active_style_name
    active? ? 'active' : 'inactive'
  end
end

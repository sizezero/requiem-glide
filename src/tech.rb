 # coding: utf-8
require 'squib'
require 'game_icons'

data = Squib.csv file: 'tech.csv'

levelNum2text = { 0=>'Basic', 1=>'L-I', 2=>'L-II', 3=>'L-III', 4=>'L-IV' }
levelNum2text.default = '???'

suit2color = { 'green'=>:green, 'white'=>:white, 'blue'=>:blue, 'black'=>:black, 'red'=>:red }
suit2color.default = :yellow

suit2stroke = { 'green'=>:black, 'white'=>:black, 'blue'=>:black, 'black'=>:black, 'red'=>:black, ''=>'#f000' }
suit2stroke.default = '#f000'

# default size for Deck.new appears to be for portrait poker card
Squib::Deck.new(cards: data['title'].size, layout: 'layouts/layout.yml') do
  background color: 'white'

  text str: data['title'], layout: 'title'
  text str: data['cost'].map { |a| '💲'+a.to_s  }, layout: 'cost'
  #text str: data['value'].map { |a| '🗑🢂💲'+a.to_s }, layout: 'value'

  triangle fill_color: data['suit'].map { |a| suit2color[a]  }, layout: 'suit'

  text str: data['level'].map { |a| levelNum2text[a] }, layout: 'level'

  # it seems lame that to not draw a triangle we have to draw it with full alpha
  triangle fill_color: data['dep_up'].map { |a| suit2color[a]}, stroke_color: data['dep_up'].map { |a| suit2stroke[a]},  layout: 'tdep_up'
  triangle fill_color: data['dep_straight'].map { |a| suit2color[a]}, stroke_color: data['dep_straight'].map { |a| suit2stroke[a]},  layout: 'tdep_straight'
  triangle fill_color: data['dep_down'].map { |a| suit2color[a]}, stroke_color: data['dep_down'].map { |a| suit2stroke[a]},  layout: 'tdep_down'

  # angle calc can't be in the layout file
  #rect  layout: 'body', angle: -Math::PI / 2
  text str: data['body'], layout: 'body', angle: -Math::PI / 2

  #rect layout: 'hex'
  text color: data['level'].map { |a| a==1 || a==2 ? :black : '#f000'}, layout: 'hex'

  #player_colors = data['player'].map { |a| player2color[a] }
  #rect fill_color: player_colors, layout: 'top'
  #rect fill_color: player_colors, layout: 'bottom'

  rect layout: 'cut'
  rect layout: 'safe'

  #text str: data['action'].map{ |a| a.capitalize }, layout: 'title'
  #svg data: data['action'].map { |a| GameIcons.get(action2gameIcon[a]).string }, layout: 'picture'

  # if multiple saves are listed it seems only one of them works
  #save_sheet prefix: 'tech', columns: 4, dir: 'output'
  # default file for save_pdf is sheet.png even though it's a pdf
  save_pdf file: 'tech.pdf', trim: 37.5, dir: 'output'
end

class Janken_print
  # ジャンケンの内部変数(String)を日本語の画面出力表示文字列(String)に置き換える


  # ジャンケンの手を表す内部変数(String)を日本語の画面出力表示文字列(String)に置き換える
  # @param [String] hand 手を表す文字列(g, c, p)
  # @return [String] 手を表す文字（画面出力用：「グー」「チョキ」「パー」)
  def hand_to_string(hand)
    case hand
    when 'g'
      return 'グー'
    when 'c'
      return 'チョキ'
    when 'p'
      return 'パー'
    end
  end

  # 勝敗結果を表す内部変数(String)を日本語の画面出力表示文字列(String)に置き換える
  # @param [String] result 勝敗結果を表す文字列(win, lose, draw)
  # @return [String] 勝敗結果を表す文字列（画面出力用）
  def result_to_string(result)
    case result
    when 'win'
      return 'あなたの勝ち'
    when 'lose'
      return 'あなたの負け'
    when 'draw'
      return '引き分け'
    end
  end

  #結果の画面出力
  def disp_result(player_hand, com_hand, result)
    # 結果出力
    game_result =  'あなたは' + hand_to_string(player_hand) 
    game_result << '、私は'   + hand_to_string(com_hand) 
    game_result << '、'       + result_to_string(result) + "です。\n"

    return game_result
  end
end

class Janken
  # ジャンケンを実行する
  
  def initialize(user_input=STDIN)
    @input = user_input
  end

  # プレイヤーの手を標準入力から取得
  def get_player_hand
    # プレイヤーのジャンケンの手を取得
    @player_hand = @input.gets.chomp
  end

  # コンピュータの手をランダムに生成
  def get_com_hand
    # コンピューター側のジャンケン手を生成
    rand_num = rand(3) + 1

    case rand_num
    when 1 
      @com_hand = 'g'
    when 2
      @com_hand = 'c'
    when 3
      @com_hand = 'p'
    end
  end

  # プレイヤーとコンピュータの勝敗を決定
  def judge(player_hand=@player_hand, com_hand=@com_hand)
    case player_hand
    when 'g'
      @result = 'win'  if com_hand == 'c'
      @result = 'lose' if com_hand == 'p'
      @result = 'draw' if com_hand == 'g'
    when 'c'
      @result = 'win'  if com_hand == 'p'
      @result = 'lose' if com_hand == 'g'
      @result = 'draw' if com_hand == 'c'
    when 'p'
      @result = 'win'  if com_hand == 'g'
      @result = 'lose' if com_hand == 'c'
      @result = 'draw' if com_hand == 'p'
    end

    return @result
  end

  # プレイヤー、コンピュータの手、及び、勝敗を画面出力
  def result
    #プレイヤー、コンピュータの手を取得
    get_player_hand
    get_com_hand

    #勝敗の判定
    judge

    # 結果の画面出力
    janken_print = Janken_print.new
    puts janken_print.disp_result(@player_hand, @com_hand, @result)

  end

end


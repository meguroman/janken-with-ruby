require 'minitest/autorun'
require "stringio"
require './janken.rb'


class TestJanken < Minitest::Unit::TestCase
  def setup
    @in = StringIO.new()
    @janken = Janken.new(@in)
  end

  # 標準入力取得のget_player_handメソッドのテスト
  def test_get_player_hand
    # 標準入力をStringIOでシミュレートして渡す。
    @in << "g"
    @in.rewind
    assert_equal "g", @janken.get_player_hand
  end

  # コンピュータの手をランダム生成するget_com_handメソッドのテスト
  def test_get_com_hand
    10.times do 
      assert_includes(%w[g c p], @janken.get_com_hand)
    end
  end

  # 勝敗を判定するjudgeメソッドのテスト
  def test_judge
    assert_equal("win",  @janken.judge("g", "c"))
    assert_equal("win",  @janken.judge("c", "p"))
    assert_equal("win",  @janken.judge("p", "g"))
    assert_equal("lose", @janken.judge("g", "p"))
    assert_equal("lose", @janken.judge("c", "g"))
    assert_equal("lose", @janken.judge("p", "c"))
    assert_equal("draw", @janken.judge("g", "g"))
    assert_equal("draw", @janken.judge("c", "c"))
    assert_equal("draw", @janken.judge("p", "p"))
  end
end

class TestJanken_print < Minitest::Unit::TestCase

  def setup
    @janken_print = Janken_print.new
  end
  
  # ジャンケンの手を内部変数から画面表示文字列に変換するhand_to_stringメソッドのテスト
  def test_hand_to_string
    assert_equal("グー",   @janken_print.hand_to_string("g"))
    assert_equal("チョキ", @janken_print.hand_to_string("c"))
    assert_equal("パー",   @janken_print.hand_to_string("p"))
  end

  # 勝敗を表す内部変数から画面表示文字列に変換するresult_to_stringメソッドのテスト
  def test_result_to_string
    assert_equal("あなたの勝ち", @janken_print.result_to_string("win"))
    assert_equal("あなたの負け", @janken_print.result_to_string("lose"))
    assert_equal("引き分け",     @janken_print.result_to_string("draw"))
  end

  # 最終的なじゃんけんゲームの画面出力を行うdisp_resultメソッドのテスト
  def test_disp_result
    assert_equal("あなたはグー、私はパー、あなたの負けです。\n", @janken_print.disp_result("g", "p", "lose"))
  end

end

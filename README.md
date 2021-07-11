tDiary2Jekyll rake tasks
========================

tDiary のデータを Jekyll で利用可能な HTML と Markdown に変換する

使い方
------

 1. git clone
 2. bundle install
 3. put images/ and src/ from tDiary
 4. bundle exec rake convert

機能
----

 * td2 データを分割し、tDiary の日記のセクションの単位を Jekyll の一つの post の単位に変換する
     * 例 202107.td2 → 2021-07-01-01.md
     * セクションの見出しが post の title に
 * tDiary Format はそのまま HTML に、Wiki フォーマットを Markdown に変換する
     * GFM などその他のフォーマットには対応していない
 * tDiary のカテゴリ機能を Jekyll の tag に変換
 * footnote plugin は Markdown の footnote 表記に変換
 * image plugin はそのまま HTML にしつつ assets/images/ 以下に
 * その他 plugin は Liquid tag っぽいものに変換しようとして中途半端な状態
 * 日記内のリンクをそれっぽく内部向けのリンクに変換

( tDiary ) Files -> File -> Day -> Section -> (Jekyll ) Entry -> File 

注意
----

 0. **未完成**
 1. tDiary のカテゴリ機能は Jekyll の tag に割り当てている
 2. デフォルトで diary というディレクトリで日記が更新されていたことを前提にしている

1 について、Jekyll 側の機能でパスを category に割り当てる機能があるため、category は Jekyll サイト上でのパスのために利用することとし、tDiary のカテゴリは Jekyll にもう一つある taxonomy の機能である tag に割り当て直すこととした。

# SBRKEY Official Client

SBRKEY向けの公式クライアント。何を思ったか1から書き直し中。

前のやつはGOSUBを使いまくっていたので、DEF中心で書いている。機能的にはgitが増えるだけ。
デザインはちょっと見やすく変更する。

SPRITEを多用した現代的なデザインも検討したが、キーボード操作を考えるとかえって見づらいため、おそらく文字ベースツールになる。

gitを始めて間もないので、IssuesやPullRequestなどを使用する場合は使い方を教えてください。



## 機能について

+ [x] SmileBASIC-Rの範囲の全てのディレクトリにアクセス(初期パスは本ツールのある場所かルート)
+ [x] テキストファイルのスロットへのロード
+ [x] 複数選択
+ [ ] コピー、切り取り、貼り付け、名前変更
+ [ ] zip/unzip
+ [x] ファイルパスのコピー
+ [ ] ディレクトリやファイルの新規作成
+ [ ] 各種git操作
+ [ ] 選択中のファイルをプレビュー
	+ [ ] テキスト: TXT, LOG, PRG, DATA
	+ [ ] 画像: PNG
	+ [ ] ディレクトリ: (中身を表示)
+ [ ] URL、公開キー、gitを利用したダウンロード
	+ [ ] URLのラストがgitの場合、リモートリポジトリであるとしてcloneする
	+ [ ] branchから選択するか、releasesから選択するかを選ぶ
	+ [ ] gitがインストールされていない場合は警告する
+ [x] 上記の操作のヘルプを表示


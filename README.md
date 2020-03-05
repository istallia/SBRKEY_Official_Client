# SBRKEY Official Client

SBRKEY向けの公式クライアント。何を思ったか1から書き直し中。

前のやつはGOSUBを使いまくっていたので、DEF中心で書いている。機能的にはgitが増えるだけ。  
デザインはちょっと見やすく変更する。

SPRITEを多用した現代的なデザインも検討したが、キーボード操作を考えるとかえって見づらいため、おそらく文字ベースツールになる。

公式サイト: https://textblog.minibird.jp/sbrkey/



## 導入

※一般的なPC用語については解説しません。

### PCでダウンロードしたものを転送する方法

1. GitHubの[Releases](releases/latest)から最新版の`SBRKEY_CLIENT.PRG`をダウンロードする。
1. PiSTARTER入りのMicroSDカードをPCに接続する。
1. MicroSDの`\SMILEBOOM\SMILEBASIC-R\workspace\PROJECT`にダウンロードしたファイルをコピーする。
1. MicroSDをRaspberry Piに戻し、起動する。
1. PiSTARTERの設定で、スマイルボタンのどちらかに`/PROJECT/SBRKEY_CLIENT.PRG`と入力し、設定する。
1. エディタ画面で指定したスマイルツールを起動すると、クライアントが実行され、利用を開始できる。

### Raspberry Pi上で直接ダウンロードする方法

(準備中。標準のファイラでURLを直接入力することでダウンロードできる)





## 機能について

+ [x] SmileBASIC-Rの範囲の全てのディレクトリにアクセス(初期パスは本ツールのある場所かルート)
+ [x] テキストファイルのスロットへのロード
+ [x] 複数選択
+ [x] コピー、切り取り、貼り付け、名前変更
+ [x] zip/unzip
+ [x] ファイルパスのコピー
+ [x] ディレクトリやファイルの新規作成
+ [ ] 各種git操作
+ [ ] 選択中のファイルをプレビュー
	+ [x] テキスト: TXT, LOG, PRG, DATA
	+ [ ] 画像: PNG
	+ [ ] ディレクトリ: (中身を表示)
+ [ ] URL、公開キー、gitを利用したダウンロード
	+ [ ] URLのラストがgitの場合、リモートリポジトリであるとしてcloneする
	+ [ ] branchから選択するか、releasesから選択するかを選ぶ
	+ [ ] gitがインストールされていない場合は警告する
+ [x] 上記の操作のヘルプを表示


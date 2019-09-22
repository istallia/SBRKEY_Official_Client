'============================================
'   SBRKEY PiSTARTER向け公開キーシステム クライアント        
'                                            
'基本的な機能を備えたファイラ、それに統合された公開キーシステムとgit操作       
'gitからのダウンロードはgit cloneを利用(?)                
'なぜ構えのやつは全編英語だったので、今回はちゃんと日本語で作るよ            
'専用サーバーへのアップロードもできるようになるはず                   
'============================================
OPTION STRICT



'--------------------------------------------
'画面の初期化                                      
'--------------------------------------------

'--- 汎用変数
VAR TITLE$ = "SBRKEY OFFICIAL CLIENT v0.1"
VAR I%, J%
VAR FNAME$, DNAME$

'--- 実行スロットの確認
VAR BACKUP_DIR$ = CHDIR()
VAR SLOT%       = 0
LOCATE 0,0:BACKTRACE
SLOT% = CHKCHR(0,0) - 48
IF SLOT% == 4 THEN CHDIR DIRNAME$(PRGNAME$(0))

'--- 初期化
ACLS
XSCREEN 640, 480
COLOR #WHITE, 0




'--------------------------------------------
'ファイラー                                       
'--------------------------------------------

'--- ファイラー関連の変数
VAR CTRL_TEXT$ = "SPACE:ファイルメニュー D:ダウンロードメニュー H:ヘルプ Q:終了"
DIM FLIST$[0]

'--- タイトルバーとファイルリストの初期描画
COLOR #BLACK, #AQUA
LOCATE 0, 0
PRINT " "*80;
LOCATE 0, 0
PRINT TITLE$;
LOCATE 80-LEN(CTRL_TEXT$), 0
PRINT CTRL_TEXT$;
RELOAD_FILELIST FLIST$, "NAME"
DRAW_FILELIST FLIST$

'--- メインループ
WHILE #TRUE
 'キー入力を取得
 VAR C$ = INKEY$()
 C$     = UPL$(C$)
 'H:ヘルプ → その他の操作方法について表示
 IF C$ == "H" THEN
  
 ENDIF
 'Q:終了 → 画面をリフレッシュしてからツールを終了
 IF C$ == "Q" || C$ == CHR$(27) THEN
  COLOR #WHITE, 0
  CLS
  CHDIR BACKUP_DIR$
 ENDIF
 '時間待ち
 VSYNC
WEND

'--- ヘルプの文章
@TEXT_HELP
DATA ""

'--- ファイルリストを更新する命令
DEF RELOAD_FILELIST LIST$, SORT_RULE$
 'ローカル変数
 VAR I% = 0
 'まずはリストを取得
 IF SORT_RULE$ == "NAME" THEN
  FILES LIST$
 ENDIF
 'リストを処理
 IF SORT_RULE$ == "NAME" THEN
  FOR I% = 0 TO LEN(LIST$)-1
   IF LIST$[I%][0] == "+" THEN
    LIST$[I%] = RIGHT$(LIST[I%],LEN(LIST$)-1)
    LIST$[I%] = "[" + LIST$[I%] + "]"
   ENDIF
  NEXT
 ENDIF
 'リストに上のディレクトリに行くための項目を追加
 IF CHDIR() != "/" THEN
  UNSHIFT LIST$, "[..]"
 ENDIF
END

'--- ファイルリストを画面に描画する命令
DEF DRAW_FILELIST LIST$, CURSOR%, OFFSET%
 'まずは表示エリアをリフレッシュ
 VAR I%
 COLOR #WHITE, 0
 FOR I% = 1 TO 59
 	LOCATE 0, I%
 	PRINT "" + " "*78 + ""
 NEXT
 LOCATE 0,  1:PRINT "" + ""*78 + ""
 LOCATE 0, 59:PRINT "" + ""*78 + ""
 'プレビューエリアを準備
 VAR FL_WIDTH% = 40
 FOR I% = 2 TO 58
  LOCATE FL_WIDTH%, I%
  PRINT ""
 NEXT
 LOCATE FL_WIDTH%,  1:PRINT "┬"
 LOCATE FL_WIDTH%, 59:PRINT "┴"
 'リストの文字列を順に描画
 FOR I% = 0 TO MIN(56,LEN(LIST$)-OFFSET%-1)
  IF I%+OFFSET% == CURSOR% THEN
   COLOR #WHITE, &HFF600000
  ELSE
   COLOR #WHITE, 0
  ENDIF
  LOCATE 1, I%+2
  PRINT CLIP_TEXT$(LIST$[I%+OFFSET%],FL_WIDTH%-2)
 NEXT
END




'--------------------------------------------
'いろいろなところで使用する自作命令                           
'--------------------------------------------

'--- 指定されたファイルをカレントディレクトリにコピーする
DEF CP FP$
 VAR FN$  = BASENAME$(FP$)
 VAR CNT% = 0
 IF CHKFILE(FN$) THEN
  REPEAT
   INC CNT%
  UNTIL !CHKFILE("("+STR$(CNT%)+")"+FN$)
  FN$ = "("+STR$(CNT%)+")" + FN$
 ENDIF
 FCOPY FP$, FN$
END

'--- 指定されたファイルをカレントディレクトリに移動する
DEF MV FP$
 CP FP$
 DELETE FP$
END

'--- 文字列を範囲内に収める関数(収まらない部分は省略)
DEF CLIP_TEXT$(TXT$, MAXNUM%)
 IF LEN(TXT$) <= MAXNUM% THEN RETURN TXT$
 RETURN LEFT$(TXT$,MAXNUM%-1)+"…"
END

'--- ファイル名に使用できない文字を除去して返す関数
DEF CHKFILENAME$(FN$)
 VAR CHKTEXT$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$%'-_@~`!(){}^#&+,;=[]."
 VAR OUTPUT$  = ""
 FN$          = FN$ + ""
 WHILE LEN(FN$) > 0
  VAR CHAR$ = SHIFT(FN$)
  IF INSTR(CHKTEXT$,CHAR$) > -1 THEN OUTPUT$ = OUTPUT$ + CHAR$
 WEND
 RETURN OUTPUT$
END

'--- ファイルパスからファイル名だけを抜き出す関数
DEF BASENAME$(PATH$)
 VAR NAME$ = SYSTEM$("basename "+PATH$)
 RETURN LEFT$(NAME$,LEN(NAME$)-1)
END

'--- ファイルパスからディレクトリ部分を抜き出す関数
DEF DIRNAME$(PATH$)
VAR DIR$ = SYSTEM$("dirname "+PATH$)
 RETURN LEFT$(DIR$,LEN(DIR$)-1)
END

'--- 文字列の小文字を大文字に置換する関数
DEF UPL$(TXT$)
 VAR DI%, BYTE%
 TXT$ = TXT$+""
 FOR DI% = 0 TO LEN(TXT$)-1
  BYTE% = ASC(TXT$[DI%])
  IF BETWEEN(BYTE%,97,122) THEN TXT$[DI%] = CHR$(BYTE%-32)
 NEXT
 RETURN TXT$
END

'--- 値の範囲をチェックする関数
DEF BETWEEN(X, MIN_X, MAX_X)
 IF X >= MIN_X && X <= MAX_X THEN RETURN #TRUE
 RETURN #FALSE
END
DEF AREA(X, Y, MIN_X, MIN_Y, MAX_X, MAX_Y)
 IF BETWEEN(X,MIN_X,MAX_X) && BETWEEN(Y,MIN_Y,MAX_Y) THEN RETURN #TRUE
 RETURN #FALSE
END


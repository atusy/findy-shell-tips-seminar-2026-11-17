---
paginate: true
---

<style>
video,img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  border: 1px solid #888;
}
a {
  color: #5555AD;
}
small {
  font-size: 0.8em;
}
strong {
  color: #AD5555;
}
h1 {
  font-size: 2em;
}
</style>


# AIじゃない！<br/>あえてシェルを使うための設定Tips！！

<!-- https://findy.connpass.com/event/387107/ -->

## ![height:1em](images/headphone.jpg) atusy

---

## ![height:1em](images/headphone.jpg) atusy

- 現職
    - At Mark Inc. (<https://attm.co.jp/>)
    - 人材マッチングサービスの開発
    - Engineering Manager
- 経歴
    - 地質コンサル → データサイエンティスト → BEエンジニア → フルスタックエンジニア → now
    - 福岡女子大学でキャリア講師として呼んでいただいたりも
- 好きなもの
    - Neovim
    - コーヒー（焙煎からやる）

---

## 著書: Rが生産性を高める (2022)

〜データ分析ワークフロー効率化の実践

![height:10em](https://gihyo.jp/assets/images/cover/2022/9784297125240.jpg)

---

## フォローよろしく！

- <https://x.com/Atsushi776>
- <https://blog.atusy.net>
- <https://github.com/atusy>

---

## Shell開くこと減ったな……

やりたいことに集中できる

- AIがやりたいこと（プロンプト）のやること（コマンド）化を代替
- AIが結果（コマンド出力）の解読を代替
- AIがシェル裁きの学習を代替
    - シェルの分布・コマンドのオプション・パイプのコツ……

---

## でもまだShell使うな……

だってわざわざAIを使うまでもないときもある

- やることが単純で明らか
    - なんなら早い
- 結果を想定できている
- 操作に習熟している

---

## なら今の使い方に合わせて設定しよう

- 起動高速化
- シェル操作効率化
    - alias/abbr
    - キーバインド
    - 補完
- 便利コマンド導入
    - zoxide
    - direnv
    - mise/nix

---

## 起動高速化

待てる操作はAIなら、すぐ結果の欲しいシェル操作では起動時間が命

- いらない設定を削ろう
    - AIにシェル実行任せるならいらんなって設定は消す
- 遅延読み込みを活用しよう
    - 関数定義などを必要になったタイミングで読み込む
    - シェル利用が減った今こそ無駄な初期読み込みを削ぐ
    - fish なら組込みの遅延読み込み機能で十分
    - zsh なら zsh-defer + zcompile とかいいぞ（[@fuzmareさんの記事参照](https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache)）
- 起動速度じゃなくて、ユーザー入力を受け付けるまでの時間を短くしよう
    - NG例: プロンプト表示高速化のためにgit statusを非同期反映したが、反映完了までユーザー入力をブロックする

---

## fishの真の起動時間をはかる

- `fish -i -c exit`なんて測ってないよね……？
- AIにベンチマーカー作ってもらおう

```fish
hyperfine --warmup 5 --runs 10 "expect -c 'log_user 0; set timeout 5; spawn -noecho sh -c {stty rows 24 cols 120; exec env TERM=xterm-256color fish -i}; expect -exact [format {%c[0c} 27] {send -- [format {%c[?1;2c} 27]; exp_continue} -exact {133;B} {close; exit 0} timeout {exit 1} eof {exit 2}'"
```

|        | fish | zsh |
|--------|------|-----|
| 無設定 | 41.8ms | 29.1ms |
| atusy  | 50.1ms | 56.8ms |

---

## シェルのabbrはいいぞ

手入力の遅さを補う

- abbrはキーワードからコマンドに展開できる
    - 例: `gpr`を`gh pr checkout --detach`に展開
- オプションをその場で変更できる
    - 例: `--detach`を削る
- コマンド履歴を正規化できる
    - 例: `ll`や`la`のような`ls`ショートカットが履歴に`ls -l`や`ls -a`として残る
- 画面共有で誤解が減る
    - 例: aliasだと`ll`って`ls -a`か`ls -l`かわからん

---

## こんなabbrもいいぞ

- ちょっとした計算をラクチンに
    - `math`と入力すると`math ""`に展開され引用符の中にカーソルが入る
- 繰り返し入力をラクチンに
    - `mv すごく/ながい/パス ,-1`を`mv すごく/ながい/パス すごく/ながい/パス`に展開

fishのabbrは関数で定義できるので複雑なこともできる

---

## シェルのaliasもたまにはいいぞ

aliasも手入力の遅さを補う

- aliasはコマンドを短縮できる
    - 例: `alias ll='ls -l'`
- abbrの旨みが不要な場面で使う
    - オプションを変えることがない
    - コマンド履歴にそのまま入っていい
    - 画面共有で誤解がない・気にしない

---

## こんなaliasならいいぞ

- 互換性の高いコマンド
    - 例: `alias ls=eza`
- 驚きの少ない設定のデフォルト化
    - 例: `alias watch="watch --color"`
- AIモデルの使い分け
    - 例: haiku, sonnet, opus, fable

---

## シェルのキーバインドを使い込なせ

複雑な操作を簡略化

- `CTRL+A`で行頭に移動
- `CTRL+R`で履歴からコマンドを再利用
- `CTRL+X CTRF+F`でファイル名補完

---

## シェルの補完も忘れるな

使い方を覚えたり調べる時間を減らす

```fish
gh completion -s fish >~/.config/fish/completions/gh.fish
```

---

## 便利コマンド導入

ちまたにいっぱい解説があるので割愛

- zoxide: よくいくディレクトリに高速移動
- direnv: ディレクトリごとに環境変数を変更
- mise/nix: プロジェクトごとにコマンドのバージョンを固定

---

## まとめ

AIに任せる作業が増えた今こそ、自分でよく打つコマンドに合わせて設定しよう

- 起動してすぐ打てるように、入力できるまでの時間を測って、重い設定は遅延読み込みに
- よく打つコマンドはabbrやaliasで短く。履歴検索と補完も使って手入力を減らそう
- よく行く場所にはzoxideでひとっ飛び。プロジェクトごとの環境はdirenvやmise/nixに任せよう

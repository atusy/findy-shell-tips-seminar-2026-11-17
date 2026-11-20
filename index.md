---
paginate: true
---

<style>
section {
  background: #f8f6ef;
  color: #172c29;
  padding: 60px 82px;
  font: 30px/1.48 "Hiragino Sans", "Noto Sans JP", sans-serif;
  border-left: 12px solid #167263;
}
section h2 {
  color: #124e45;
  font-size: 1.52em;
  letter-spacing: -.035em;
  margin: 0 0 .5em;
}
section ul { padding-left: 1.25em; }
section li::marker { color: #16816d; }
section li li { font-size: .87em; color: #425850; }
section a, section strong { color: #096954; }
section code { background: #e0ebe3; color: #124e45; border-radius: .18em; }
section pre { background: #142e2b; padding: .8em 1em; border: 0; }
section pre code { color: #dcf7dd; background: transparent; white-space: pre-wrap; overflow-wrap: anywhere; }
section pre code span[class^="hljs-"] { color: #dcf7dd; }
section pre code span.hljs-built_in, section pre code span.hljs-keyword { color: #ffd08a; }
section pre code span.hljs-string { color: #a9e3ff; }
section table { font-variant-numeric: tabular-nums; }
section th, section td { padding: .25em 1.1em; }
section th { background: #184f45; color: white; }
section img[alt*="height:1em"] { border-radius: 50%; }
section.cover, section.closing {
  color: #f7f5e9;
  background: radial-gradient(ellipse at top right, #24594b, transparent 65%), #102d28;
  border-color: #b2de75;
}
section.cover h1 { color: #f7f5e9; font-size: 2.22em; line-height: 1.28; }
section.cover h2, section.closing h2, section.closing strong { color: #c2e89a; }
section.cover h2 { font-size: 1em; margin-top: 1.4em; }
section::after { color: #688078; font-size: 17px; }
section.benchmark pre { font-size: .62em; }
section blockquote { border-left: 6px solid #84ac6e; color: #124e45; font-weight: 700; font-size: 1.5em; padding: .2em .65em; margin: .5em 0; }
section table { border-collapse: collapse; }
section table :is(th, td) { text-align: left; border: 0; border-bottom: 1px solid #bdccc0; }
section tbody tr:nth-child(n) { background: transparent; }
section table th { font-size: .82em; }
section.closing ul { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px; list-style: none; padding: 0; margin: 24px 0 0; }
section.closing li { margin: 0; padding: 24px; border-radius: 14px; background: #edeae0; color: #172c29; font-size: .9em; }
section.closing li strong { display: block; margin-bottom: 12px; color: #124e45; font-size: 1.12em; }
.startup-cards { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin: 20px 0; }
.startup-cards article { padding: 22px 28px; background: #edeae0; border-radius: 14px; }
.startup-cards:not(.abbr-demos) article:last-child { background: #dfecdf; }
.startup-cards h3 { margin: 0 0 10px; font-size: 1.14em; color: #124e45; }
.startup-cards p { margin: 0; font-size: .94em; }
.abbr-demos video { display: block; width: 100%; border-radius: 8px; margin: 16px 0; }
.abbr-demos article { min-width: 0; }
.history-demo { display: grid; grid-template-columns: 0.85fr 1.15fr; gap: 32px; align-items: center; }
.history-demo figure { margin: 0; }
.history-demo video { display: block; width: 100%; border-radius: 12px; }
section footer { left: 82px; right: 82px; bottom: 20px; font-size: 18px; color: #425850; }
</style>

<!-- _class: cover -->
<!-- _paginate: false -->

# AIじゃなくてシェルでさっと！<br>を叶える設定Tips

<!-- https://findy.connpass.com/event/387107/ -->

## ![height:1em](images/headphone.jpg) atusy

---

## ![height:1em](images/headphone.jpg) atusy

- 現職
    - 株式会社アットマーク (<https://attm.co.jp/>)
    - 人材マッチングサービスの開発
    - Engineering Manager
- 経歴
    - 地質コンサル → データサイエンティスト → BEエンジニア → フルスタックエンジニア → now
    - 福岡女子大学でキャリア講師として呼んでいただいたりも
- 好きなもの
    - Fish
    - Neovim
    - コーヒー（焙煎からやる）

---

![bg right:38% contain](https://gihyo.jp/assets/images/cover/2022/9784297125240.jpg)

## Rが生産性を高める

データ分析ワークフロー効率化の実践

著書（2022年）

---

## フォローよろしく！

- <https://x.com/Atsushi776>
- <https://blog.atusy.net>
- <https://github.com/atusy>

---

## Shell開くこと減ったな……

AIがいれば、やりたいことに集中できる

- やりたいこと（プロンプト）を伝えればいい
    - なにをするか（コマンド）は省略可能
- 結果（コマンド出力）を人間向けに整理してくれる
- シェル裁きの学習がいらない
    - シェルの分布・コマンドのオプション・パイプのコツ……

---

## でもまだShell使うな……

- 自分でシェル操作したほうが早いとき
    - やることが決まっていて、結果も想像できるとき
- AIを起動するとき

---

## なら今の使い方に合わせて設定しよう

| シェルでやりたいこと | 見直すところ |
|---|---|
| 開いたらすぐ打ちたい | 起動時に読み込む設定 |
| 知っているコマンドを短く打ちたい | abbr・alias・キーバインド・補完 |
| プロジェクトをすぐ切り替えたい | zoxide・direnv・mise/nix |

---

## シェル起動高速化

**最初の一文字をいつ打てるかが勝負**

<div class="startup-cards">
  <article>
    <h3>使わなくなった</h3>
    <p>消せ</p>
  </article>
  <article>
    <h3>使う</h3>
    <p>極力、遅延読み込みしろ</p>
  </article>
</div>

- fishは関数の自動読み込みが便利
- zshなら [zsh-defer と zcompile を使った起動設定の例](https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache)も参考になる

<!-- _footer: "atusy/dotfiles · [zshの遅延読み込み](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/sheldon/plugins.toml#L3-L10)" -->

---

## シェル起動高速化の落とし穴

たとえば、プロンプトにブランチ名を出したいとき

```text
/some/path (git: master) $
```

ブランチ取得の非同期化だけでは、ユーザー入力をブロックすることがある

**先行入力を受け付けて、プロンプト更新を非同期化しよう**

<!-- _footer: "atusy/dotfiles · [Git情報の非同期取得](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/fish_prompt.fish#L39-L46) ／ [完了時の再描画](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/fish_prompt.fish#L85-L87)" -->

---

<!-- _class: benchmark -->

## シェルの真の起動時間をはかる

- `fish -i -c exit`なんて測ってないよね……？過剰評価するよ
- @AI: fishでユーザー入力ができるまでの所要時間をはかりたい

```fish
hyperfine --warmup 5 --runs 10 "expect -c '
  log_user 0
  set timeout 5
  spawn -noecho sh -c {stty rows 24 cols 120; exec env TERM=xterm-256color fish -i}
  set query [format {%c[0c} 27]
  expect -exact \$query {send -- [format {%c[?1;2c} 27]; exp_continue} \
    -exact {133;B} {close; exit 0} \
    timeout {exit 1} \
    eof {exit 2}
'"
```
---

## atusyのシェルの起動時間

|        | fish | zsh |
|--------|------|-----|
| 無設定 | 41.8ms | 29.1ms |
| atusy  | 50.1ms | 56.8ms |

---

## シェルのabbrはいいぞ

複雑なコマンドを`gpr`のようなキーワードからスペースで展開できる

```sh
gh pr checkout --detach
```

しかも

- **実行前に編集できる**
    - detachしたくないときは`--detach`を消す
- **履歴検索を正規化できる**
    - ghの操作履歴を`gh`で検索できる
- **画面共有で誤解がない**
    - aliasの`ll` みたいな `ls -l` か `ls -la` かわからない問題がない

<!-- _footer: "atusy/dotfiles · [関連例：checkout-detach の展開条件](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/__abbr-checkout-detach.fish#L1-L8)" -->

---

## こんなabbrもいいぞ

fishのabbrは関数で定義すると複雑なことができる

<div class="startup-cards abbr-demos">
  <article>
    <h3>すぐ使える電卓</h3>
    <video src="images/abbr-math.mp4" autoplay muted loop playsinline controls aria-label="mathを展開し、引用符の中に式を入力する例"></video>
    <p><code>math</code> で引用符を展開しカーソルも移動。続けて式を打てる。</p>
  </article>
  <article>
    <h3>長いオプションやパスの再利用</h3>
    <video src="images/abbr-mv.mp4" autoplay muted loop playsinline controls aria-label="直前のパスを複製して移動先に.bakを付ける例"></video>
    <p><code>,-1</code> で直前のパスを複製。末尾に <code>.bak</code> を足したりできる。</p>
  </article>
</div>


<!-- _footer: "atusy/dotfiles · [math と引数再利用の定義](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/config.fish#L38-L41) ／ [直前の引数を取り出す処理](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/__abbr-pick-token.fish#L1-L11)" -->

---

## シェルのaliasもたまにはいいぞ

```sh
alias opus="claude --model opus"
```

編集も正規化も共通認識もいらないなら、展開は邪魔なだけ

ただしatusyはシェル間で挙動が揃う実行スクリプトを好む

<!-- _footer: "atusy/dotfiles · [opus の実装（実行スクリプト）](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_local/lastresort/exact_bin/executable_opus#L1-L5)" -->

---

## こんなaliasならいいぞ

- AIモデルの使い分け
    - haiku, sonnet, opus, fable
- 互換性の高いコマンド
    - `alias ls=eza`
- 驚きの少ない設定のデフォルト化
    - `alias watch="watch --color"`

<!-- _footer: "atusy/dotfiles · [ls のラッパー関数](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/ls.fish#L1-L6) ／ [watch のラッパー関数](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/watch.fish#L1-L3)" -->

---

## シェルのキーバインドを使いこなせ

| こんなとき | キー設定 |
|---|---|
| 長いコマンドの先頭を直したい | `Ctrl+A` |
| 昨日打ったコマンドを探したい | `Ctrl+R` |
| ファイル名の候補を出したい | `Ctrl+X` → `Ctrl+F` |

<!-- _footer: "atusy/dotfiles · [fishのキー割り当て](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/config.fish#L43-L46)" -->

---

## 特にシェルの履歴を使いこなせ

<div class="history-demo">
  <div>
    <p><strong>最近の履歴ほど、また使いたいコマンドが溜まる。</strong></p>
    <p>再利用性の低い複雑なコマンドを人が打つことが減ったから。</p>
  </div>
  <figure>
    <video src="images/fzf-history.mp4" autoplay muted loop playsinline controls aria-label="gh pr chで履歴を絞り、以前のgh pr checkoutコマンドを呼び戻す例"></video>
  </figure>
</div>

<!-- _footer: "atusy/dotfiles · [fzfで選んだ候補を入力欄に戻す](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/set_commandline_from_suggestions.fish#L11-L20)" -->

---

## シェルの補完も忘れるな

使い方を覚えたり調べる時間を減らす

```fish
gh completion -s fish >~/.config/fish/completions/gh.fish
```

<!-- _footer: "atusy/dotfiles · [gh補完の登録](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/config.fish#L63) ／ [補完ファイルの更新](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/update_completion.fish#L1-L8)" -->

---

## 便利コマンド導入

ちまたにいっぱい解説があるので割愛

- zoxide: よくいくディレクトリに高速移動
- direnv: ディレクトリごとに環境変数を変更
- mise/nix: プロジェクトごとにコマンドのバージョンを固定

<!-- _footer: "atusy/dotfiles · [mise・direnv・zoxideの初期化](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/config.fish#L22-L24) ／ [zoxideを使うz関数](https://github.com/atusy/dotfiles/blob/ba3b08fd97761012c4ccd1168d18e4535f5a673b/dot_config/fish/functions/z.fish#L11-L26)" -->

---

<!-- _class: closing -->

## まとめ

AIに任せる作業が増えた今こそ、「さっとやりたい」をシェルで叶えよう

- **すぐ打てる** 起動直後に入力できるまで高速化しよう
- **少なく打てる** よく打つコマンドはabbrで展開。履歴や補完も活用しよう
- **すぐ取りかかれる** 移動はzoxide、環境の切り替えはdirenvやmise/nixで

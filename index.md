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
section.closing li::marker { color: #c2e89a; }
section::after { color: #688078; font-size: 17px; }
section.benchmark pre { font-size: .62em; }
section blockquote { border-left: 6px solid #84ac6e; color: #124e45; font-weight: 700; font-size: 1.5em; padding: .2em .65em; margin: .5em 0; }
section table { border-collapse: collapse; }
section table :is(th, td) { text-align: left; border: 0; border-bottom: 1px solid #bdccc0; }
section tbody tr:nth-child(n) { background: transparent; }
section table th { font-size: .82em; }
section.closing ul { list-style: none; padding: 0; }
section.closing li { padding: .45em 0; border-top: 1px solid #527569; }
</style>

<!-- _class: cover -->
<!-- _paginate: false -->

# AIじゃない！<br>あえてシェルを使うための<br>設定Tips！！

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

やりたいことに集中できる

- AIがやりたいこと（プロンプト）のやること（コマンド）化を代替
- AIが結果（コマンド出力）の解読を代替
- AIがシェル裁きの学習を代替
    - シェルの分布・コマンドのオプション・パイプのコツ……

---

## でもまだShell使うな……

> 「あのコマンドを打てば終わるな」

やることが決まっていて、結果も想像できる。
そんなときは、慣れたシェルで自分で打つほうが早い。

---

## なら今の使い方に合わせて設定しよう

| シェルでやりたいこと | 見直すところ |
|---|---|
| 開いたらすぐ打ちたい | 起動時に読み込む設定 |
| 知っているコマンドを短く打ちたい | abbr・alias・キーバインド・補完 |
| プロジェクトをすぐ切り替えたい | zoxide・direnv・mise/nix |

---

## 起動高速化

**最初の一文字を、いつ打てるか？**

プロンプトが見えても、裏で走る `git status` の完了まで入力をブロックしたら待ち時間は残る。

| 設定を見直すとき | やること |
|---|---|
| AIに任せて使わなくなった | 起動時の設定から外す |
| ときどき使う関数がある | fishの自動読み込みで、必要なときに読む |
| zshの初期化が重い | [zsh-defer と zcompile を使った例](https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache) |

---

<!-- _class: benchmark -->

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

`gpr` と打ってスペースを押すと……

```sh
gh pr checkout --detach
```

**実行前に編集できる。** 今回はブランチに乗りたい？　それなら `--detach` を消せばいい。

履歴にも画面共有にも展開後のコマンドが出る。
`ll` が `ls -l` と `ls -a` のどちらだったか、あとから迷わない。

---

## こんなabbrもいいぞ

- ちょっとした計算をラクチンに
    - `math`と入力すると`math ""`に展開され引用符の中にカーソルが入る
- 繰り返し入力をラクチンに
    - `mv すごく/ながい/パス ,-1`を`mv すごく/ながい/パス すごく/ながい/パス`に展開

fishのabbrは関数で定義できるので複雑なこともできる

---

## シェルのaliasもたまにはいいぞ

```sh
alias ll='ls -l'
```

**いつも同じオプションで使うなら、これで十分。**

入力も履歴も `ll` のまま。画面を一緒に見る人にも通じる短縮名なら使いやすい。

---

## こんなaliasならいいぞ

- 互換性の高いコマンド
    - 例: `alias ls=eza`
- 驚きの少ない設定のデフォルト化
    - 例: `alias watch="watch --color"`
- AIモデルの使い分け
    - 例: haiku, sonnet, opus, fable

---

## シェルのキーバインドを使いこなせ

| こんなとき | 押すキー |
|---|---|
| 長いコマンドの先頭を直したい | `Ctrl+A` |
| 昨日打ったコマンドを探したい | `Ctrl+R` |
| ファイル名の候補を出したい（Bash） | `Ctrl+X` → `Ctrl+F` |

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

<!-- _class: closing -->

## まとめ

AIに任せる作業が増えた今こそ、自分でよく打つコマンドに合わせて設定しよう

- **すぐ打てる**　入力できるまでを測り、重い設定は遅延読み込みに
- **短く打てる**　よく打つコマンドはabbrで展開。履歴や補完も活用しよう
- **すぐ取りかかれる**　移動はzoxide、環境の切り替えはdirenvやmise/nixで

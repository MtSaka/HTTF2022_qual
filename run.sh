cd `dirname $0`
# コンパイル
g++ -std=c++17 -O2 -Wall -Wextra -o solve solve.cpp
st=0
en=49
procs=8
print_error=1
f1(){
  cargo run --release --bin tester ./solve < in/$1.txt > out/$1.txt 
}
f2(){
  cargo run --release --bin vis in/$1.txt out/$1.txt >> score.txt 
}
export -f f1
export -f f2

rm -f score.txt
rm -rf out
mkdir out


usage(){
  cat <<EOM
使い方：
  -s : 開始 seed
  -e : 終了 seed
  -P : プロセス数
  -d : 指定でエラー出力なし
ただし，開始 seed から終了 seed までの入力ファイルは tools/in 下に置いておいてください．
EOM

  exit 2
}

while getopts "s:e:P:d" optKey; do
  case "$optKey" in
    s)
      st=${OPTARG}
      ;;
    e)
      en=${OPTARG}
      ;;
    P)
      procs=${OPTARG}
      ;;
    d)
      print_error=0
      ;;
    '-h' | '--help' | *)
      usage
      ;;
  esac
done

if [ $print_error = 0 ];
then
  seq -f '%04g' $st $en | xargs -n1 -P$procs -I{} bash -c "f1 {}"
  seq -f '%04g' $st $en | xargs -n1 -P$procs -I{} bash -c "f2 {}"
else 
  seq -f '%04g' $st $en | xargs -t -n1 -P$procs -I{} bash -c "f1 {}"
  seq -f '%04g' $st $en | xargs -t -n1 -P$procs -I{} bash -c "f2 {}"
fi

python3 evaluate.py
/*global $*/
var starCommonOption = {scoreName: 'review[reputation]',half: true};
//今回は、再宣言をするため、varを使用している。
function raty(id,starOption){
  // starOption.half = true;
  Object.assign(starOption, starCommonOption);
// varは変数で重複が可能なため、影響範囲が広い。そのためあまり好ましくはない。
// 変数宣言のみでもエラーにならない。
  $(id).empty();
  $(id).raty(starOption);
}

function ratyAddOption (starOption) {
  if (typeof starOption != "object") {
    return false;
  }
  Object.assign(starCommonOption, starOption);
}
// _edit_formでは表示されない。form.jsと同じかきかたではある。idに引数が入ってるのが問題かも?
// 一旦、manifest.jsやhtmlの方は戻してある。質問時違いを聞くこと。
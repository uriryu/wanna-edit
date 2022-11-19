/*global $*/
var starCommonOption = {scoreName: 'review[reputation]',half: true};
function raty(id,starOption){
  // starOption.half = true;
  Object.assign(starOption, starCommonOption);

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
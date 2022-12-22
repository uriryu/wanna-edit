Admin.create!(
    email: 'wanna_edit@hoge.com',
    password: 'wannaedit',
)

Genre.create([
  { name: 'YouTube動画' },
  { name: 'SNS動画' },
  { name: '広告動画' },
  { name: 'プライベート' },
  { name: 'プロモーション.PR' },
  { name: 'ミュージックビデオ' },
  { name: '結婚式用動画' },
  { name: 'イベント動画' },
  { name: 'ボーカロイド動画(ゆっくり等)' },
  { name: 'その他' }
])

User.create([
  {
    user_name: 'Ruby',
    email: 'sample@sample.com',
    telephone_number: '00011113333',
    password: 'wannasample'
  },
  {
    user_name: 'なると',
    email: 'naruto@naruto.com',
    telephone_number: '01234567890',
    password: 'naruto19'
  }
])
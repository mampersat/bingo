# bingo

(Yet another) Buzz Word Bingo implementation currently tuned for the 7th Inning Stretch daily web broadcast

## Publishing Web
aws s3 cp --recursive build/web s3://mampersat.com/bingo/

## Publishing Android
edit android/app/build.gradle - flutterversionCode and flutterversionName
`flutter build appbundle'
Google play console - app releases - manage button - create release
Add bundle (browse files) build/app/outputs/bundle/release/app-release.aab
Click "Save"
Click "Release"
Click "Start rollout to production"

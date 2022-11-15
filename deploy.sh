rm -rf dist &&
yarn build &&
cd dist &&
git init &&
git add . &&
git commit -m 'update' &&
git branch -M master &&
git remote add origin git@github.com:AeahKa/calculator-demo.git &&
git push -f -u origin master &&
cd -
echo https://aeahka.github.io/calculator-demo/index.html
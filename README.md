# README
## after checkout
install gems
```
mkdir .gems
bundle install --without=production --path=.gems
```

add heroku repository
```
heroku git:remote -a daily-score
```

#!/bin/env bash
# set -euo pipefail

# cd ~/tokyo2024-poster-map/ #Path to the folder

# git pull

# Download latest CSV from spreadsheet datbase
curl -sL -o public/data/all.csv "https://script.google.com/macros/s/AKfycbwYoxr5Zl97nRETMUyEcMBuDR2gG1WWhQ8BAVq6vYuiQR8y5oRFjfhT88l2-MbrgwJl6w/exec" 

# all.json
python3 csv2json_small.py public/data/all.csv public/data/

# summary.json
python3 summarize_progress.py ./public/data/summary.json

# summary_absolute.json
python3 summarize_progress_absolute.py ./public/data/summary_absolute.json

git add -N .

if ! git diff --exit-code --quiet
then
    git add .
    git commit -m "Update"
    git push
    # source .env
    # npx netlify-cli deploy --prod --message "Deploy" --dir=./public --auth $NETLIFY_AUTH_TOKEN
fi

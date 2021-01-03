#!/bin/bash
if [[ -n $REPO_NAME && -n $GIT_USER && -n $GIT_PASS ]]; then
  git clone https://"$GIT_USER":"$GIT_PASS"@github.com/"$GIT_USER"/"$REPO_NAME"
  cp accounts/*.json /sa/
  echo "Cloned Service Accounts From Git and Configured"
elif [[ -n $DIR_ZIP_URL ]]; then
  wget -qq $DIR_ZIP_URL -O acc.zip
  unzip -qq acc.zip -d /sa/
  echo "Downloaded Service Accounts From Direct ZIP URL and Configured"
else
  echo "Neither Service accounts ZIP Nor Git Repo Not Provided So Using the refresh token "
fi
echo "const TIMEOUT_BASE = 7000
const TIMEOUT_MAX = 60000
const LOG_DELAY = 5000
const PAGE_SIZE = 1000
const RETRY_LIMIT = 7
const PARALLEL_LIMIT = $PARALLEL_PROCESS
const DEFAULT_TARGET = '$DEFAULT_DEST'
const AUTH = {
  client_id: '$CLIENT_ID',
  client_secret: '$CLIENT_SECRET',
  refresh_token: '$REFRESH_TOKEN',
  expires: 0,
  access_token: '',
  tg_token: '$TG_BOT',
  tg_whitelist: ['$TG_USER']
}
module.exports = { AUTH, PARALLEL_LIMIT, RETRY_LIMIT, TIMEOUT_BASE, TIMEOUT_MAX, LOG_DELAY, PAGE_SIZE, DEFAULT_TARGET }" >> config.js

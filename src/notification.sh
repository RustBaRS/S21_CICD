#!/bin/bash

if [[ ${2} == "1" ]] && [[ $CI_JOB_STATUS == "success" ]]
    then
        exit
fi

STATUS="$(echo "$CI_JOB_STATUS")"
TIME=60


TELEGRAM_BOT_TOKEN="6220407810:AAHKFbf2H63en_KTQsIiGn9LGnQmgVYaHjo"
TELEGRAM_USER_ID="417283332"

URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Deploy status: $1 $STATUS%0A%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"

curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null

#!/bin/bash

# scripts/dingtalk-notify.sh

# 1. 变量赋值, 直接使用环境变量，不需要 ${{ }}

STATUS="$DEPLOY_RESULT" 

# 2. 逻辑判断
if [ "$STATUS" = "success" ]; then 
TITLE="✅ 部署成功"
else
TITLE="❌ 部署失败"
fi

if [ "$COMMIT_MESSAGE" = "" ]; then 
COMMIT_MESSAGE="Here no more message."
else
COMMIT_MESSAGE="$COMMIT_MESSAGE"
fi

# 3. 构建 Markdown 内容
MARKDOWN_TEXT="# ${TITLE} 
**项目**: -pj 

**提交信息**: ${COMMIT_MESSAGE} 

**分支信息**: ${REF_NAME}

**流水线触发用户**: ${ACTOR} 

**代码更改用户**: ${SENDER_LOGIN}

**事件类型**: ${EVENET_NAME}

**代码更新时间**: ${EVENT_REPOSITORY_PUSHED_AT}

**访问地址**: [点击访问](${SERVER_URL})  
              
> 来自 GitHub Actions 自动化流水线"

# 4. 构造 JSON 负载
JSON_PAYLOAD=$(jq -n \
    --arg msgtype "markdown" \
    --arg title "GitHub Actions" \
    --arg text "$MARKDOWN_TEXT" \
    '{msgtype: $msgtype, markdown: {title: $title, text: $text}}')

# 5. 发送请求
curl -X POST "$WEBHOOK_URL" \
-H "Content-Type: application/json" \
-d "$JSON_PAYLOAD"

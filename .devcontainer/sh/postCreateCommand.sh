#!/bin/sh

# fronetend permission change
sudo chown -R $USER:$USER /workspace/frontend

# Setting up the AWS CLI configuration
export $(grep -v '^#' /workspace/.env | xargs)

## AWS CLI設定ファイルの作成
mkdir -p /home/$USER/.aws

## configファイルの作成
cat <<EOT > /home/$USER/.aws/config
[default]
region = ap-northeast-1
output = json
EOT

## credentialsファイルの作成
cat <<EOT > /home/$USER/.aws/credentials
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOT

## 権限の設定
chown -R $USER:$USER /home/$USER/.aws

# Frontend Setting
cd /workspace/frontend/web/
bun install --frozen-lockfile

# Backend Setting
cd /workspace/backend/api
bundle install

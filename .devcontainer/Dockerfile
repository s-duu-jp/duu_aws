# Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# ユーザーとグループのIDを必要に応じて更新
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# UID/GIDを更新して必要ならユーザーを作成
RUN if [ "$USER_UID" != "1000" ] || [ "$USER_GID" != "1000" ]; then \
    groupmod -o -g "$USER_GID" "$USERNAME" || (addgroup -g "$USER_GID" "$USERNAME" && groupmod -o -g "$USER_GID" "$USERNAME"); \
    usermod -o -u "$USER_UID" -g "$USER_GID" "$USERNAME" || (adduser -u "$USER_UID" -D -G "$USERNAME" "$USERNAME" && usermod -o -u "$USER_UID" -g "$USER_GID" "$USERNAME"); \
    chown -R $USER_UID:$USER_GID /home/$USERNAME; \
    fi

# ワークスペースディレクトリの設定
WORKDIR /workspace

# Created Web Volume Directory
RUN mkdir -p /workspace/frontend/web/.next \
    && mkdir -p /workspace/frontend/web/node_modules

# Node.js Install
# https://github.com/nvm-sh/nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && sudo chown -R $USERNAME:$USERNAME /root \
    && echo 'export NVM_DIR="/root/.nvm"' >> /home/$USERNAME/.bashrc \
    && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /home/$USERNAME/.bashrc \
    && echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> /home/$USERNAME/.bashrc \
    && . ~/.nvm/nvm.sh \
    && bash -i -c 'nvm install 20.13.1'

# Bun Install
RUN curl -fsSL https://bun.sh/install | bash \
    && sudo chown -R $USERNAME:$USERNAME /root \
    && echo 'export PATH="/root/.bun/bin:$PATH"' >> /home/$USERNAME/.bashrc

# AWS CLI Install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf awscliv2.zip aws

# Rubyのインストール
ARG RUBY_VERTION=3.3.1
RUN apt-get update && \
    apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev wget git libffi-dev libyaml-dev libmariadb-dev && \
    git clone https://github.com/rbenv/ruby-build.git && \
    cd ruby-build && \
    ./install.sh && \
    cd .. && \
    rm -rf ruby-build && \
    ruby-build ${RUBY_VERTION} /usr/local/ruby-${RUBY_VERTION}

# PATHの設定
ENV PATH="/usr/local/ruby-${RUBY_VERTION}/bin:${PATH}"

## bundler Install
RUN gem install bundler

## rails Install
RUN gem install rails

## solargraph Install
RUN gem install solargraph
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

# Rails環境のsetup
## rbenv Install
RUN sudo apt update && sudo apt install -y rbenv libffi-dev libyaml-dev ruby-dev build-essential libmysqlclient-dev
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN . ~/.bashrc
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

## ruby Install
RUN rbenv install 3.3.1
RUN rbenv global 3.3.1

## bundler Install
RUN gem install bundler -v 2.5.9

## rails Install
RUN gem install rails -v 7.1.3

## rails用のPrettier設定 - nodejs Install
RUN curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN gem install bundler prettier_print syntax_tree syntax_tree-haml syntax_tree-rbs rubocop

## permissionの変更
RUN sudo chown vscode:vscode -R /var/lib/gems
RUN sudo chown vscode:vscode -R /usr/local/bin

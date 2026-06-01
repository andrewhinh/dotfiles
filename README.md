# dotfiles

macOS zsh config. Inspired by [swyx's mac setup](https://www.swyx.io/new-mac-setup) and [dotfiles gist](https://gist.github.com/swyxio/7fa1009e460ecb818d5e6d9ca4616a05).

## Setup

```bash
git clone https://github.com/andrewhinh/dotfiles.git
cd dotfiles

./install.sh && brew bundle

# oh-my-zsh + custom plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# rust, atuin
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh

# node
fnm install && fnm default

# git
printf '[user]\n\tname = <your name>\n\temail = <your email>\n' > ~/.gitconfig.local
gh auth login
```

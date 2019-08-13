# This script only needs to be run for a first time set up of
# the repository and the ecosystem that supports it.

# PRE-REQUISITES
# (1) Make sure your Homebrew is reasonably up-to-date. (1.4.x or greater)
# (2) Have the X-Code tools installed. Necessary for a development tool chain.
#     xcode-select --install

# Dependencies
# You can include these, but LucidVue uses a WebDriver Manager to take
# care of automatically downloading binaries.
# brew install phantomjs
# brew install chromedriver

# Install Ruby version manager.
brew install rbenv ruby-build

# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile

source ~/.bash_profile

# Install Ruby version and make it the default.
rbenv install 2.5.0
rbenv global 2.5.0
rbenv rehash

# Clone Lucid repo.
git clone https://github.com/jeffnyman/lucid_vue
cd lucid-vue

# Execution Context.
gem install bundler
bundle install

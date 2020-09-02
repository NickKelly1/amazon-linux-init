sudo yum update -y

# install zsh
sudo yum install zsh

# install git
sudo yum install git

# install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# add some zsh plugins...
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
sed -i 's/^plugins=(git)$/plugins=(git vi-mode colorize zsh-completions zsh-syntax-highlighting colored-man-pages)/' ~/.zshrc

# Install nvm [Homepage](https://github.com/nvm-sh/nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh
source ~/.zshrc
# Install the latest NodeJS version [Homepage](https://nodejs.org/en/)
nvm install 14.9.0



# Install docker [Guide](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html)
sudo amazon-linux-extras install docker
sudo yum install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
# To get the new docker permissions, need to restart ssh session

# install docker compose [Gist](https://gist.github.com/npearce/6f3c7826c7499587f00957fee62f8ee9)
# note: watch out for escaping when copying into shell..
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose



# Note: couldn't change default shell without ec2-user's password... (required by chsh)
# instead of changing default shell, just open zsh upon sourcing bash...

# Set default shell to zsh
# [Setting default shell on Linux](https://askubuntu.com/questions/131823/how-to-make-zsh-the-default-shell
# [Getting chsh on Amazon Linux](https://superuser.com/questions/231735/how-do-i-change-my-default-shell-on-a-aws-instance)
# sudo yum install util-linux-user
# [Default ec2-user password](https://forums.aws.amazon.com/thread.jspa?threadID=159388)
# chsh -s $(which zsh)
printf '\n# Open zsh ontop of bash...\nzsh\n' >> ~/.bashrc

rm -rf .vim
git clone https://github.com/nickkelly1/.vim
# Remove YouCompleteMe - won't need it...
sed -i 's/^.*YcmCompleter/" __redacted__/g' .vim/vimrc
sed -i 's/^.*YouCompleteMe/" __redacted__/g' .vim/vimrc
# https://github.com/junegunn/vim-plug/issues/675
vim +'PlugInstall --sync' +qa

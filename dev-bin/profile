# source this in the .bash_profile 

alias vssh='vagrant ssh -c "sudo su -"'
alias vap='ansible-playbook -i .vagrant/provisioners/ansible/inventory --connection=ssh --timeout=30 --limit=all '

source /opt/rh/sclo-vagrant1/enable
export X_SCLS="`scl enable sclo-vagrant1 'echo $X_SCLS'`"

#Variables to use for testing branch for samba-integration
export GIT_REPO_URL="https://github.com/spuiuk/samba-integration"
export GIT_REPO_BRANCH="testing"
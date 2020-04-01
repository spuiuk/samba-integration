.PHONY: test

#Original target
test:
	ghprbPullId='' ./samba-integration-centos-ci-tests.sh

#Use when needing to test the samba-integration/vagrant level ansible plays.
#This does not delete and fetch a new copy of the repo
#to be used when make test has already been called first and we need to test changes.
retest: 
	cd tests/samba-integration/; make test

# Only copy over the samba-integration/vagrant/ansible folder to setup and fix setup
setup.prep:
	cd tests/samba-integration/vagrant; make setup.prep.only;

# fix ssh on the local test machine. Note the .ssh/config file is overwritten.
# Need to run this for rsync and ssh from test machines to work properly
# required to be run atleast once before calling setup.build target
fix_ssh:
	mkdir -p /root/.vagrant.d/
	cp tests/samba-integration/vagrant/ansible/vagrant_insecure_private_ssh_key /root/.vagrant.d/insecure_private_key
	chmod 0700 /root/.vagrant.d/insecure_private_key
	cp tests/samba-integration/vagrant/ssh-config-host ~/.ssh/config
	ssh vagrant@setup "sudo rsync -av --no-o ~vagrant/.ssh/* /root/.ssh"

#rsync setup files and call ansible scripts on setup.
setup.build:
	rsync -av tests/samba-integration/vagrant/ansible/* root@setup:/home/vagrant/ansible
	ssh root@setup "sudo ansible-playbook -i /home/vagrant/ansible/vagrant_ansible_inventory /home/vagrant/ansible/site.yml"


#remove vagrant machines
clean:
	cd vagrant; vagrant destroy -f

#redo test
redo: clean test

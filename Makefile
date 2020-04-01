.PHONY: test


test:
	ghprbPullId='' ./samba-integration-centos-ci-tests.sh

retest: 
	cd tests/samba-integration/; make test

setup.prep:
	cd tests/samba-integration/vagrant; make setup.prep.only;

fix_ssh:
	mkdir -p /root/.vagrant.d/
	cp tests/samba-integration/vagrant/ansible/vagrant_insecure_private_ssh_key /root/.vagrant.d/insecure_private_key
	chmod 0700 /root/.vagrant.d/insecure_private_key
	cp tests/samba-integration/vagrant/ssh-config-host ~/.ssh/config
	ssh vagrant@setup "sudo rsync -av --no-o ~vagrant/.ssh/* /root/.ssh"

setup.build:
	rsync -av tests/samba-integration/vagrant/ansible/* root@setup:/home/vagrant/ansible
	ssh root@setup "sudo ansible-playbook -i /home/vagrant/ansible/vagrant_ansible_inventory /home/vagrant/ansible/site.yml"

clean:
	cd vagrant; vagrant destroy -f

redo: clean test

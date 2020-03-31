.PHONY: test


test:
	ghprbPullId='' ./samba-integration-centos-ci-tests.sh

retest: 
	cd tests/samba-integration/; make test

setup.prep:
	cd tests/samba-integration/vagrant; make setup.prep.only;

setup.build:
	chmod 700 tests/samba-integration/vagrant/ansible/vagrant_insecure_private_ssh_key;
	ssh -i tests/samba-integration/vagrant/ansible/vagrant_insecure_private_ssh_key -o StrictHostKeyChecking=no vagrant@192.168.122.200 "sudo ansible-playbook -i /home/vagrant/ansible/vagrant_ansible_inventory /home/vagrant/ansible/site.yml"

clean:
	cd vagrant; vagrant destroy -f

redo: clean test

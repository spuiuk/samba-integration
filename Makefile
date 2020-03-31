.PHONY: test


test:
	ghprbPullId='' ./samba-integration-centos-ci-tests.sh
clean:
	cd vagrant; vagrant destroy -f

redo: clean test

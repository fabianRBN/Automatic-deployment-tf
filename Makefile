JENKINS_DOCKER_AGENT_SECRET := 3b28ca5aa0993f717b320d49beb79e61b7413c44bcc9305511e56e7e385cff11
JENKINS_MAVEN_AGENT_SECRET := 35f3eb2b889f40458469e8101776dcbcef5da61de981fba605421b343fc6cf84
JENKINS_NODE_AGENT_SECRET := 240594803f0b8cc1d3c6a036bffa68186d5b5810920110e74173c8489abac9be
GITLAB_TOKEN := 1Lrw11yzWRrsaiZLxwci

.PHONY: all $(MAKECMDGOALS)

build-agents:
	docker build -t jenkins-agent-docker ./jenkins-agent-docker
	docker build -t jenkins-agent-maven ./jenkins-agent-maven
	docker build -t jenkins-agent-node ./jenkins-agent-node

start-simple-jenkins:
	docker run -d --rm --stop-timeout 60 --name jenkins-server --volume jenkins-data:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts

start-jenkins:
	docker network create jenkins || true
	docker run -d --rm --stop-timeout 60 --network jenkins --name jenkins-docker --privileged --network-alias docker  --env DOCKER_TLS_CERTDIR=/certs  --volume jenkins-docker-certs:/certs/client  --volume jenkins-data:/var/jenkins_home -p 2376:2376 -p 80:80 docker:dind
	docker run -d --rm --stop-timeout 60 --network jenkins --name jenkins-server --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 --volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
	sleep 30
	docker run -d --rm --network jenkins --name jenkins-agent-docker --init --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 --volume jenkins-docker-certs:/certs/client:ro --env JENKINS_URL=http://jenkins-server:8080 --env JENKINS_AGENT_NAME=agent01 --env JENKINS_SECRET=$(JENKINS_DOCKER_AGENT_SECRET) --env JENKINS_AGENT_WORKDIR=/home/jenkins/agent jenkins-agent-docker
	docker run -d --rm --network jenkins --name jenkins-agent-maven --init --env JENKINS_URL=http://jenkins-server:8080 --env JENKINS_AGENT_NAME=agent02 --env JENKINS_SECRET=$(JENKINS_MAVEN_AGENT_SECRET) --env JENKINS_AGENT_WORKDIR=/home/jenkins/agent jenkins-agent-maven
	docker run -d --rm --network jenkins --name jenkins-agent-node --init --env JENKINS_URL=http://jenkins-server:8080 --env JENKINS_AGENT_NAME=agent03 --env JENKINS_SECRET=$(JENKINS_NODE_AGENT_SECRET) --env JENKINS_AGENT_WORKDIR=/home/jenkins/agent jenkins-agent-node


jenkins-password:
	docker exec jenkins-server cat /var/jenkins_home/secrets/initialAdminPassword && echo "fabian95"

stop-jenkins:
	docker stop jenkins-agent-docker || true
	docker stop jenkins-agent-maven || true
	docker stop jenkins-agent-node || true
	docker stop jenkins-docker || true
	docker stop jenkins-server || true
	docker network rm jenkins || true


start-gitlab:
	docker network create gitlab || true
	docker run -d --rm --stop-timeout 60 --network gitlab --hostname localhost --name gitlab-server -p 80:80 -p 443:443 -p 2222:22 --volume gitlab_config:/etc/gitlab --volume gitlab_logs:/var/log/gitlab --volume gitlab_data:/var/opt/gitlab gitlab/gitlab-ce:latest
	sleep 90
	docker run -d --rm --network gitlab --name gitlab-runner --volume gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner
	docker run --rm --network gitlab --volume gitlab-runner-config:/etc/gitlab-runner gitlab/gitlab-runner register --non-interactive --executor "shell" --url "http://gitlab-server/" --registration-token "$(GITLAB_TOKEN)" --description "runner01" --tag-list "ssh" --locked="false" --access-level="not_protected"

stop-gitlab:
	docker stop gitlab-server || true
	docker stop gitlab-runner || true
	docker network rm gitlab || true

start-nexus:
	docker run -d --name nexus-server -v nexus-data:/nexus-data -p 8081:8081 sonatype/nexus3

start-nexus-jenkins:
	docker run -d --rm --network jenkins --name nexus-server -v nexus-data:/nexus-data -p 8081:8081 sonatype/nexus3

nexus-password:
	docker exec nexus-server cat /nexus-data/admin.password && echo ""

stop-nexus:
	docker stop --time=120 nexus-server

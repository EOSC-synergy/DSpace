@Library(['github.com/indigo-dc/jenkins-pipeline-library@release/2.1.0']) _

def projectConfig

pipeline {
    agent any

    stages {
        stage('SQA baseline dynamic stages') {
            steps {
                script {
                    projectConfig = pipelineConfig()
                    buildStages(projectConfig)
                }
            }
            post {
                cleanup {
                    cleanWs()
                }
            }
        }
        stage('Component integration tests') {
            agent any
            steps {
                echo "Running tests in a fully containerized environment - :)"
                dir ('.') {
                    sh 'docker-compose down -v --rmi all --remove-orphans'
                    sh 'docker-compose -p d7 -f docker-compose-fair.yml -f dspace/src/main/docker-compose/docker-compose-angular.yml up -d'
                    sh 'docker logs -f dspace-ingest'
                }
            }
        }
        stage('Repository FAIRness assesment') {
            agent any
            steps {
                echo "Check ingestion"
                dir ('.') {
                    sh 'docker logs -f dspace-ingest'
                }
            }
        }
    }
}


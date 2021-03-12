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
                    sh 'docker-compose -p d7 -f docker-compose-fair.yml -f dspace/src/main/docker-compose/docker-compose-angular.yml up -d'
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
        stage('Integration cleanup') {
            agent any
            steps {
                echo "Clean up"
                dir ('.') {
                    sh 'docker-compose docker-compose-fair.yml down -v'
                }
            }
        }
    }
}


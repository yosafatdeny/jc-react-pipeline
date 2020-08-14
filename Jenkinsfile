pipeline {
    // agent {
    //     docker {
    //         image 'node:6-alpine'
    //         args '-p 3000:3000'
    //         args '-v $HOME/.m2:/root/.m2'
    //     }
    // }
    agent any
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                echo 'start build'
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Build react project') {
            steps{
                sh 'npm run build'
            }
        }
        stage('Build Docker image') {
            steps{
                script {
                    app = docker.build("hisbu/reactapp-test")
                }
            }
        }
        stage('Test docker image'){
            steps{
                sh 'docker run -d --rm --name testImages -p 8081:80 hisbu/reactapp-test'
                // input message: "Finished test image? (Click procced to continue)"
            }
        }
        stage('Clean up docker test'){
            steps{
                sh 'docker stop testImages'
            }
        }
        stage('Push image to registry'){
            steps{
                script{
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerHub'){
                        app.push()
                    }
                }
            }
        }
        stage('Clean up image'){
            steps{
                sh 'docker rmi hisbu/reactapp-test'
            }
        }
        stage('Deploy to Kubernetes'){
            steps{
                sshagent(['kubeAccess']) {
                    sh "scp -o StricHostKeyChecking=no reactapp-deployment.yml hisbu@34.71.135.171:/home/hisbu/reactapp/"
                    sh "ssh hisbu@34.71.135.171 sudo kubectl apply -f reactapp/."
                }
            }
        }
        // stage('Deployment to Production'){
        //     steps{
        //         milestone(1)
        //         kubernetesDeploy(
        //             kubeconfigId: 'kubeconfig',
        //             configs: 'reactapp-deployment.yml',
        //             enableConfigSubstitution: true
        //         )
        //     }
        // }
    }
}
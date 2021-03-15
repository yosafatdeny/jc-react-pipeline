pipeline {
  agent any

  environment{
    // CI = true
    DOCKER_TAG = getDockerTag()
  }

  stages {
    
    stage ('Install Dependencies react project'){
      steps{
        echo "Starts install dependencies react project"
        sh "npm install"
      }
    }

    //stage dua
    stage ('Test project'){
      steps{
        echo "run test script"    
        // sh 'chmod +x jenkins/scripts/test.sh'
        // sh './jenkins/scripts/test.sh'
      }
    } 

    //stage tiga
    stage ('Build react project'){
      steps{    
        sh 'npm run build'
      }
    } 

    //stage empat
    stage ('Build docker images'){
      steps{    
        script {
          app = docker.build("yosafatdeny/reactapp-jcde") 
        }    
      }
    }

    //stage lima
    stage ('test docker images'){
      steps{    
        sh 'docker run -d --rm --name testimage -p 8081:80 yosafatdeny/reactapp-jcde'   
        input message: "Finished test image? (Click procced to continue)"
      }      
    } 

    //stage enam
    stage ('clean up docker test'){
      steps{    
        sh 'docker stop testimage'    
      }    
    }   

    //stage tujuh
    stage ('push image to registry'){
      steps{    
        script{
          docker.withRegistry("https://registry.hub.docker.com", "dockerhub-yosafatdeny"){
            app.push("${DOCKER_TAG}")
            app.push("latest")    
          }    
        }    
      }    
    }  

    //stage delapan
    stage ('clean up docker images'){
      steps{    
        sh 'docker rmi yosafatdeny/react-jcde'    
      }    
    }                 
  }      
}

def getDockerTag(){
  def tag = sh script: "git rev-parse HEAD", returnStdout: true
  return tag    
}
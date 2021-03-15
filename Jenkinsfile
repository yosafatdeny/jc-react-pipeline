pipeline {
  agent any

  environment{
    CI = true
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

    stage ('Build react project'){
      steps{    
        sh 'npm run build'
      }
    }        
  }      
}
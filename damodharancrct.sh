node{
    stage("git integration"){
        git url:"https://github.com/tamilarasanr27/java-web-app-docker-New-Project"
    }
    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven-3.5.6", type: "maven"
      sh "${mavenHome}/bin/mvn clean package"
    } 
    
    stage("Build Docker Imager"){
   sh 'docker build -t tamilarasn/myweb:0.0.2 .'
   }
   stage("Docker Image Push"){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh 'docker login -u tamilarasn -p ${dockerPassword}'
    }
   sh 'docker push tamilarasn/myweb:0.0.2'
   }
    
}
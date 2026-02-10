pipeline {
    agent any


    environment {
        PLANET = 'EARTH'
        MYNAME = 'Roy'
    }

    parameters {
        string(name: 'VERSION', defaultValue: '1.0.0', description: 'Version to deploy')
        booleanParam(name: 'executeTests', defaultValue:'true', description: '')
    }

    stages {
        stage('Initialize') {
            steps {
                echo "Initializing pipeline for $PLANET is ready!"
                echo "Initializing pipeline for ${env.PLANET} is ready!"
            }
        }

        stage('Build') {
            steps {
                echo 'Building the app'
                sh "echo 'Developer: ${env.MYNAME}' >> build_info.txt"
                sh 'ls -la' // Lists all files in the current workspace
            }


        }

        stage('Run Script') {
            steps {
                // 1. make the script executable!
                sh 'chmod +x ./script.sh'

                //2. Run the script.sh and pass the VERSIION param
                sh "./script.sh ${params.VERSION}"
            }
        }

        stage('Test'){
            when { ///  This is a conditional block used to control the execution of a stage based on certain conditions.
                expression {
                    params.executeTests == true
                }
            }
            steps{
                echo 'Running tests...'
                /// this command forces the pipeline to stop and mark itself as FAILED
                // error "Simulating failure"
            }
        }
    }

    post {
        always {
            echo 'This runs always in the post section after the pipeline finishes regardless of success or failure'
        }
        success {
            echo 'This runs only if the pipeline succeeds'
            echo 'cleaning up workspace...'
            archiveArtifacts artifacts: 'build_info.txt', followSymlinks: false
        }
        failure {
            echo 'This runs only if the pipeline fails'
        }

    }


}


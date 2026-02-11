pipeline {
    agent any


    environment {
        PLANET = 'EARTH'
        MY_DEVELOPER_NAME = 'Roy'
    }

    parameters {
        string(name: 'VERSION', defaultValue: '1.0.0', description: 'Version to deploy')
        booleanParam(name: 'executeTests', defaultValue:'true', description: '')
        string(name: 'USER_NAME', defaultValue: 'Guest', description: 'Who are you?')
        string(name: 'BRANCH_TO_USE', defaultValue: 'roy_branch1', description: 'Branch to use?')
    }

    stages {
        stage('Initialize') {
            steps {
                echo "Welcome ${params.USER_NAME} to the awesome Jenkins pipeline!, You are using the branch ${params.BRANCH_TO_USE}"
                echo "The current build number is ${env.BUILD_NUMBER}"
                echo "Initializing pipeline for $PLANET is ready!"
                }
        }

        stage('Build') {
            steps {
                echo 'Building the app'
                sh "echo 'Developer: ${env.MY_DEVELOPER_NAME}' >> build_info.txt"

                // creating outputs dir and output.txt file
                sh 'chmod +x ./scripts/script_create_output_dir_file.sh' // make the script executable
                sh './scripts/script_create_output_dir_file.sh' // run the script to create outputs dir and output.txt file

                sh 'ls -la' // Lists all files in the current workspace

            }


        }

        stage('Run Script') {
            steps {
                // 1. make the script executable!
                sh 'chmod +x ./scripts/script.sh'

                //2. Run the script.sh and pass the VERSIION param
                sh "./scripts/script.sh ${params.VERSION}"
            }
        }
        /// Parallel tests: https://dev.to/vandana_babshetti_91df8eb/parallel-stages-with-declarative-pipeline-in-jenkins-cicd-11fk
        stage('Parallel Tests'){
            when { ///  This is a conditional block used to control the execution of a stage based on certain conditions.
                expression {
                    params.executeTests == true
                }
            }
            parallel {
                stage('Unit Tests'){
                    steps{
                        echo 'Unit tests are running...'
                    }
                }
                stage('Integration Tests'){
                    steps{
                        echo 'Integration tests are running...'
                    }
                }
                stage('Static Code Analysis'){
                    steps{
                        echo 'Static code analysis is running...'
                         // error "Simulating failure"     /// this command forces the pipeline to stop and mark itself as FAILED
                    }
                }
            }

        }
        stage('Push to Github'){
                    steps {
                        withCredentials([usernamePassword(credentialsId: 'GitHub_PUSH1', 
                                        passwordVariable: 'GIT_PASSWORD', 
                                        usernameVariable: 'GIT_USERNAME')]) {
                            
                            sh """
                                # 1. Setup identity
                                git config user.email "jenkins@build.bot"
                                git config user.name "Jenkins Bot"

                                # 2. Re-configure the remote
                                # We use the variable names defined in the withCredentials block above
                                git remote set-url origin https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/daviddor1960/jenkins-practice.git

                                # 3. Add and commit
                                git add outputs/my_output_file.txt
                                
                                # Use || true so it doesn't fail if nothing changed
                                git commit -m "docs: update output file from build ${BUILD_NUMBER} [skip ci]" || true
                                
                                # 4. Push back to your specific branch
                                git push origin HEAD:${params.BRANCH_TO_USE}
                            """
                        }
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


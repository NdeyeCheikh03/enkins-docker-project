pipeline {
    agent any

    environment {
        IMAGE_NAME = "sum-python"
        CONTAINER_ID = ""
        TEST_FILE_PATH = "test_variables.txt"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    bat "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run') {
            steps {
                script {
                    CONTAINER_ID = sh(script: "docker run -d ${IMAGE_NAME}", returnStdout: true).trim()
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    def testLines = readFile(TEST_FILE_PATH).split("\n")
                    for (line in testLines) {
                        def vars = line.split(" ")
                        def arg1 = vars[0]
                        def arg2 = vars[1]
                        def expectedSum = vars[2].toFloat()

                        def output = sh(script: "docker exec ${CONTAINER_ID} python sum.py ${arg1} ${arg2}", returnStdout: true).trim()
                        def result = output.toFloat()

                        if (result == expectedSum) {
                            echo "Test réussi : ${arg1} + ${arg2} = ${result}"
                        } else {
                            error "Test échoué : ${arg1} + ${arg2} devait être ${expectedSum}, mais a retourné ${result}"
                        }
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    sh "docker stop ${CONTAINER_ID}"
                    sh "docker rm ${CONTAINER_ID}"
                }
            }
        }

        stage('Deploy to DockerHub') {
            steps {
                script {
                    sh "docker login -u ndeyecdiop03 -p MINTOu77*"
                    sh "docker tag ${IMAGE_NAME} ndeyecdiop03/${IMAGE_NAME}"
                    sh "docker push ndeyecdiop03/${IMAGE_NAME}"
                }
            }
        }
    }
}

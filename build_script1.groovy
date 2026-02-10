//build_script1.groovy

def build() {
    echo 'Building from build_script1.groovy'
}
return this




    script {
        gv = load "build_script1.groovy"
        gv.build()
    }
node {

    stage ('git') {
        checkout scm
    }

    stage ('test') {
        dir ('game') {
            sh 'docker run --rm -v $(pwd):/s -w /s mtmk/godot /godot -s addons/gut/gut_cmdln.gd -gexit -gdir=res://test'
        }
    }

}

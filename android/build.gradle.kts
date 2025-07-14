buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Firebase / Google services plugin
        classpath("com.google.gms:google-services:4.4.3")
    }
}
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val subprojectBuildDir = newBuildDir.dir(name)
    layout.buildDirectory.set(subprojectBuildDir)

    evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

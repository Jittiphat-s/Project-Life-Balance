plugins {
    id("com.android.application")
    id("kotlin-android")
    // Flutter Gradle Plugin ต้องอยู่หลัง Android และ Kotlin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.project_life_balance"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }


    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }


    defaultConfig {
        applicationId = "com.example.project_life_balance"
        minSdk = 26
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }



    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}


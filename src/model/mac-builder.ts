import { exec } from '@actions/exec';
import BuildParameters from './build-parameters';

class MacBuilder {
  public static async run(
    actionFolder: string,
    buildParameters: BuildParameters,
    silent: boolean = false,
  ): Promise<number> {
    const environmentVariables = {
      ACTION_FOLDER: actionFolder,
      UNITY_VERSION: buildParameters.editorVersion,
      UNITY_SERIAL: buildParameters.unitySerial,
      UNITY_LICENSING_SERVER: buildParameters.unityLicensingServer,
      SKIP_ACTIVATION: buildParameters.skipActivation,
      PROJECT_PATH: buildParameters.projectPath,
      BUILD_TARGET: buildParameters.targetPlatform,
      BUILD_NAME: buildParameters.buildName,
      BUILD_PATH: buildParameters.buildPath,
      BUILD_FILE: buildParameters.buildFile,
      BUILD_METHOD: buildParameters.buildMethod,
      VERSION: buildParameters.buildVersion,
      ANDROID_VERSION_CODE: buildParameters.androidVersionCode,
      ANDROID_KEYSTORE_NAME: buildParameters.androidKeystoreName,
      ANDROID_KEYSTORE_BASE64: buildParameters.androidKeystoreBase64,
      ANDROID_KEYSTORE_PASS: buildParameters.androidKeystorePass,
      ANDROID_KEYALIAS_NAME: buildParameters.androidKeyaliasName,
      ANDROID_KEYALIAS_PASS: buildParameters.androidKeyaliasPass,
      ANDROID_TARGET_SDK_VERSION: buildParameters.androidTargetSdkVersion,
      ANDROID_SDK_MANAGER_PARAMETERS: buildParameters.androidSdkManagerParameters,
      ANDROID_EXPORT_TYPE: buildParameters.androidExportType,
      ANDROID_SYMBOL_TYPE: buildParameters.androidSymbolType,
      CUSTOM_PARAMETERS: buildParameters.customParameters,
      CHOWN_FILES_TO: buildParameters.chownFilesTo,
      GIT_PRIVATE_TOKEN: buildParameters.gitPrivateToken,
    };

    return await exec('bash', [`${actionFolder}/platforms/mac/entrypoint.sh`], {
      silent,
      ignoreReturnCode: true,
      env: { ...process.env, ...environmentVariables }, // Merge existing environment variables with new ones
    });
  }
}

export default MacBuilder;

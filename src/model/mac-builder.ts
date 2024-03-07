import { exec } from '@actions/exec';
import BuildParameters from './build-parameters';

class MacBuilder {
  public static async run(
    actionFolder: string,
    buildParameters: BuildParameters,
    silent: boolean = false,
  ): Promise<number> {
    return await exec('bash', [`${actionFolder}/platforms/mac/entrypoint.sh`], {
      silent,
      ignoreReturnCode: true,
      env: { GIT_PRIVATE_KEY: buildParameters.gitPrivateKey },
    });
  }
}

export default MacBuilder;

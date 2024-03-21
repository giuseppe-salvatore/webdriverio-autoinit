import type { Options } from "@wdio/types";
import { globalConfig } from "./wdio.conf.base";

globalConfig.capabilities = [{
    maxInstances: 5,
    browserName: "MicrosoftEdge",
}];

export const config: Options.Testrunner = globalConfig;
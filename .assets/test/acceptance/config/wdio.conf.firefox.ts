import type { Options } from "@wdio/types";
import { globalConfig } from "./wdio.conf.local";

globalConfig.capabilities = [{
    maxInstances: 5,
    browserName: "firefox",
}];

export const config: Options.Testrunner = globalConfig;
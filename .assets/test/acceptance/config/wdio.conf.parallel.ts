import type { Options } from "@wdio/types";
import { globalConfig } from "./wdio.conf.local";

globalConfig.capabilities = [{
    maxInstances: 5,
    browserName: "firefox",
    browserVersion: "latest"
}, {
    maxInstances: 5,
    browserName: "MicrosoftEdge",
    browserVersion: "stable"
}, {
    maxInstances: 5,
    browserName: "chrome",
    browserVersion: "stable"
},];

export const config: Options.Testrunner = globalConfig;
import type { Options } from "@wdio/types";
import { globalConfig } from "./wdio.conf.base";

<<<<<<< HEAD
const RUNTIME_ENV: string = process.env.RUNTIME_ENV || "CI";

const chromeStable: Record<string, any> = {
    maxInstances: 5,
    browserName: "chrome",
    browserVersion: "stable",
};


if (RUNTIME_ENV == "CI") {
    chromeStable["goog:chromeOptions"] = {
        args: ["--no-sandbox", "--disable-dev-shm-usage", "--headless"],
    };
    chromeStable.maxInstances = 1;
}

globalConfig.capabilities = [chromeStable];
=======
globalConfig.capabilities = [{
    maxInstances: 5,
    browserName: "chrome",
    browserVersion: "stable"
}];
>>>>>>> b97517c ([PASS] Tested the project with 8.39.0)

export const config: Options.Testrunner = globalConfig;
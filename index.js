#!/usr/bin/env node

import { getDisksInfo } from "./diskutil.js";
import { applyFilters, printTable, outputJSON, outputCSV } from "./utils.js";
import yargs from "yargs";
import { hideBin } from "yargs/helpers";

const argv = yargs(hideBin(process.argv))
  .option("json", { type: "boolean", desc: "Output as JSON" })
  .option("csv", { type: "boolean", desc: "Output as CSV" })
  .option("filter", { type: "string", desc: 'Filter e.g. "usedPercent > 80"' })
  .option("sort", { type: "string", desc: 'Sort by field, e.g. "free"' }).argv;

const disks = await getDisksInfo();
const filtered = applyFilters(disks, argv.filter);
if (argv.sort) {
  filtered.sort((a, b) => b[argv.sort] - a[argv.sort]);
}

if (argv.json) outputJSON(filtered);
else if (argv.csv) outputCSV(filtered);
else printTable(filtered);

/*dysk-mac
dysk-mac --json
dysk-mac --filter "usedPercent > 70"
dysk-mac --sort free
dysk-mac --csv
*/

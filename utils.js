import Table from "cli-table3";
import fs from "fs";

export function applyFilters(disks, expr) {
  if (!expr) return disks;
  const fn = new Function("disk", `return ${expr}`);
  return disks.filter(fn);
}

export function printTable(disks) {
  const table = new Table({
    head: [
      "Disk",
      "Mount",
      "Size (GB)",
      "Used (GB)",
      "Used %",
      "Free (GB)",
      "Type",
      "External",
    ],
  });
  disks.forEach((d) => {
    table.push([
      d.filesystem,
      d.mount,
      (d.size / (1024 * 1024 * 1024)).toFixed(1),
      (d.used / (1024 * 1024 * 1024)).toFixed(1),
      d.usedPercent + "%",
      (d.free / (1024 * 1024 * 1024)).toFixed(1),
      d.type,
      d.external ? "Yes" : "No",
    ]);
  });
  console.log(table.toString());
}

export function outputJSON(disks) {
  console.log(JSON.stringify(disks, null, 2));
}

export function outputCSV(disks) {
  const headers = Object.keys(disks[0]);
  const rows = disks.map((d) => headers.map((h) => d[h]));
  console.log([headers, ...rows].map((row) => row.join(",")).join("\n"));
}

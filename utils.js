import Table from "cli-table3";
import fs from "fs";

export function applyFilters(disks, expr) {
  if (!expr) return disks;
  const fn = new Function("disk", `return ${expr}`);
  return disks.filter(fn);
}

export function printTable(disks) {
  console.log("\n🚀 dysk-mac - macOS Disk Utility\n");

  const table = new Table({
    head: [
      "💾 Disk",
      "📁 Mount",
      "📊 Size (GB)",
      "💻 Used (GB)",
      "📈 Used %",
      "💚 Free (GB)",
      "⚡ Type",
      "🔌 External",
    ],
  });
  disks.forEach((d) => {
    // Choose emoji based on disk type and usage
    const typeEmoji = d.type === "SSD" ? "⚡" : "💿";
    const externalEmoji = d.external ? "🔌" : "🖥️";

    // Add warning emoji for high usage
    const usageWarning = d.usedPercent > 80 ? "⚠️ " : "";
    const usageEmoji =
      d.usedPercent > 90 ? "🚨" : d.usedPercent > 70 ? "⚠️" : "✅";

    table.push([
      d.filesystem,
      d.mount,
      (d.size / (1024 * 1024 * 1024)).toFixed(1),
      (d.used / (1024 * 1024 * 1024)).toFixed(1),
      `${usageEmoji} ${d.usedPercent}%`,
      (d.free / (1024 * 1024 * 1024)).toFixed(1),
      `${typeEmoji} ${d.type}`,
      `${externalEmoji} ${d.external ? "Yes" : " No"}`,
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

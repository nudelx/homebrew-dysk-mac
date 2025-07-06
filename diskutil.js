import { execSync } from "child_process";

export function getDisksInfo() {
  const df = execSync("df -k").toString();
  const lines = df.split("\n").slice(1).filter(Boolean);

  return lines
    .map((line) => {
      const parts = line.replace(/\s+/g, " ").split(" ");
      // Skip lines that don't have enough parts or are special filesystems
      if (parts.length < 6 || parts[0] === "map" || parts[0] === "devfs") {
        return null;
      }

      const filesystem = parts[0];
      const blocks = parseInt(parts[1]);
      const used = parseInt(parts[2]);
      const available = parseInt(parts[3]);
      const usePercent = parts[4];
      const mount = parts[parts.length - 1]; // Mount point is the last element

      const percent = parseInt(usePercent.replace("%", ""), 10);
      const deviceInfo = getDiskType(filesystem);

      return {
        filesystem,
        size: blocks * 1024, // Convert 1024-byte blocks to bytes
        used: used * 1024, // Convert 1024-byte blocks to bytes
        free: available * 1024, // Convert 1024-byte blocks to bytes
        usedPercent: percent,
        mount,
        ...deviceInfo,
      };
    })
    .filter(Boolean); // Remove null entries
}

function getDiskType(device) {
  try {
    const info = execSync(`diskutil info ${device}`).toString();
    return {
      type: /Solid State: Yes/.test(info) ? "SSD" : "HDD",
      removable: /Removable Media: Yes/.test(info),
      external: /External: Yes/.test(info),
    };
  } catch {
    return { type: "Unknown", removable: false, external: false };
  }
}

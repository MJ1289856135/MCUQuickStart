"""SDK manager: persist SDK paths, find and copy library files from SDK."""
import json
from pathlib import Path

CONFIG_FILE = Path.home() / ".mcu_template_config.json"


class SDKManager:
    def __init__(self):
        self._paths: dict[str, str] = {}

    def load_config(self):
        """Load saved SDK paths from config file."""
        if CONFIG_FILE.exists():
            self._paths = json.loads(CONFIG_FILE.read_text(encoding="utf-8"))

    def save_config(self):
        """Save current SDK paths to config file."""
        CONFIG_FILE.write_text(json.dumps(self._paths, indent=2, ensure_ascii=False), encoding="utf-8")

    def set_path(self, vendor: str, path: str):
        """Set SDK root path for a vendor."""
        self._paths[vendor] = path
        self.save_config()

    def get_path(self, vendor: str) -> str:
        """Get SDK root path for a vendor."""
        return self._paths.get(vendor, "")

    def find_file(self, sdk_root: Path, relative_path: str) -> Path | None:
        """Search for a file by relative path. Returns None if not found."""
        target = sdk_root / relative_path
        if target.exists():
            return target
        # Fallback: recursive search by filename
        filename = Path(relative_path).name
        matches = list(sdk_root.rglob(filename))
        return matches[0] if matches else None

    def copy_firmware(self, sdk_root: Path, chip_config: dict, dest_dir: Path):
        """Copy firmware library files from SDK to project destination."""
        cmsis = chip_config["cmsis"]
        sdk_base = Path(sdk_root)

        # Copy CMSIS core headers
        for header in cmsis["core_headers"]:
            src = self.find_file(sdk_base, header)
            if src:
                dest = dest_dir / "CMSIS" / header
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(src.read_bytes())

        # Copy system source and device headers
        device_path = cmsis["device_path"]
        system_file = cmsis["system_source"]
        system_src = self.find_file(sdk_base, f"{device_path}/Source/{system_file}")
        if system_src:
            dest = dest_dir / "CMSIS" / device_path / "Source" / system_file
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_bytes(system_src.read_bytes())

        # Copy startup file(s)
        startup_path = cmsis["startup_path"]
        startup_dir = dest_dir / "CMSIS" / startup_path
        startup_dir.mkdir(parents=True, exist_ok=True)

        sdk_startup = sdk_base / startup_path
        if sdk_startup.exists():
            for s_file in sdk_startup.glob("*.s"):
                dest = startup_dir / s_file.name
                dest.write_bytes(s_file.read_bytes())

        # Copy firmware include files
        fw_include = cmsis["firmware_include"]
        sdk_fw_inc = sdk_base / fw_include
        dest_fw_inc = dest_dir / "FIRMWARE" / "Include"
        dest_fw_inc.mkdir(parents=True, exist_ok=True)
        if sdk_fw_inc.exists():
            for h_file in sdk_fw_inc.glob("*.h"):
                (dest_fw_inc / h_file.name).write_bytes(h_file.read_bytes())

        # Copy firmware source files
        fw_source = cmsis["firmware_source"]
        sdk_fw_src = sdk_base / fw_source
        dest_fw_src = dest_dir / "FIRMWARE" / "Source"
        dest_fw_src.mkdir(parents=True, exist_ok=True)
        if sdk_fw_src.exists():
            for c_file in sdk_fw_src.glob("*.c"):
                (dest_fw_src / c_file.name).write_bytes(c_file.read_bytes())

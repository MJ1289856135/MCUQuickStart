# Contributing to MCUQuickStart

Thanks for your interest! Adding a new MCU only requires writing a JSON config — no Python knowledge needed.

## Quick Start

### Add a chip to an existing family

If your chip belongs to a supported family (e.g., STM32F103ZET6), just add an entry under `chips` in the corresponding JSON:

```json
"STM32F103ZGT6": {
  "device": "STM32F103ZG",
  "define": "STM32F10X_HD",
  "ram_kb": 96,
  "flash_kb": 1024,
  "startup": "startup_stm32f10x_hd.s",
  "flash_driver": "STM32F10x_1024"
}
```

### Add a new chip family

To support a new MCU family (e.g., nRF52, ESP32, CH32):

1. Prepare the SDK firmware library
2. Create code templates (`main.c` + `uvprojx` template)
3. Write the chip JSON config
4. If FreeRTOS is needed, prepare `it.c` / `main.h` templates

See the JSON format spec below.

## JSON Format

### Family-level config

```json
{
  "FamilyName": {
    "family": "Chip family identifier",
    "core": "Cortex-M3, M4, M0, M7, or M33",
    "vendor": "Vendor name",
    "sdk_key": "SDK_ROOT",
    "sdk_subdir": "Subdirectory name prefix under SDK root",

    "pack_id": "Keil DFP Pack ID",
    "device_header": "Top-level device header (e.g., stm32f10x.h)",
    "conf_header": "Peripheral config header (e.g., stm32f10x_conf.h)",
    "debug_usart": "Default debug UART (e.g., USART1)",

    "cmsis": {
      "core_headers": ["core_cm3.h"],
      "device_path": "CMSIS Device support path",
      "system_source": "system_xxx.c",
      "startup_path": "Startup files directory",
      "firmware_include": "Firmware library headers directory",
      "firmware_source": "Firmware library sources directory",
      "template_dir": "Keil project template directory"
    },

    "config": {
      "ram_start": "0x20000000",
      "rom_start": "0x08000000",
      "cpu_type": "Cortex-M3",
      "hxtal_hz": 8000000,
      "sim_dll": "SARMCM3.DLL",
      "target_dll": "SARMCM3.DLL",
      "sim_dlg_dll": "DCM.DLL",
      "target_dlg_dll": "TCM.DLL",
      "dlg_arguments": "-pCM3"
    },

    "chips": { /* See chip-level config below */ },
    "optional_libs": { /* FreeRTOS config, optional */ },
    "fwlib_exclude": { /* Incompatible files to exclude */ }
  }
}
```

### Field reference

| Field | Required | Description |
|-------|:------:|-------------|
| `family` | Yes | Family identifier, e.g., STM32F10x |
| `core` | Yes | Core type: Cortex-M3 / M4 / M0 / M7 / M33 |
| `vendor` | Yes | Manufacturer name |
| `sdk_subdir` | Yes | Subdirectory prefix under SDK root |
| `pack_id` | Yes | Keil DFP Pack ID (find in Keil Pack Installer) |
| `device_header` | Yes | Top-level header file |
| `conf_header` | Yes | Peripheral config header |
| `cmsis.device_path` | Yes | CMSIS device support path |
| `cmsis.startup_path` | Yes | Startup files directory |
| `cmsis.firmware_include` | Yes | Firmware library inc directory |
| `cmsis.firmware_source` | Yes | Firmware library src directory |
| `config.ram/rom_start` | Yes | RAM/ROM base address (see datasheet) |
| `config.cpu_type` | Yes | Keil CPU type |
| `config.sim/target_dll` | Yes | Keil debug DLL (core-specific) |
| `config.hxtal_hz` | Yes | Default external crystal frequency |
| `fwlib_exclude` | No | Incompatible source files (chip-specific) |
| `optional_libs.freertos` | No | FreeRTOS configuration |
| `common_skip` | No | Files to skip for all chips in this family |

### Chip-level config

```json
"STM32F103C8T6": {
  "device": "STM32F103C8",       // Keil device name
  "define": "STM32F10X_MD",      // Preprocessor define
  "ram_kb": 20,                   // RAM size in KB
  "flash_kb": 64,                 // Flash size in KB
  "startup": "startup_xxx.s",    // Startup filename
  "flash_driver": "STM32F10x_64" // Keil flash programming algorithm
}
```

### Where to find the data

| Parameter | Source |
|-----------|--------|
| RAM/Flash size | Chip datasheet → Memory Map |
| RAM/ROM base address | Same as above |
| Keil Pack ID | Keil → Pack Installer → search chip family |
| Flash Driver name | Keil → Options → Debug → Flash Download list |
| Device name | Keil → Options → Device list |
| Startup filename | Actual filename in SDK startup directory |
| Define macro | `#ifdef` conditions in SDK startup/system headers |

## Templates

New families need these template files under `src/resources/templates/<family>/`:

```
<family>/
├── empty/main.c          # Minimal main()
├── led/main.c            # GPIO LED blink
├── uart/main.c           # USART printf redirect
├── uvprojx_template.xml  # Keil project template
├── freertos/             # FreeRTOS variants (optional)
│   ├── empty/main.c
│   ├── led/main.c
│   └── uart/main.c
```

## Submitting a PR

1. Fork this repository
2. Create a branch: `git checkout -b add-chip-xxx`
3. Add chip JSON + template files
4. Test locally: `python main.py`, verify the project builds in Keil
5. Submit a PR describing the chip(s) you added
6. Wait for review

## Test Requirements

Your PR must include:
- Chip model and family
- SDK version used for testing
- Screenshot or log showing Keil build passes
- If FreeRTOS: confirm FreeRTOS project also builds

## Questions?

Open an issue on GitHub.

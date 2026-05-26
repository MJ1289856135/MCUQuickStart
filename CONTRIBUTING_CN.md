# 贡献指南

感谢你对 MCUQuickStart 的关注！贡献一个新芯片型号只需编写一个 JSON 配置，不需要懂 Python。

## 快速贡献方式

### 新增芯片（最简单）

如果你用的芯片已经在支持系列中（如 STM32F103ZET6），只需在对应 JSON 的 `chips` 下添加条目：

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

### 新增芯片系列（进阶）

要支持全新 MCU 系列（如 nRF52、ESP32），需要：

1. 准备 SDK 固件库
2. 制作代码模板（main.c + uvprojx 模板）
3. 编写芯片 JSON 配置
4. 如需 FreeRTOS 支持，准备 it.c / main.h 模板

详见下方 JSON 格式规范。

## JSON 配置格式

### 系列级配置

```json
{
  "系列名": {
    "family": "芯片家族名",
    "core": "Cortex-M3 或 Cortex-M4 等",
    "vendor": "厂商名",
    "sdk_key": "SDK_ROOT",
    "sdk_subdir": "SDK 根目录下的文件夹名前缀",

    "pack_id": "Keil DFP Pack ID",
    "device_header": "顶层器件头文件 (如 stm32f10x.h)",
    "conf_header": "外设配置头文件 (如 stm32f10x_conf.h)",
    "debug_usart": "默认调试串口 (如 USART1)",

    "cmsis": {
      "core_headers": ["core_cm3.h"],
      "device_path": "CMSIS Device 支持文件路径",
      "system_source": "system_xxx.c",
      "startup_path": "启动文件所在目录",
      "firmware_include": "固件库头文件目录",
      "firmware_source": "固件库源文件目录",
      "template_dir": "Keil 工程模板目录"
    },

    "config": {
      "ram_start": "0x20000000",
      "rom_start": "0x08000000",
      "cpu_type": "Cortex-M3",
      "clock": "8000000",
      "hxtal_hz": 8000000,
      "sim_dll": "SARMCM3.DLL",
      "target_dll": "SARMCM3.DLL",
      "sim_dlg_dll": "DCM.DLL",
      "target_dlg_dll": "TCM.DLL",
      "dlg_arguments": "-pCM3"
    },

    "chips": { /* 见下方 chips 格式 */ },

    "optional_libs": { /* FREERTOS 可选 */ },
    "fwlib_exclude": { /* 排除不兼容文件 */ }
  }
}
```

### 字段速查

| 字段 | 必填 | 说明 |
|------|:---:|------|
| `family` | 是 | 系列标识，如 STM32F10x |
| `core` | 是 | 内核类型，Cortex-M3 / M4 / M0 / M7 / M33 |
| `vendor` | 是 | 厂商名称 |
| `sdk_subdir` | 是 | SDK 根目录下子文件夹前缀 |
| `pack_id` | 是 | Keil DFP Pack ID（Keil Pack Installer 中可查） |
| `device_header` | 是 | 顶层头文件 |
| `conf_header` | 是 | 外设配置头文件 |
| `cmsis.device_path` | 是 | CMSIS 器件支持路径 |
| `cmsis.startup_path` | 是 | 启动文件目录 |
| `cmsis.firmware_include` | 是 | 固件库 inc 目录 |
| `cmsis.firmware_source` | 是 | 固件库 src 目录 |
| `config.ram/rom_start` | 是 | RAM/ROM 起始地址（数据手册可查） |
| `config.cpu_type` | 是 | 对应 Keil CPU 类型 |
| `config.sim/target_dll` | 是 | Keil 调试 DLL（和 core 相关） |
| `config.hxtal_hz` | 是 | 外部晶振默认频率 |
| `fwlib_exclude` | 否 | 不兼容的源文件列表（芯片特定） |
| `optional_libs.freertos` | 否 | FreeRTOS 配置 |
| `common_skip` | 否 | 所有芯片跳过的文件 |

### 芯片级配置 (chips)

```json
"STM32F103C8T6": {
  "device": "STM32F103C8",       // Keil 器件名
  "define": "STM32F10X_MD",      // 预处理器宏
  "ram_kb": 20,                   // RAM 大小 (KB)
  "flash_kb": 64,                 // Flash 大小 (KB)
  "startup": "startup_xxx.s",    // 启动文件名
  "flash_driver": "STM32F10x_64" // Keil Flash 烧录算法
}
```

### 关键数据来源

| 参数 | 在哪查 |
|------|--------|
| RAM/Flash 大小 | 芯片数据手册 Memory Map 章节 |
| RAM/ROM 起始地址 | 同上 |
| Keil Pack ID | Keil → Pack Installer → 搜索芯片系列 |
| Flash Driver 名称 | Keil → Options → Debug → Flash Download 列表 |
| device 名称 | Keil → Options → Device 列表中的器件名 |
| startup 文件名 | SDK 中 startup 目录下的实际文件名 |
| define 宏 | SDK 中 startup 文件或 system 头文件的 `#ifdef` 条件 |

## 代码模板

新增系列需要提供以下模板文件（放在 `src/resources/templates/<系列名>/`）：

```
<系列名>/
├── empty/main.c          # 最简 main()
├── led/main.c            # GPIO LED 闪烁
├── uart/main.c           # USART printf 重定向
├── uvprojx_template.xml  # Keil 工程模板
├── freertos/             # FreeRTOS 版（可选）
│   ├── empty/main.c
│   ├── led/main.c
│   └── uart/main.c
```

## 提交流程

1. Fork 本仓库
2. 创建分支：`git checkout -b add-chip-xxx`
3. 添加芯片 JSON + 模板文件
4. 在本地测试：`python main.py`，确认工程能生成且 Keil 编译通过
5. 提交 PR，描述新增了什么芯片
6. 等待 Review

## 测试要求

PR 必须附带：
- 芯片型号和系列
- 测试用的 SDK 版本
- Keil 编译通过的截图或日志
- 如有 FreeRTOS：确认 FreeRTOS 工程也编译通过

## 问题

如有疑问，请在 GitHub Issues 中提出。

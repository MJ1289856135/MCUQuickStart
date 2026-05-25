# MCUQuickStart v1.2.0

## 新功能

### GCC + CMake 双构建支持
- 勾选"GCC + CMake"后额外生成 `CMakeLists.txt` + `.ld` 链接脚本 + GCC 启动文件
- 生成的同一项目同时兼容 Keil MDK（ARMCC）和 CLion/VS Code（GCC）
- 默认仅生成 Keil 工程，不勾选 GCC 则行为与 v1.1.0 完全一致
- 4 系列 37 型号全支持，全部通过 GCC 和 Keil 双编译器测试

### 链接脚本分 GD32/STM32 两套
- GD32：`.vectors` 段 + `__gVectors` 向量符号
- STM32：`.isr_vector` 段 + `g_pfnVectors` / `_estack`（参照 CubeIDE 官方格式）
- Cortex-M4 自动加 TCMRAM 段（64KB @ 0x10000000）

### GCC 启动文件智能获取
- SDK 自带 GCC 目录 → 直接复用
- SDK 无 GCC → 搜索 `GD32EmbeddedBuilder` 插件目录
- 都找不到 → 区分 GD32/STM32 提示官方下载地址，工具不打包启动文件

## 改进

- **CMSIS 兼容修复**：`delay.h` 补 `DWT_Type` 兼容定义（STM32F10x 老 CMSIS 缺此结构体）
- **三编译器通用 MSR_MSP**：`sysconfig.c` 中 `__set_MSP` 自动适配 ARMCC / GCC / IAR
- **FreeRTOS heap 缩减**：`configTOTAL_HEAP_SIZE` 从 15KB 降至 5KB，适配小 RAM 芯片
- **SDK 源文件警告全压制**：CMSIS / FIRMWARE 头文件标记为 `SYSTEM` include，用户代码保持 `-Wall`
- **模板文件双编译器兼容**：`retarget_printf.c` semihosting pragma 加 `#ifndef __GNUC__` 守卫
- **UI 风格重做**：Fusion 主题 + QSS 白底卡片圆角 + 等宽日志字体

## 支持范围

| 系列 | 型号数 | Keil | GCC |
|------|--------|------|-----|
| STM32F10x | 9 | ✓ | ✓ |
| STM32F4xx | 6 | ✓ | ✓ |
| GD32F10x | 8 | ✓ | ✓ |
| GD32F4xx | 14 | ✓ | ✓ |
| **合计** | **37** | | |

## 使用方法

1. 下载 `MCUQuickStart.exe`
2. 准备 SDK：将所有芯片固件包和 FreeRTOS 源码放在同一目录
3. 运行 exe，设置 SDK 根目录，选择芯片/模板/可选库，勾选需要的选项
4. Keil MDK 打开 `MDK-ARM/<项目名>.uvprojx`，CLion/VS Code 打开 `CMakeLists.txt` 即可编译
5. CLion 用户需安装 arm-none-eabi-gcc 工具链

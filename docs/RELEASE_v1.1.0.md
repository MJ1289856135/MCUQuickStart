# MCUQuickStart v1.1.0

## 新功能

### FreeRTOS 可选库
- 勾选即可生成带 FreeRTOS 的工程模板，4 系列（STM32F1/F4、GD32F1/F4）全支持
- 自动拷贝内核源码 + 对应 Cortex-M3/M4 的 RVDS 端口 + heap_4 内存管理
- FreeRTOS 模式使用 DWT 周期计数器做 us 延迟，不占用 SysTick
- SysTick_Handler 共享模式：调度器启动后自动转发到 xPortSysTickHandler

### 外部晶振配置
- 工程设置新增外部晶振下拉框（8 MHz / 25 MHz）
- 自动修正系统时钟配置：GD32F4xx 的 PLL 宏、STM32F4xx 的 PLL_M、编译器 HSE/HXTAL 宏
- GUI 选什么，生成的代码就配什么，无需手动改

### 使用说明按钮
- 顶部栏新增"使用说明"/"Help"按钮，点击弹出 6 步使用指南（中英文双语）

### 新增芯片
- GD32F4xx 新增 F470 系列 5 款：VGT6 / ZET6 / ZGT6 / ZIT6 / IIH6

## 改进

- 默认语言改为英文，中文可手动切换
- delay.c 重构为三级模式：裸机(0) / UCOS(1) / FreeRTOS(2)
- 裸机模板统一使用 SDK 官方 `systick_config()` + `delay_1ms()` 体系

## Bug 修复

- FreeRTOSConfig.h 缺少 `stdio.h` 导致 printf 警告
- delay.c 和 it.c 未 include sysconfig.h 导致宏不生效
- STM32F4xx FreeRTOS UART TX/RX 按官方样式分开配置（之前合并导致 RX 参数错误）
- STM32F4xx `PLL_M` 按晶振自动修正
- STM32F1/F4 FreeRTOS UART 模板补 `fputc` 串口重定向
- `_patch_system_clock` 遍历所有 system 文件副本（之前只修第一个）
- GD32F4xx SDK 文件编码兼容
- GD32F470 RAM 规格按 datasheet 修正

## 支持芯片

| 系列 | 型号数 |
|------|--------|
| STM32F10x | 9 |
| STM32F4xx | 6 |
| GD32F10x | 8 |
| GD32F4xx | 14（新增 F470×5） |
| **合计** | **37** |

## 使用方法

1. 下载 `MCUQuickStart.exe`
2. 准备 SDK：将所有芯片固件包和 FreeRTOS 源码放在同一目录
3. 运行 exe，设置 SDK 根目录，选择芯片/模板/可选库，生成工程
4. 用 Keil MDK 打开生成的 `.uvprojx` 即可编译

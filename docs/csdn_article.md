# 告别手动搭建Keil工程！MCUQuickStart一键生成STM32/GD32工程模板，打开即编译

## 前言

做嵌入式开发的都懂这个痛——每次换芯片、开新项目，第一件事不是写代码，而是**搭工程**。

翻SDK找固件库、拷贝启动文件、建Keil工程、配头文件路径、填预定义宏、设内存映射和Flash烧录算法……一套流程走下来，一两个小时就过去了。关键是，这些东西跟你的业务逻辑**毫无关系**，纯属重复体力劳动。

前段时间我又一次被这个流程折磨之后，干脆写了个小工具：**MCUQuickStart**，选芯片→选模板→点生成，一分钟内拿到一个打开即编译的 Keil5 工程。

今天分享给大家。

---

## 它能做什么

一句话概括：**选择芯片型号，自动生成 Keil5 工程模板，打开就能编译运行。**

![主界面截图](https://cdn.jsdelivr.net/gh/MJ1289856135/-MCUQuickStart@main/docs/screenshot_1_main_window.png)

目前支持的芯片：

| 系列 | 内核 | 厂商 | 型号数 |
|------|------|------|--------|
| STM32F10x | Cortex-M3 | ST | 9 |
| STM32F4xx | Cortex-M4 | ST | 6 |
| GD32F10x | Cortex-M3 | GigaDevice | 8 |
| GD32F4xx | Cortex-M4 | GigaDevice | 9 |

合计 **4 系列 32 款芯片**，全部验证编译通过。

三种代码模板：

- **空壳** — 最简 `main()`，干净起手
- **LED 闪烁** — GPIO 控制，验证板子硬件是否正常
- **串口打印** — USART printf 重定向，调试利器

---

## 手动搭建 vs 这个工具

| 手动操作 | MCUQuickStart |
|----------|---------------|
| 从 SDK 里翻找固件库、启动文件、CMSIS 头文件 | 自动匹配路径并拷贝 |
| 手动创建 `.uvprojx`，逐文件添加到工程 | 自动生成完整 Keil 工程 |
| 对着芯片手册查 RAM/ROM 地址、Flash 算法 | 芯片 JSON 预配置，自动填入 |
| 宏定义写错了导致编译报错，排查半天 | 每颗芯片独立的 `define`，预设验证过 |
| 换一颗芯片，上面所有步骤重来一遍 | 同一界面，下拉选个型号就行 |

![生成流程截图](https://cdn.jsdelivr.net/gh/MJ1289856135/-MCUQuickStart@main/docs/screenshot_2_generate.png)

---

## 使用方式

超级简单，不需要安装任何东西：

1. **下载** `MCUQuickStart.exe`（文末有链接）
2. **准备 SDK**：把你的芯片 SDK 包（比如 STM32F4xx_DSP_StdPeriph_Lib）放在一个目录下
3. **打开软件**：双击 exe，设置 SDK 根目录
4. **选芯片**：左侧选系列，右侧选型号
5. **选模板**：空壳 / LED / 串口打印 三选一
6. **点生成**：填项目名，选输出目录，点击 Generate Project

然后用 Keil5 打开 `MDK-ARM/项目名.uvprojx`，直接编译——一把过。

![编译成功截图](https://cdn.jsdelivr.net/gh/MJ1289856135/-MCUQuickStart@main/docs/screenshot_3_compile_ok.png)

---

## 实际场景举例

**场景一：新板子到手，想快速验证硬件**

假设你拿到一块 STM32F407VET6 的板子。传统做法是去网上找个例程改来改去，或者从 SDK 模板开始搭。现在——打开 MCUQuickStart，选 STM32F4xx → STM32F407VET6 → LED 模板 → 生成。一分钟，LED 已经闪起来了。

**场景二：对比不同芯片的外设驱动**

比如你想看看 STM32F103 和 GD32F103 的 USART 初始化有什么不同。两个工程，各点一下生成，源码直接对比。

**场景三：新人入职**

团队来了新同事，还得教他怎么搭 Keil 工程？直接把 exe 扔给他，给个 SDK 包就行了。

---

## 原理简述

工具内部是数据驱动的架构。每款芯片的参数——启动文件、Flash 驱动、内存映射、预编译宏、排除的外设文件——全部存在 JSON 配置里。模板文件用 `{{PLACEHOLDER}}` 占位符，生成时替换成实际值。

加新芯片不需要改代码，只加 JSON + 模板即可。目前已经覆盖了 STM32F1/F4 和 GD32F1/F4 四个最常用的系列。

---

## 系统要求

- Windows 10 及以上
- Keil MDK 5
- 对应的芯片 SDK 固件包

---

## 下载地址

GitHub Release：**[https://github.com/MJ1289856135/-MCUQuickStart/releases](https://github.com/MJ1289856135/-MCUQuickStart/releases)**

下载 `MCUQuickStart.exe` 直接运行，无需安装。

> 如果觉得好用，⭐ **点个 Star** 支持一下，让更多嵌入式同行看到这个工具～

---

## 总结

很多嵌入式开发的效率问题，不是技术问题，是流程问题。每次手动搭工程就是在"为工具链打工"。把这个环节自动化之后，你可以更快地进入真正的业务代码。

后续计划加更多芯片系列、更多模板类型。大家有什么需求也可以在 GitHub Issues 里提。

---

*原创文章，转载注明出处。*

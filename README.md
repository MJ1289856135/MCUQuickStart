# MCUQuickStart

嵌入式 MCU 工程模板一键生成工具。选择芯片型号，自动生成 Keil5 打开即编译的工程模板。

## 功能

- 支持 GD32F10x 系列 8 款芯片（C8T6/CBT6/RBT6/VBT6/RCT6/RET6/VCT6/VET6）
- 3 种代码模板：空壳 / LED 闪烁 / 串口打印
- 自动从 SDK 拷贝固件库、启动文件、CMSIS 头文件
- 自动生成 Keil5 .uvprojx 工程文件
- 每芯片独立内存映射和启动文件匹配
- 预留 APP / DRIVER / HARDWARE 空目录

## 安装

```bash
pip install PyQt6
```

## 使用

```bash
python main.py
```

1. 设置 GD32 SDK 路径（指向固件库根目录）
2. 选择芯片系列和型号
3. 选择代码模板
4. 点击"Generate Project"

生成后的工程用 Keil5 打开 `MDK-ARM/<项目名>.uvprojx` 即可编译。

## 目录结构

```
MCUQuickStart/
├── main.py                    # 入口
├── src/
│   ├── core/
│   │   ├── chip_db.py         # 芯片数据库
│   │   ├── sdk_manager.py     # SDK 文件管理
│   │   ├── template_engine.py # 模板替换引擎
│   │   └── project_generator.py # 工程生成器
│   ├── gui/
│   │   └── main_window.py     # PyQt6 主窗口
│   └── resources/
│       ├── chips/             # 芯片定义 JSON
│       └── templates/         # 代码和工程模板
└── requirements.txt
```

# China Legal Assistant v1.8.5

本发行版面向 TraeCode、Codex、Claude Code 和 OpenCode 用户，提供：

- 按 macOS、Linux 和 Windows 系统及 CPU 架构生成的完整平台包
- `china-legal-assistant` Skill 与 `china-legal-local` 本地程序
- 可直接使用的远程研究与本地程序双 MCP 配置
- 同时安装本地程序和四个客户端 Skill 的一个安装器
- `cnlaw_check_legal_updates` 只读法规版本检查使用说明
- 隐私说明、服务条款和安全响应政策
- 与容器化服务端 `v1.8.5` 对齐的版本标识

## 本次更新

- 服务端补齐 `podman-compose 1.0.3` 兼容、完整生产依赖和 3110 回环端口配置，
  远程 MCP 接口保持不变。
- 补充宿主机原生 Nginx 的独立站点、HTTPS、限流与长连接配置说明。
- 远程服务地址统一为 `https://legalapi.hackall.cn/mcp`。
- 更新案件理论、证据复核和工作流安全边界说明。
- 保持远程 `remote_research` 配置为 15 个只读研究、核验和确定性计算工具。
- 新增 `china-legal-local` 本地程序，以 `local_case` 配置提供 24 个本地端点；
  与远程端合计为 38 项唯一能力。
- 本地运行包内置 Node SEA、WASM OCR 和中英文语言数据，不要求用户安装
  Node.js、npm、SQLite 或 Tesseract。
- README 按“能力、安装、配置、渐进式使用”重写，默认始终安装本地程序；
  所有客户端配置均提供可直接使用的 macOS/Linux 与 Windows 默认值。
- 原始证据、案件工作区、证据包和文书导出保留在用户本机，不进入远程 MCP。
- 每个平台的单一 Release 包同时包含 Skill、配置、文档和本地程序，不再拆分
  下载或安装；所有公开交付统一采用 Apache License 2.0。
- 本地程序公开分发可执行文件，但不公开本地程序源码；平台包不包含生产语料、
  服务端源码、凭据或构建机器标识。
- 支持 macOS arm64/x64、Linux arm64/x64（glibc 或 musl）和 Windows
  arm64/x64 的原生构建目标。
- 公测状态仍为延期人工校验，不宣称已完成独立专业复核或真实部署验收。

公开 Git 仓库不包含本地程序二进制及其源码、服务端源码、生产数据库、审核
归档、备份、API Key 或私钥。平台 Release 包包含本地程序二进制。
版本检查可查询官方目录，但不会自动修改生产库；发现新版本后仍需由运营方完成
官方原文核验、具名人工复核、生产构建和发布。

远程服务地址计划为：

```text
https://legalapi.hackall.cn/mcp
```

当前阶段使用匿名访问，客户端不需要配置 API Key。实际可用状态以服务 `/ready`
和客户端运行状态检查结果为准。正式开放注册或购买后，将切换到账号对应的独立
凭据并另行发布迁移说明。

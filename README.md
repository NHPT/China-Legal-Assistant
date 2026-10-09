# China Legal Assistant

面向中国大陆法律研究、案件分析、证据整理和法律文书准备的 Agent Skill。
用户可以直接描述发生了什么，不需要先判断案由、选择案件类型或整理成固定表单。
法律助手会先梳理事实和问题，再调用远程法源服务与本地案件工具完成研究、核验和材料处理。

默认工作方式由两个 MCP 服务共同组成：

- `china-legal`：查询法规和案例、读取法条原文、核验引用、检查法规更新并完成确定性计算。
- 本地程序 `china-legal-local`：在用户电脑上读取 PDF、DOCX、图片等材料，执行 OCR，管理案件工作区、证据包和文书导出。

`china-legal-local` 是标准安装的一部分。原始文件、案件工作区、证据包和导出文书均保留在用户电脑，不上传至运营方服务器。

> **项目目标**
>
> 本项目用于帮助用户理解并解决现实中的法律、纠纷和诉讼问题，包括梳理案情、研究法律依据、核验引用、分析证据、计算金额、准备处理方案和生成法律文书。法律助手会尽可能给出具体、可执行的帮助；最终决定、签署、立案和正式提交仍应由用户本人确认，并在必要时交由具备资格的专业人员复核。
>
> **数据与隐私**
>
> `china-legal-local` 不收集或上传本地原始文件，也不建立云端案件库。远程法源服务只处理研究所必需的最小脱敏参数，不主动保存工具参数值或响应正文。使用云端模型时，模型服务商仍可能处理对话和本地工具返回的文本；提供案情前请先脱敏，不要发送身份证号、银行卡号、精确住址等非必要敏感信息。

## 当前能力

### 直接分析自然语言案情

用户只需说明当事人关系、发生的事情、手头材料和希望解决的问题。法律助手会：

1. 归纳可能涉及的法律关系和案件类型候选，不强迫用户预先选择案由。
2. 区分用户陈述、材料支持的事实、争议事实、法律推论和缺失信息。
3. 识别管辖、时效、仲裁约定、保全、送达和其他紧急事项。
4. 提出真正影响判断的补充问题。
5. 检索并打开具体法源，核验引用和效力状态。
6. 检索参考案例并说明其非约束性和可比性限制。
7. 按明确规则计算期限、金额、利息和诉讼费。
8. 形成证据目录、事实证据矩阵、待补材料清单和法律文书草案。

### 处理本地案件材料

本地程序 `china-legal-local` 支持：

| 材料或任务 | 能力 |
|---|---|
| TXT、Markdown、CSV、JSON | 提取正文和结构化记录 |
| DOCX | 提取段落和表格内容 |
| 有文字层的 PDF | 按页读取文字并保留页码来源 |
| 扫描 PDF 和常见图片 | 使用内置中英文 OCR，无需另装 OCR 环境 |
| 多份案件材料 | 生成时间线、主体关系、金额流、矛盾候选和补证问题 |
| 案件工作区 | 保存版本化事实、争点、证据引用、研究结果和流程状态 |
| 证据包 | 生成不可覆盖版本、文件哈希、清单和保管链记录 |
| 法律文书 | 校验主体、请求、金额、证据和引用后导出 Markdown 或 DOCX |

所有自动提取结果都必须对照原件复核。OCR、事实候选、矛盾候选和证据矩阵不等于
证据真实、合法、可采，也不等于法院已经认定事实。

### 38 项唯一工具能力

远程端提供 15 个研究、核验和计算工具，本地端提供 24 个案件处理端点；两端各有一个运行状态工具，因此合计为 38 项唯一能力。

| 类别 | 主要能力 |
|---|---|
| 运行与数据状态 | 检查远程语料、案例库、本地边界和审计状态 |
| 法规研究 | 来源审计、检索、精确读取、版本检查和引用核验 |
| 案例研究 | 事实要素提取、案例检索和裁判观点比较 |
| 确定性计算 | 期限、请求金额、分段利息和诉讼费 |
| 案件分析 | 信息接收、案件理论、行动就绪度和阶段工作流 |
| 本地材料 | 文件提取、OCR、批量材料分析和人工复核应用 |
| 证据与文书 | 证据包、案件工作区、文书校验和本地导出 |

## 工作方式与隐私

原始文件由 `china-legal-local` 在本机读取。远程 `china-legal` 只接收完成法源研究和计算所必需的最小脱敏事实、检索词、法条候选、日期和金额。

本地工具返回的提取文本会进入 MCP 客户端上下文。如果 TraeCode、Codex、Claude Code 或 OpenCode 使用云端模型，模型服务商仍可能处理这些文本。请同时检查所用客户端和模型服务商的隐私设置，不要把“原始文件未上传到运营方服务”理解为“所有提取文本永远不会离开本机”。

远程应用审计和用量日志记录工具名称、参数字段名、时间、耗时和结果状态，不记录工具参数值或响应正文；常规日志保存 30 天。

## 安装

每个版本按系统和 CPU 架构提供一个完整安装包。每个包同时包含：

- `china-legal-assistant` Skill
- macOS、Linux 或 Windows 对应的 `china-legal-local` 本地程序
- 远程与本地双 MCP 默认配置
- 使用文档、隐私政策、服务条款和 Apache License 2.0
- 同时安装 Skill 和本地程序的一个安装器

本地程序已内置运行时、中英文 OCR 引擎和语言数据。用户无需安装 Node.js、npm、SQLite、Tesseract 或其他开发环境，也不需要分别下载或安装 Skill。

选择与设备匹配的附件：

| 系统 | CPU / 运行库 | 附件目标名 |
|---|---|---|
| macOS | Apple 芯片 | `darwin-arm64` |
| macOS | Intel | `darwin-x64` |
| Linux | x64 glibc | `linux-x64-gnu` |
| Linux | ARM64 glibc | `linux-arm64-gnu` |
| Windows | x64 | `win32-x64` |
| Windows | ARM64 | `win32-arm64` |

### macOS 和 Linux

下载对应的 `.tar.gz`，解压并运行一次安装器：

```bash
tar -xzf china-legal-assistant-v1.8.5-<目标名>.tar.gz
cd china-legal-assistant-v1.8.5-<目标名>
./install.sh
```

安装器会安装版本化本地程序、创建以下稳定命令，并同时把 Skill 安装到 TraeCode、Codex、Claude Code 和 OpenCode 的用户级目录：

```text
$HOME/.local/bin/china-legal-local
```

未安装的客户端不会受影响。macOS 包目前使用 ad-hoc 签名，尚未进行 Apple Developer ID 签名和公证；系统首次拦截时，应只对从本项目正式 Release 下载并核对来源的程序手动允许运行。

### Windows

下载对应的 `.zip`，在 PowerShell 中解压并运行一次安装器：

```powershell
Expand-Archive .\china-legal-assistant-v1.8.5-<目标名>.zip
Set-Location .\china-legal-assistant-v1.8.5-<目标名>
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

安装器会安装本地程序、创建以下稳定启动器，并同时安装四个客户端的 Skill：

```text
%LOCALAPPDATA%\ChinaLegalAssistant\bin\china-legal-local.cmd
```

完整平台包中的项目文件和 `china-legal-local` 可执行文件统一按 Apache License 2.0 公开分发。本地程序源码、服务端源码和生产数据不随包提供。

## 配置

以下配置均可直接复制使用，不需要替换路径、创建数据目录或填写 API Key。
本地程序会在当前案件项目中自动创建：

```text
.china-legal/
├── evidence/           放置需要读取或 OCR 的案件材料
├── evidence-packages/  版本化证据包
├── document-exports/   导出的 Markdown 或 DOCX
├── case-workspaces/    本地案件工作区
└── runtime/            本地审计日志
```

### TraeCode

打开 **设置 > MCP > 添加 > 手动添加**。macOS 和 Linux 粘贴 `managed-mcp.generic.json` 的内容：

```json
{
  "mcpServers": {
    "china-legal": {
      "url": "https://legalapi.hackall.cn/mcp"
    },
    "china-legal-local": {
      "command": "/bin/sh",
      "args": [
        "-c",
        "exec \"$HOME/.local/bin/china-legal-local\""
      ]
    }
  }
}
```

Windows 粘贴 `managed-mcp.windows.json` 的内容：

```json
{
  "mcpServers": {
    "china-legal": {
      "transport": "streamable-http",
      "url": "https://legalapi.hackall.cn/mcp"
    },
    "china-legal-local": {
      "command": "cmd.exe",
      "args": [
        "/d",
        "/s",
        "/c",
        "\"%LOCALAPPDATA%\\ChinaLegalAssistant\\bin\\china-legal-local.cmd\""
      ]
    }
  }
}
```

确认两个 MCP 均已启用，然后完全重启 TraeCode。

### Codex

所有系统先添加远程服务：

```bash
codex mcp add china-legal \
  --url https://legalapi.hackall.cn/mcp
```

在 Codex 用户配置中加入：

```toml
[mcp_servers.china-legal-local]
command = "/bin/sh"
args = ["-c", "exec \"$HOME/.local/bin/china-legal-local\""]
startup_timeout_sec = 20
tool_timeout_sec = 120
```

Windows 的本地配置改为：

```toml
[mcp_servers.china-legal-local]
command = "cmd.exe"
args = ["/d", "/s", "/c", "\"%LOCALAPPDATA%\\ChinaLegalAssistant\\bin\\china-legal-local.cmd\""]
startup_timeout_sec = 20
tool_timeout_sec = 120
```

运行 `codex mcp list`，确认 `china-legal` 和 `china-legal-local` 均存在。

### Claude Code

macOS 和 Linux：

```bash
claude mcp add --transport http --scope user \
  china-legal https://legalapi.hackall.cn/mcp

claude mcp add --transport stdio --scope user \
  china-legal-local -- /bin/sh -c \
  'exec "$HOME/.local/bin/china-legal-local"'
```

Windows PowerShell：

```powershell
claude mcp add --transport http --scope user `
  china-legal https://legalapi.hackall.cn/mcp

claude mcp add --transport stdio --scope user `
  china-legal-local -- cmd.exe /d /s /c `
  '"%LOCALAPPDATA%\ChinaLegalAssistant\bin\china-legal-local.cmd"'
```

运行以下命令确认连接：

```bash
claude mcp get china-legal
claude mcp get china-legal-local
```

### OpenCode

macOS 和 Linux 在用户配置中加入：

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "china-legal": {
      "type": "remote",
      "url": "https://legalapi.hackall.cn/mcp",
      "enabled": true
    },
    "china-legal-local": {
      "type": "local",
      "command": [
        "/bin/sh",
        "-c",
        "exec \"$HOME/.local/bin/china-legal-local\""
      ],
      "enabled": true
    }
  }
}
```

Windows 使用：

```json
{
  "$schema": "https://opencode.ai/config.json",
  "mcp": {
    "china-legal": {
      "type": "remote",
      "url": "https://legalapi.hackall.cn/mcp",
      "enabled": true
    },
    "china-legal-local": {
      "type": "local",
      "command": [
        "cmd.exe",
        "/d",
        "/s",
        "/c",
        "\"%LOCALAPPDATA%\\ChinaLegalAssistant\\bin\\china-legal-local.cmd\""
      ],
      "enabled": true
    }
  }
}
```

运行 `opencode mcp list`，确认两个服务均已启用。

### 验证安装

在客户端中输入：

```text
请使用 china-legal-assistant：
1. 在 china-legal 调用 cnlaw_runtime_status 和 cnlaw_system_status；
2. 在 china-legal-local 调用 cnlaw_runtime_status；
3. 只报告两个服务的版本、tool_profile、数据状态、本地目录和 OCR 引擎，不读取任何案件文件。
```

应确认：

- 两端版本与平台包版本一致。
- 远程 `tool_profile` 为 `remote_research`。
- 本地 `tool_profile` 为 `local_case`。
- 远程法规库和案例库均为生产状态。
- 本地四类存储边界均已配置。
- 本地 `ocr_engine` 为 `embedded_wasm`。

### 修改默认目录

只有确实需要改变默认位置时，才在本地 MCP 配置中增加 `env`：

```json
{
  "CNLAW_LOCAL_DATA_ROOT": "./case-data",
  "CNLAW_EVIDENCE_ROOTS": "./evidence"
}
```

`CNLAW_EVIDENCE_ROOTS` 可以使用逗号分隔多个目录。不要把整个用户目录或磁盘根目录加入证据白名单。

## 使用

### 第一步：直接描述发生了什么

不需要先研究法律术语，也不需要按固定模板填写。可以直接说：

```text
请使用 china-legal-assistant 分析下面的情况。

我不确定这属于什么案件。张三（化名）在 2025 年 3 月向李四（化名）购买一项服务并支付了 20,000 元。对方一直没有完成主要服务。我在 4 月 15 日和 5 月
2 日催过两次，对方仍未履行，也没有退款。我有合同、付款记录和完整聊天记录。我希望退回已付款，并了解能否主张利息、需要准备什么材料以及应向哪里处理。
```

法律助手应先完成：

1. 用普通语言复述核心事实，指出哪些只是用户陈述。
2. 归纳可能的法律关系和案件类型候选，并说明不确定点。
3. 识别争议焦点、紧急期限和程序风险。
4. 只追问真正影响判断的事实。
5. 在事实足够后检索法源、打开原文、核验引用并查找参考案例。
6. 给出可执行的材料准备顺序，而不是直接声称案件一定胜诉。

### 第二步：处理隐私和脱敏

正式提供材料前，先在本地建立替换表，替换表本身不要发送：

| 真实信息 | 对话中使用 |
|---|---|
| 姓名 | `张三（化名）`、`李四（化名）`，或 `A`、`B` |
| 身份证号、统一社会信用代码 | `[身份信息待本地补充]` |
| 详细地址和联系方式 | `[送达信息待本地补充]` |
| 合同编号 | `合同C-01` |
| 银行账号 | `[收款账户已隐去]` |
| 证据文件 | `E-001`、`E-002` |

不要向远程服务发送身份证号、银行卡号、精确住址、未成年人姓名、账号密码、无关第三方个人信息或依法不得公开的信息。

### 第三步：需要时再结构化提问

事实较多时，可以按以下顺序补充：

```text
当事人关系：
张三（化名）向李四（化名）购买服务。

事件时间线：
- 2025-03-01：签订合同C-01。
- 2025-03-03：支付20,000元。
- 2025-04-15、2025-05-02：两次书面催告。

现有材料：
- E-001：合同。
- E-002：付款记录。
- E-003：完整催告聊天记录。

希望解决：
退款、逾期损失、处理渠道和材料清单。

请区分已获材料支持的事实、只有本人陈述的事实、争议事实和待确认事项，再进行法源与案例研究。
```

结构化信息是为了减少遗漏，不是使用法律助手的前置条件。

### 第四步：让助手读取本地材料

把需要处理的文件放入当前案件项目的：

```text
.china-legal/evidence/
```

然后输入：

```text
请使用 china-legal-local 分析 .china-legal/evidence/ 中的案件材料：
1. 提取文字、表格和页码来源；
2. 建立按日期排序的事件时间线；
3. 标记主体、金额、履行、催告和损失信息；
4. 列出材料之间的重复、矛盾和缺失；
5. 所有候选内容都等待我对照原件确认，不要自动认定事实。
```

对于聊天记录、音视频、电子合同和转账材料，应保留完整原件、形成时间、来源主体和上下文。不要只保留截图、转码文件或重新保存的副本。

### 第五步：整理证据

建议使用稳定编号，并按时间线和证明目的交叉检查：

| 编号 | 材料 | 形成时间 | 拟证明事项 | 原件状态 | 风险 |
|---|---|---|---|---|---|
| `E-001` | 合同 | 2025-03-01 | 双方权利义务 | 有纸质原件 | 检查签章和附件 |
| `E-002` | 转账记录 | 2025-03-03 | 已支付合同款 | 有电子原件 | 关联收款主体 |
| `E-003` | 催告聊天记录 | 2025-04-15 | 已催告履行 | 有完整导出 | 核对账号归属 |

本地材料推荐分层保存：

```text
01-originals/       原始电子文件或纸质原件扫描件
02-working-copies/  脱敏、标注、转写和分页副本
03-filing-copies/   按受理机构要求生成的提交副本
```

证据目录、诉状引用和附件文件名应始终使用同一编号。

### 第六步：生成和校验文书

```text
请使用 china-legal 完成法源、案例和引用核验，再使用 china-legal-local：
1. 生成民事起诉状草案；
2. 生成诉讼请求和金额计算表；
3. 生成证据目录；
4. 校验主体、请求、金额、证据编号和法源引用；
5. 将不确定内容标记为“待确认”，不要自行补全；
6. 导出 DOCX 待专业人员复核。
```

正式提交前至少核对：

- 当事人主体、身份、地址和联系方式。
- 管辖法院、案由、程序类型及仲裁约定。
- 诉讼请求是否明确、完整且可执行。
- 金额、利率、起算日、截止日和诉讼费依据。
- 每项事实是否对应证据，编号和附件是否一致。
- 时效、保全、送达、签名、日期和副本数量。
- 受理法院或主管机关的最新格式要求。

## 常见问题

- **本地 MCP 无法启动**：macOS 或 Linux 重新运行平台包中的 `./install.sh`；Windows 重新运行 `install.ps1`，然后重启客户端。
- **文件不在允许范围**：把材料放入当前项目的 `.china-legal/evidence/`。
- **扫描件识别不准确**：提高扫描清晰度和方向正确性，并逐页对照原件。
- **远程状态不健康**：停止输出实质法律结论，等待法规库或案例库恢复。
- **法规更新检查失败**：不能据此声称法源当前有效。
- **返回 429**：按 `Retry-After` 等待后重试，不要并发批量抓取。

## 能力边界

系统不提供：

- 证据真实性、合法性或可采性认定。
- 自动选择法律期限、利率、案由、法院或程序。
- 自动立案、签名、支付或法院提交。
- 律师代理、结果保证或法院受理保证。

所有重要结论和正式材料均须人工确认。涉及刑事风险、行政执法、人身安全、未成年人、重大金额、财产保全、破产、跨境事项或临近期限时，应及时获得具备资格的专业协助。

## 仓库内容

```text
skills/china-legal-assistant/  Agent Skill 与工作流
managed-mcp.generic.json       可直接使用的双 MCP 配置
managed-mcp.windows.json       Windows 双 MCP 配置
install.sh / install.ps1       平台包中的一键安装器
policies/                      隐私、条款和安全政策
release-manifest.json          版本与公开边界
LICENSE                        Apache License 2.0
```

公开 Git 仓库中的安装器是完整平台安装器的公开源文件；仓库本身没有 `china-legal-local` 二进制，直接运行会停止并提示下载对应平台的 Release 包。

公开 Git 仓库不包含本地程序二进制及其源码、服务端源码、生产数据库、审核归档、备份、API Key 或私钥。每个平台的 Release 包包含公开分发 `china-legal-local` 可执行文件，但不包含其源码或上述私有资产。

## License

公开仓库中的 Skill、配置、安装器和文档，以及 Release 包中的 `china-legal-local` 可执行文件，统一采用[Apache License 2.0](LICENSE)。本地程序源码、服务端实现、生产数据和其他私有制品不随公开仓库或 Release 包提供。

# Agent Lead

> 轻量级、可移植的多 Agent 协作 Skill。**不新增平台、不依赖 MCP、不接管现有 API/Provider 配置。**

Agent Lead 面向 Codex Desktop 等编码代理环境，让复杂研发任务可以按依赖进行分工、并行分析/开发、统一验证；简单任务保持单 Agent。它**不是**一个自动跨 DeepSeek、GLM、Qwen、Codex、Claude Provider 的模型路由器。

## 安装

本仓库已包含 `.agents/skills/agent-lead/`，在 Codex Desktop 打开本仓库时可按项目级 Skill 发现；其他项目不会自动获得该 Skill。若需要在公司项目中复用，请将该目录复制或链接到目标项目。

在项目根目录将本仓库的 Skill 文件夹复制或链接到：

```text
<项目>/.agents/skills/agent-lead/
├── SKILL.md
└── references/
    └── model-routing.md
```

也可以安装在用户级 `~/.agents/skills/agent-lead/`（Windows 对应用户主目录下的 `.agents\\skills\\agent-lead`），具体以当前 Codex 版本和组织配置支持的 Skill 搜索路径为准。

**不要**直接复制本仓库的 Git 元数据；安装只需 `SKILL.md` 和 `references/`，`AGENTS.md` 用于维护本仓库，不会自动替换公司项目规则。

## 使用

```text
$agent-lead 根据当前项目需求判断是否需要多 Agent 协作，完成分析、实施、评审和最终验收。模式=auto，模型=auto，推理强度=auto，并发=auto。
```

也可以按任务覆盖：

```text
$agent-lead 设计并实现登录模块。模式=multi，并发=2，评审推理强度=high。
```

如没有真实的原生子 Agent 能力，就使用单 Agent 或明确的多会话协作，不要把连续执行叫做并行。

## 工作原则

- 单 Agent 优先；只有具备独立工作边界和实际收益才启动多个 Agent。
- 动态参考当前**已验证可用**模型和推理档位，不写死模型名，不擅自扫描有计费的 API。
- `auto` 按任务复杂度推荐推理强度；用户显式指定的模型和强度不能被静默替换。
- 原生子 Agent、独立 Worktree 会话、Claude CLI 是不同执行方式，不能混为一谈。
- 只读分析可并行，涉及接口依赖的代码修改和最终集成测试要遵守先后顺序。
- 不保存密钥、不读取私人配置凭证、不未经授权向外部服务传递公司代码。

详细规则见 [SKILL.md](SKILL.md) 和 [模型与推理策略](references/model-routing.md)。

## 验收方式

将 Skill 安装到一个**允许读写的测试仓库**，先发出只读任务：

```text
$agent-lead 检查当前仓库的模块结构和测试风险。禁止修改文件。报告是否真实启用子 Agent、模型及推理强度是否经过确认。
```

然后再选一个有明确接口边界的真实需求验证开发与回归测试。Skill 文件静态校验通过 **不等于** 多模型 API、子 Agent 或外部 CLI 已经实测可用。

## 兼容性说明

Codex Desktop、CLI、各模型网关与厂商的模型/推理强度能力会变化。Agent Lead 优先读取环境的能力与明确授权配置，不能从一个 Skill 文件自动更新或修改所有 API Provider。

## 校验与开源许可

使用 PowerShell 7 或 Windows PowerShell 运行 `scripts/validate-skill.ps1`，检查 Skill 元数据、安装目录与源码一致性、参考文件及许可证。GitHub Actions 执行同一静态校验；这不代表已完成真实多模型调用或子 Agent 协作测试。

本项目使用 [MIT License](LICENSE)。

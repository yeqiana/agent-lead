# Agent Lead 维护说明

- 仓库只维护轻量级 Skill 和少量说明文档，避免变成独立 Agent 平台。
- 不提交密钥、令牌、公司私有模型端点、真实内部项目代码或个人设备配置。
- 不修改使用方的全局 Codex/Claude 模型 Provider 配置。
- 如更新模型能力说明，必须区分已验证支持、仅文档支持和未知；不可将建议值写成保证值。
- 修改后核查 YAML frontmatter、相对路径、安装路径、安全边界与 Git diff。

Git 提交信息使用中文、三段格式：

```text
feat: 增加协作能力

协作流程,模型策略

Agent Lead
```

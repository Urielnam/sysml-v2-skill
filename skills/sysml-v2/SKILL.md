---
name: sysml-v2
description: >-
  Author, validate, and architect complex Systems Modeling Language v2 (SysML v2) models
  and printable vector PDF Architecture Atlases. Includes 5-Domain Alternative Architecture
  decomposition (D1 Stakeholders & Needs, D5 OPM ConOps, D2 Capabilities & Grounded Requirements,
  D3 N-Candidate COTS Trade Space), Two-Tier Formal Inheritance, recursive subsystem in-zooming,
  ASD-STE100 simplified technical writing, Miller's Law (<= 9 nodes) micro-viewing, Spec42
  compiler integration, and automated 35-rule PDF Atlas generation.
---

# SysML v2 Systems Engineering & Architecture Atlas Skill (v2.0)

This skill orchestrates the end-to-end authoring, academic/industrial grounding, trade-off evaluation, Spec42 verification, and printable vector PDF Atlas generation for complex systems using **OMG SysML v2** textual notation (`.sysml`).

---

## 1. Skill Package Structure & Progressive Disclosure

Before executing any domain stage, read the corresponding reference and workflow playbook inside this skill directory (`C:\Users\yurie\.gemini\config\plugins\sysml-v2\skills\sysml-v2\`):

* **References (`references/`)**:
  * [`references/templates.sysml`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/references/templates.sysml): **Mandatory Normative Metamodel Contract**. Defines the exact base metaclasses and attribute names parsed by `scripts/sysml_atlas_generator.py`.
  * [`references/opm_sysml_metamodel.md`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/references/opm_sysml_metamodel.md): ISO 19450 Object-Process Methodology (OPM) to SysML v2 mapping rules and Two-Tier Specialization invariant.
  * [`references/subsystem_zooming_guide.md`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/references/subsystem_zooming_guide.md): Recursive subsystem in-zooming and parent-to-child boundary hand-off rules.
* **Stage Playbooks (`workflows/`)**:
  * [`workflows/d1_stakeholders_goals.md`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/workflows/d1_stakeholders_goals.md): Stage 1 — Stakeholders, Operational Goals, Gaps, and Needs (`D1_StakeholdersAndNeeds.sysml`).
  * [`workflows/d5_conops_derivation.md`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/workflows/d5_conops_derivation.md): Stage 2 — ConOps Activities, Operands, States, Operators, and Structures (`D5_MissionsAndConOps.sysml`).
  * [`workflows/d2_problem_functionality.md`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/workflows/d2_problem_functionality.md): Stage 3 — Solution-Neutral Capabilities, Functionalities, and Grounded Requirements (`D2_Capabilities.sysml`).
  * [`workflows/d3_solution_trades.md`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/workflows/d3_solution_trades.md): Stage 4 — $N$-Candidate COTS Trade Space, Pugh Evaluation, and Integrated System Baseline (`D3_SolutionCandidates.sysml`).
  * [`workflows/subsystem_iteration.md`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/workflows/subsystem_iteration.md): Stage 5 — Iterative Subsystem Zoom-In (`subsystems/<subsystem_slug>/`).
* **Automated Visualization Pipeline (`scripts/`)**:
  * [`scripts/sysml_atlas_generator.py`](file:///C:/Users/yurie/.gemini/config/plugins/sysml-v2/skills/sysml-v2/scripts/sysml_atlas_generator.py): Dynamic `.sysml` parser and 35-rule printable black-over-white vector PDF Architecture Atlas generator.

---

## 2. Core Execution Invariants (Mandatory)

1. **Subagent Orchestration (Max 3 Concurrent)**:
   * Whenever performing domain discovery, literature/benchmark research, or COTS trade studies, spawn specialized subagents with only the required upstream context.
   * **Never exceed 3 concurrent subagents** at any time; wait for one to finish before spawning another.
2. **Two-Tier Formal Inheritance (Zero Unrefined Leaf Abstractions)**:
   * Never discard brainstormed specific items into temporary scratchpads.
   * Every generalized group (Tier 1, specializing the base metaclass, e.g., `part def DomesticBalconyUser :> Stakeholder`) **MUST** have its specific brainstormed items formally committed in the `.sysml` file as Tier 2 specializations (`part def RemoteWorkerOnBalcony :> DomesticBalconyUser`).
   * Any Tier 1 element with 0 Tier 2 children is flagged as an `«unrefinedElementError»` block in the generated PDF Atlas.
3. **Full $N$-Candidate Trade Space Persistence**:
   * In Domain 3 (`D3_SolutionCandidates.sysml`), persist **all $N$ evaluated solution candidates per functionality** (e.g., $N = 6$ candidates per functionality, or any user-specified $N$) with explicit `CandidateStatus` (`Winner`, `RunnerUp`, `Pruned`, `Rejected`), Pugh sub-scores, BoM cost, and rejection/selection rationale.
   * The Atlas Generator dynamically constructs $R \times N$ comparison matrices (View Rule 34, automatically paginating columns if $N > 6$).
4. **Strict Model-as-Truth (Zero Intermediate HTML)**:
   * Embed all physics equations, academic citations, active Crossref DOIs (`https://doi.org/...`), COTS distributor links, empirical benchmarks, and compliance margins directly into `.sysml` attributes. Never create standalone HTML research scratchpads.
5. **ASD-STE100 Simplified Technical English**:
   * Keep sentences under 20 words for instructions and under 25 words for descriptions.
   * Express one technical fact per sentence using active voice and present tense (`"The sensor detects targets"`, `"The system shall limit..."`).
6. **Clean Semantic Identifiers (No Hungarian Notation)**:
   * Use `PascalCase` for definitions (`OperationalNeed`, `DualFIRmmWavePerceptionNode`) and `camelCase` for usages (`avianDetectionRange`, `perceptionNode`).
   * Never prefix names with type tags (`req_`, `goal_`, `gap_`, `need_`, `part_`).
7. **Formal Stakeholder & Subject Metadata**:
   * Use `stakeholder <role> : <StakeholderType>;` for actors/stakeholders and `subject <sys> : <SystemType>;` for systems. Never invert them.

---

## 3. Five-Domain Workspace Architecture & 1-to-1 Package Rule

Every system (or zoomed-in subsystem) workspace follows a strict 1-to-1 file-to-package mapping:

```text
workspace/
├── D1_StakeholdersAndNeeds.sysml  # package D1_StakeholdersAndNeeds
├── D5_MissionsAndConOps.sysml     # package D5_MissionsAndConOps
├── D2_Capabilities.sysml          # package D2_Capabilities
├── D3_SolutionCandidates.sysml    # package D3_SolutionCandidates
├── Views.sysml                    # package Views
├── main.sysml                     # package Main (root integration)
└── subsystems/                    # Optional: Recursive Level 1 Subsystem models
    └── <subsystem_slug>/
        ├── D1_StakeholdersAndNeeds.sysml
        ├── D5_MissionsAndConOps.sysml
        ├── D2_Capabilities.sysml
        ├── D3_SolutionCandidates.sysml
        ├── Views.sysml
        └── main.sysml
```

---

## 4. Phase Gate Validation & PDF Atlas Generation Policy

### Gate A: Spec42 Compiler Validation (After Every Step — Must Be 0 Errors)
```powershell
& "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
```
Do not advance to the next domain stage until `spec42 check .` reports **0 errors, 0 warnings**.

### Gate B: Canonical Vector PDF Architecture Atlas Generation (Upon Model Completion)
Run the bundled Python generator to dynamically parse the `.sysml` files, expand all 35 projection rules (Miller's Law $\le 9$ nodes per page, multi-column balanced grids, live clickable links), and verify 100% node/edge coverage:
```powershell
python "C:\Users\yurie\.gemini\config\plugins\sysml-v2\skills\sysml-v2\scripts\sysml_atlas_generator.py" `
  --model-dir "." `
  --output-pdf "architecture_atlas_canonical.pdf" `
  --diagrams-dir "diagrams_canonical"
```

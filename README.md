# SysML v2 Systems Engineering & Architecture Atlas Skill (`v2.1.0`)

An industrial-grade Model-Based Systems Engineering (MBSE) plugin and skill package for authoring, validating, grounding, and visualizing **OMG SysML v2** models (`.sysml`) using the **5-Domain Alternative Architecture** methodology, **ISO 19450 Object-Process Methodology (OPM)**, **Spec42** static analysis, and an automated **35-Rule Printable Vector PDF Architecture Atlas Generator**.

---

## Installation & Setup

### 1. Install the Plugin / Skill

#### Option A: Global Plugin Installation (Recommended — Available in All Workspaces)
Clone this repository directly into your global Antigravity plugins directory (`~/.gemini/config/plugins/sysml-v2`), then restart the IDE/agent session so the plugin is discovered:

**Windows (PowerShell):**
```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.gemini\config\plugins" | Out-Null
git clone https://github.com/Urielnam/sysml-v2-skill.git "$HOME\.gemini\config\plugins\sysml-v2"
```

**macOS / Linux (Bash):**
```bash
mkdir -p ~/.gemini/config/plugins
git clone https://github.com/Urielnam/sysml-v2-skill.git ~/.gemini/config/plugins/sysml-v2
```

#### Option B: Workspace-Scoped Skill Installation (Project-Specific)
To bundle the skill inside a single project repository so it is version-controlled with your team's model under `.agents/skills/sysml-v2`:

**Windows (PowerShell):**
```powershell
New-Item -ItemType Directory -Force -Path ".agents\skills" | Out-Null
git clone https://github.com/Urielnam/sysml-v2-skill.git _tmp_sysml
Move-Item "_tmp_sysml\skills\sysml-v2" ".agents\skills\sysml-v2"
Remove-Item -Recurse -Force _tmp_sysml
```

**macOS / Linux (Bash):**
```bash
mkdir -p .agents/skills
git clone https://github.com/Urielnam/sysml-v2-skill.git _tmp_sysml
mv _tmp_sysml/skills/sysml-v2 .agents/skills/sysml-v2
rm -rf _tmp_sysml
```

---

### 2. Install Toolchain Prerequisites

To validate `.sysml` models and compile the printable vector PDF Architecture Atlas, install the following local tools:

1. **Spec42 SysML v2 Compiler & VS Code Extension**:
   - Install the **Spec42** extension (`elan8.spec42`) from the VS Code Marketplace.
   - The CLI binary is automatically placed at:
     `~/.vscode/extensions/elan8.spec42-*/server/win32-x64/spec42.exe`
2. **Python 3.10+ & `pypdf`**:
   ```powershell
   pip install pypdf
   ```
3. **Graphviz (`dot` layout engine)**:
   - **Windows**: `winget install Graphviz.Graphviz` (default path: `C:\Program Files\Graphviz\bin\dot.exe`)
   - **macOS**: `brew install graphviz`
   - **Linux**: `sudo apt install graphviz`
4. **Microsoft Edge** (used in headless mode `--headless --print-to-pdf` to preserve vector graphics and clickable PDF hyperlinks).

---

### 3. Verify Installation

1. Restart your Antigravity session so `sysml-v2` appears in your active skills list.
2. Test the Atlas Generator CLI help:
   ```powershell
   python "$HOME\.gemini\config\plugins\sysml-v2\skills\sysml-v2\scripts\sysml_atlas_generator.py" --help
   ```

---

## Repository Structure

```text
sysml-v2/
├── plugin.json                                     # Plugin manifest (v2.1.0)
├── README.md                                       # Documentation & Master Prompts
└── skills/
    └── sysml-v2/
        ├── SKILL.md                                # Master skill orchestrator & invariants
        ├── references/
        │   ├── templates.sysml                     # Normative SysML v2 metamodel contract
        │   ├── opm_sysml_metamodel.md              # ISO 19450 (OPM) to SysML v2 mapping
        │   └── subsystem_zooming_guide.md          # Recursive subsystem in-zooming guide
        ├── workflows/
        │   ├── d1_stakeholders_goals.md            # Stage 1 Playbook: Stakeholders -> Goals -> Gaps -> Needs
        │   ├── d5_conops_derivation.md             # Stage 2 Playbook: Activities -> Operands/States -> Links
        │   ├── d2_problem_functionality.md         # Stage 3 Playbook: Capabilities -> Functions -> Reqs
        │   ├── d3_solution_trades.md               # Stage 4 Playbook: N-Candidate Trade Space -> Pugh Matrix
        │   └── subsystem_iteration.md              # Stage 5 Playbook: Iterative Subsystem Zoom-In
        └── scripts/
            └── sysml_atlas_generator.py            # Dynamic .sysml parser & 35-rule Vector PDF Generator
```

---

## Key Capabilities & Architectural Invariants

1. **Strict Progressive Micro-Step Sequentiality (Hard `spec42` Barrier After Every Step)**:
   - Each micro-step (`Stakeholders` $\rightarrow$ `Goals` $\rightarrow$ `Gaps` $\rightarrow$ `Needs` $\rightarrow$ `Activities` $\rightarrow$ `Operands/States/Operators/Structures` $\rightarrow$ `Capabilities` $\rightarrow$ `Functionalities` $\rightarrow$ `Requirements` $\rightarrow$ `Candidates` $\rightarrow$ `Integrated System`) **must** finish its subagent(s), commit its `.sysml` code, and pass `spec42 check .` (`0 errors`) **before** the next micro-step's subagents are spawned.
   - **Never parallelize vertically across dependent steps** (e.g., never spawn a Goals agent while the Stakeholders agent is still running). Only parallelize horizontally *within* the same micro-step (up to 3 concurrent subagents) after the parent elements are already committed and validated in `.sysml`.
2. **Two-Tier Formal Inheritance (`SpecificX :> GeneralizedX`)**:
   - Brainstormed specific elements (Tier 2) are formally committed as specializations of the 5–7 generalized abstractions (Tier 1). Unrefined Tier 1 abstractions are automatically detected and flagged as red `«unrefinedElementError»` diagnostic blocks in the PDF Atlas.
3. **Dynamic $N$-Candidate Trade Matrices**:
   - `sysml_atlas_generator.py` dynamically parses any number of candidates ($N$) per functionality and renders $R \times N$ comparison matrices (paginating columns automatically when $N > 6$).
4. **Strict Model-as-Truth (Zero Intermediate HTML)**:
   - All equations, DOIs, distributor links, and Pugh scores live inside `.sysml` attributes.

---

## Automated PDF Architecture Atlas Generator (`sysml_atlas_generator.py`)

```powershell
python skills/sysml-v2/scripts/sysml_atlas_generator.py `
  --model-dir "path/to/sysml-workspace" `
  --output-pdf "path/to/sysml-workspace/architecture_atlas_canonical.pdf" `
  --diagrams-dir "path/to/sysml-workspace/diagrams_canonical"
```

---

## Master Prompts

### Master Prompt A: Greenfield System Engineering (End-to-End Progressive Execution)

Copy and paste the prompt below to construct a complete, grounded 5-Domain SysML v2 model progressively step-by-step and compile its printable PDF Architecture Atlas:

```markdown
You are going to construct a complete, grounded Model-Based Systems Engineering (MBSE) architecture in SysML v2 using the `sysml-v2` skill.
Before starting each stage, read the `sysml-v2` skill (`SKILL.md`, `references/templates.sysml`, and the stage playbook in `workflows/`).

### Orchestration & Modeling Rules (Mandatory)
1. **STRICT PROGRESSIVE EXECUTION (One Micro-Step at a Time — Hard Barrier Between Steps)**:
   - **NEVER** spawn subagents for two different micro-steps simultaneously (for example: NEVER spawn a Goals subagent while the Stakeholders subagent is still running; NEVER spawn a Gaps subagent before Goals are written to `.sysml` and validated with `spec42`; NEVER spawn a Needs subagent before Gaps are written and validated).
   - Every single numbered step below must follow this strict 4-part cycle before moving to the next numbered step:
     **(a) Spawn** subagent(s) for the current step ONLY (passing the already-committed parent definitions from `.sysml`) -> **(b) Wait** for completion -> **(c) Commit** both Tier 1 Generalized and Tier 2 Specific elements to the `.sysml` file -> **(d) Validate** with `spec42 check .` (must return `0 errors, 0 warnings`).
   - **Horizontal Parallelism (Max 3 Concurrent Subagents)**: You may only spawn up to 3 subagents in parallel *within the same numbered step* after the upstream parent elements are already committed and validated in `.sysml`.
2. **Two-Tier Formal Inheritance (Zero Scratchpad Pruning)**: Every time you generate specific items (stakeholders, goals, gaps, needs, capabilities, or functionalities) and group them into 5–7 generalized groups, commit **both** tiers to the `.sysml` file:
   - Tier 1 (Generalized Group): `:> <BaseMetaclass>` (e.g., `part def DomesticBalconyUser :> Stakeholder`)
   - Tier 2 (Specific Items): `:> <GeneralizedGroup>` (e.g., `part def RemoteWorkerOnBalcony :> DomesticBalconyUser`)
   Never leave a generalized element without specific specializations in the `.sysml` model.
3. **Strict Model-as-Truth (Zero Intermediate HTML)**: Embed all academic citations, active Crossref DOIs (`https://doi.org/...`), physics formulas, verified benchmarks, compliance margins, and COTS distributor URLs directly into `.sysml` attributes as defined in `references/templates.sysml`. Do not create intermediate `.html` files.

### System Value Framing
`[<Beneficiary Stakeholder>] derives value when [<System-of-Interest>] executes [<Primary Value-Delivering Process>]`

---

### Stage 1 — D1: Stakeholders, Goals, Gaps, and Operational Needs (`D1_StakeholdersAndNeeds.sysml`)
Follow `workflows/d1_stakeholders_goals.md` and `references/templates.sysml` strictly one micro-step at a time:
- **Micro-Step 1.1 (Stakeholders ONLY)**: Spawn a Stakeholder specialist to generate specific stakeholders across the lifecycle and cluster them into 5–7 Generalized Stakeholder groups (`:> Stakeholder`), ensuring lifecycle stakeholders (Purchaser/Budget Holder, DIY Fabricator/Installer, Maintenance Operator, Regulatory/Governance Authority) are represented alongside operational users. Wait for completion, write both Tier 1 (`:> Stakeholder`) and Tier 2 (`:> <GeneralizedStakeholder>`) to `D1_StakeholdersAndNeeds.sysml`, and run `spec42 check .` (0 errors). **STOP and do not spawn Goal agents until Gate 1.1 passes.**
- **Micro-Step 1.2 (Operational Goals ONLY)**: Using the validated 5–7 Generalized Stakeholders from Step 1.1, spawn 1–3 Goal specialists to generate specific goals and cluster them into 5–7 Generalized Operational Goals (`requirement def ... :> OperationalGoal`). Mandate at least one **Economic/LCC Goal** (CapEx, OpEx, 5-year LCC) and one **Feasibility/Adoption Goal** (DIY Assembly time with hand tools, non-invasive mounting). Wait for completion, append both Tier 1 and Tier 2 goals (linked via `stakeholder <role> : <Stakeholder>;`) to `D1_StakeholdersAndNeeds.sysml`, and run `spec42 check .` (0 errors). **STOP and do not spawn Gap agents until Gate 1.2 passes.**
- **Micro-Step 1.3 (Operational Gaps ONLY)**: Using the validated 5–7 Generalized Goals from Step 1.2, spawn 1–3 Gap specialists to generate specific gaps and cluster them into 5–7 Generalized Operational Gaps (`concern def ... :> OperationalGap` with `attribute :>> obstructedGoal = "<Goal>";`). Wait for completion, append both Tier 1 and Tier 2 gaps to `D1_StakeholdersAndNeeds.sysml`, and run `spec42 check .` (0 errors). **STOP and do not spawn Need agents until Gate 1.3 passes.**
- **Micro-Step 1.4 (Operational Needs ONLY)**: Using the validated 5–7 Generalized Gaps from Step 1.3, spawn 1–3 Need specialists to generate specific operational needs and cluster them into 5–7 Generalized Operational Needs (`requirement def ... :> OperationalNeed` with `attribute :>> mitigatedGap = "<Gap>";` and `stakeholder` bindings). Wait for completion, append both Tier 1 and Tier 2 needs to `D1_StakeholdersAndNeeds.sysml`, and run `spec42 check .` (0 errors). **STOP and do not start Stage 2 until Gate 1.4 passes.**

---

### Stage 2 — D5: Concept of Operations (`D5_MissionsAndConOps.sysml`)
Follow `workflows/d5_conops_derivation.md` and `references/opm_sysml_metamodel.md` strictly one micro-step at a time:
- **Micro-Step 2.1 (Main Activities ONLY)**: Spawn an Activity specialist to generate operational activities and cluster them into 5–7 Generalized Main Activities (`action def ... :> OperationalActivity`) sequenced in `action def <System>ConOps`. Wait for completion, write to `D5_MissionsAndConOps.sysml`, and run `spec42 check .` (0 errors). **STOP until Gate 2.1 passes.**
- **Micro-Step 2.2 (Operands, States, Operators, Structures)**: Using the validated Activities from Step 2.1, spawn 1–2 specialists to generate and cluster 5–7 Generalized Operands (`:> OperationalOperand`), 5–7 Generalized States (`:> OperationalState`), 5–7 Generalized Enabling Operators (`:> EnablingOperator`), and 5–7 Generalized Enabling Structures (`:> EnablingStructure`). Wait for completion, write to `D5_MissionsAndConOps.sysml`, and run `spec42 check .` (0 errors). **STOP until Gate 2.2 passes.**
- **Micro-Step 2.3 (Goal & Gap Process Links)**: Formally connect how the generalized activities address the D1 Goals (`addressesGoal`) and where the D1 Gaps affect the process (`affectedByGap`), update `D5_MissionsAndConOps.sysml`, and run `spec42 check .` (0 errors). **STOP until Gate 2.3 passes.**

---

### Stage 3 — D2: Problem-Solving Functionality & Grounded Requirements (`D2_Capabilities.sysml`)
Follow `workflows/d2_problem_functionality.md` strictly one micro-step at a time:
- **Micro-Step 3.1 (Capabilities ONLY)**: Using the validated D1 Goals, spawn 1–2 Capability specialists to extract solution-neutral capabilities via user stories and cluster into 5–7 Generalized Capabilities (`action def ... :> SystemCapability`). Wait for completion, write both Tier 1 and Tier 2 capabilities to `D2_Capabilities.sysml`, and run `spec42 check .` (0 errors). **STOP until Gate 3.1 passes.**
- **Micro-Step 3.2 (Problem-Solving Functionalities & Requirement Groups ONLY)**: Using the validated Capabilities from Step 3.1, spawn 1–2 Functionality specialists to decompose into specific functions and cluster into 5–7 Generalized System Functionalities (`action def ... :> SystemFunctionality`), plus 5–7 Requirement Groups (`:> RequirementGroup`). Wait for completion, write both Tier 1 and Tier 2 functionalities and requirement groups to `D2_Capabilities.sysml`, and run `spec42 check .` (0 errors). **STOP until Gate 3.2 passes.**
- **Micro-Step 3.3 (Grounded Quantitative System Requirements)**: Using the validated Functionalities and Requirement Groups from Step 3.2, spawn up to 3 Requirement & Physics Research specialists in parallel to formulate 5–9 quantitative, testable `SystemRequirement`s per group, populating all 13 contract attributes (`reqId`, `statement`, `quantitativeMetric`, `verificationMethod`, `standardOrCitation`, `doiOrUrl` with active clickable URLs, `atomicSpec`, `physicsFormula`, `verifiedBenchmark`, `complianceMargin`, `requirementGroup`, `allocatedFunctionality`, `parentNeed`). Wait for completion, commit to `D2_Capabilities.sysml`, and run `spec42 check .` (0 errors). **STOP until Gate 3.3 passes.**

---

### Stage 4 — D3: $N$-Candidate Trade Space, COTS Selection, & Pugh Evaluation (`D3_SolutionCandidates.sysml`)
Follow `workflows/d3_solution_trades.md` strictly one micro-step at a time:
- **Micro-Step 4.1 ($N$ Candidates per Functionality & COTS BoMs)**: Using the validated Functionalities and Requirements from Stage 3, spawn up to 3 COTS Trade specialists in parallel to generate $N = 6$ distinct solution candidates per functionality (`part def ... :> SolutionCandidate`), persisting **all $N$ candidates** with `CandidateStatus` (`Winner`, `RunnerUp`, `Pruned`, `Rejected`), Pugh sub-scores, BoM cost, rationale, environmental sensitivity profiles, and nested `COTSComponent` parts with real MPNs and clickable distributor links. Wait for completion, write to `D3_SolutionCandidates.sysml`, and run `spec42 check .` (0 errors). **STOP until Gate 4.1 passes.**
- **Micro-Step 4.2 (Integrated System Baseline & `satisfy` Traceability Matrix)**: Synthesize `Integrated<System>Candidate :> SolutionCandidate` (`primaryFunctionality = "IntegratedSystem"`) composing the winning sub-assemblies, declare explicit `satisfy <requirement> by <candidate>;` statements for all evaluated candidates, and run `spec42 check .` (0 errors).

---

### Stage 5 — Compile Printable Vector PDF Architecture Atlas
Run the bundled `sysml_atlas_generator.py` script on the workspace:
`python "C:\Users\yurie\.gemini\config\plugins\sysml-v2\skills\sysml-v2\scripts\sysml_atlas_generator.py" --model-dir . --output-pdf architecture_atlas_canonical.pdf`
Verify 100% node/edge coverage, 0 unrefined error blocks, all $N$-candidate trade matrices, and clickable links in the compiled PDF.
```

---

### Master Prompt B: Iterative Subsystem Zoom-In (Capability/Functionality $\rightarrow$ Subsystem)

Copy and paste the prompt below when you have an existing model and want to zoom in on a specific capability or functionality and engineer it progressively as a subsystem:

```markdown
We have an existing validated SysML v2 system architecture in this workspace.
I want to **zoom in on the capability/functionality `<TargetCapabilityOrFunctionalityName>`** as a standalone **Subsystem-of-Interest (Level 1)** and perform full 5-Domain Systems Engineering for it progressively.

Read and follow `workflows/subsystem_iteration.md` and `references/subsystem_zooming_guide.md` in the `sysml-v2` skill:

1. **Extract Parent Boundary Contract**:
   - Inspect the parent model (`D1`, `D5`, `D2`, `D3`) to extract all parent requirements, physical interfaces, power/latency budgets, CapEx allocation, and assembly time allocation assigned to `<TargetCapabilityOrFunctionalityName>` and its winning candidate.
   - Formulate the Level 1 Subsystem Framing Sentence:
     `[<Parent Host System>] derives value when [<Target Subsystem>] executes [<Target Functionality>]`
2. **Create Subsystem Workspace**:
   - Create `subsystems/<subsystem_slug>/` containing `D1_StakeholdersAndNeeds.sysml`, `D5_MissionsAndConOps.sysml`, `D2_Capabilities.sysml`, `D3_SolutionCandidates.sysml`, `Views.sysml`, and `main.sysml`.
3. **Execute the 12 Micro-Steps Strictly Sequentially (One Micro-Step at a Time with `spec42 check` After Every Step)**:
   - Never spawn subagents across different micro-steps simultaneously. Complete, commit, and run `spec42 check "subsystems/<subsystem_slug>"` (0 errors) after **each** individual micro-step before spawning the next step's subagent:
     1. **D1.1 Subsystem Stakeholders ONLY** (Tier 1 & Tier 2) -> commit & `spec42 check`
     2. **D1.2 Subsystem Goals ONLY** (Tier 1 & Tier 2, inheriting parent budget ceilings) -> commit & `spec42 check`
     3. **D1.3 Subsystem Gaps ONLY** (Tier 1 & Tier 2) -> commit & `spec42 check`
     4. **D1.4 Subsystem Needs ONLY** (Tier 1 & Tier 2) -> commit & `spec42 check`
     5. **D5.1 Subsystem In-Zoomed Activities ONLY** -> commit & `spec42 check`
     6. **D5.2 Subsystem Operands, States, Operators, Structures** -> commit & `spec42 check`
     7. **D5.3 Subsystem Activity-to-Goal/Gap Links** -> commit & `spec42 check`
     8. **D2.1 Subsystem Capabilities ONLY** (Tier 1 & Tier 2) -> commit & `spec42 check`
     9. **D2.2 Subsystem Functionalities & Requirement Groups ONLY** (Tier 1 & Tier 2) -> commit & `spec42 check`
     10. **D2.3 Subsystem Grounded Requirements** (formulas, benchmarks, DOIs, sub-budgets summing to parent budget) -> commit & `spec42 check`
     11. **D3.1 Subsystem $N$-Candidate Trade Space & COTS BoMs** -> commit & `spec42 check`
     12. **D3.2 Subsystem Integrated Baseline & `satisfy` Links** -> commit & `spec42 check`
4. **Generate Subsystem PDF Atlas**:
   - Run `sysml_atlas_generator.py --model-dir "subsystems/<subsystem_slug>" --output-pdf "subsystems/<subsystem_slug>/subsystem_architecture_atlas.pdf"` and verify 100% node/edge coverage and 0 unrefined errors.
```
